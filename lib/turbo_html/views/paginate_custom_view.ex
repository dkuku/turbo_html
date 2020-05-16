defmodule Turbo.HTML.Views.PaginateCustomView do
  @moduledoc false

  use Turbo.HTML.ThemeAdapter.Custom

  @default_opts [
    max_page_links: 5,
    previous_label: "<<",
    first_label: "First",
    next_label: ">>",
    last_label: "Last",
    parent_class: "parent",
    disabled_class: "disabled",
    active_class: "active",
    normal_class: "normal",
    class: ""
  ]

  @doc """
  Returns the pagination view.
  """
  @spec pagination_links(Map.t(), Map.t(), Keyword.t()) :: any()
  def pagination_links(conn, paginate, opts) do
    merged_opts = Keyword.merge(@default_opts, opts)
    parent_class = opts[:parent_class]

    pagination_links(parent_class,
      do:
        [] ++
          [first_page_link(conn, paginate, merged_opts)] ++
          [previous_page_link(conn, paginate, merged_opts)] ++
          middle_page_links(conn, paginate, merged_opts) ++
          [next_page_link(conn, paginate, merged_opts)] ++
          [last_page_link(conn, paginate, merged_opts)]
    )
  end

  @doc """
  Returns the first page link.

  ## Example

      # iex> conn = %{params: %{}, path_info: ["users"]}
      # iex> paginate = %{current_page: 10, next_page: 11, per_page: 5, prev_page: 9, total_count: 100, total_pages: 20}
      # iex> default_opts = [max_page_links: 10, previous_label: "<<", first_label: "First", next_label: ">>", last_label: "Last"]
      # iex> Turbo.HTML.Views.PaginateView.first_page_link(conn, paginate, default_opts) |> Phoenix.HTML.safe_to_string()
      # "<li class=\"page-item\"><a class=\"page-link\" href=\"/users?page=1\">First</a></li>"

  """
  @spec first_page_link(Map.t(), Map.t(), Keyword.t()) :: any()
  def first_page_link(conn, %{current_page: current_page}, opts) do
    label = opts[:first_label]
    disabled_class = opts[:class] <> " " <> opts[:disabled_class]
    normal_class = opts[:class] <> " " <> opts[:normal_class]

    case current_page == 1 do
      true ->
        page_link("#", :disabled, do: label, class: disabled_class)

      false ->
        page_link(gen_href(conn, 1), do: label, class: normal_class)
    end
  end

  def previous_page_link(conn, %{current_page: current_page, prev_page: prev_page}, opts) do
    label = opts[:previous_label]
    disabled_class = opts[:class] <> " " <> opts[:disabled_class]
    normal_class = opts[:class] <> " " <> opts[:normal_class]

    case current_page <= 1 do
      true ->
        page_link("#", :disabled, do: label, class: disabled_class)

      false ->
        page_link(gen_href(conn, prev_page), do: label, class: normal_class)
    end
  end

  @doc """
  """
  def middle_page_links(conn, paginate, opts) do
    max_page_links = opts[:max_page_links]
    active_class = opts[:class] <> " " <> opts[:active_class]
    normal_class = opts[:class] <> " " <> opts[:normal_class]
    current_page = paginate.current_page
    max_page = paginate.total_pages

    lower_limit =
      cond do
        current_page <= div(max_page_links, 2) ->
          1

        current_page >= max_page - div(max_page_links, 2) ->
          Enum.max([0, max_page - max_page_links]) + 1

        true ->
          current_page - div(max_page_links, 2)
      end

    upper_limit = lower_limit + max_page_links - 1

    Enum.map(lower_limit..upper_limit, fn page_num ->
      cond do
        current_page == page_num ->
          page_link("#", :active, do: page_num, class: active_class)

        page_num > max_page ->
          ""

        true ->
          page_link(gen_href(conn, page_num), do: page_num, class: normal_class)
      end
    end)
  end

  @doc """
  Returns the next page link.
  """
  @spec next_page_link(Map.t(), Map.t(), Keyword.t()) :: any()
  def next_page_link(conn, paginate, opts) do
    label = opts[:next_label]
    disabled_class = opts[:class] <> " " <> opts[:disabled_class]
    normal_class = opts[:class] <> " " <> opts[:normal_class]
    current_page = paginate.current_page
    next_page = paginate.next_page
    max_page = paginate.total_pages

    case current_page >= max_page do
      true ->
        page_link("#", :disabled, do: label, class: disabled_class)

      false ->
        page_link(gen_href(conn, next_page), do: label, class: normal_class)
    end
  end

  @doc """
  Returns the last page link.

  ## Example

      # iex> conn = %{params: %{}, path_info: ["users"]}
      # iex> paginate = %{current_page: 10, next_page: 11, per_page: 5, prev_page: 9, total_count: 100, total_pages: 20}
      # iex> default_opts = [max_page_links: 10, previous_label: "<<", first_label: "First", next_label: ">>", last_label: "Last"]
      # iex> Turbo.HTML.Views.PaginateView.last_page_link(conn, paginate, default_opts) |> Phoenix.HTML.safe_to_string() |> IO.inspect()
      # "<li class=\"page-item\"><a class=\"page-link\" href=\"/users?page=11\">Last</a></li>"

  """
  @spec last_page_link(Map.t(), Map.t(), Keyword.t()) :: any()
  def last_page_link(conn, %{current_page: current_page, total_pages: total_pages}, opts) do
    label = opts[:last_label]
    disabled_class = opts[:class] <> " " <> opts[:disabled_class]
    normal_class = opts[:class] <> " " <> opts[:normal_class]

    case current_page == total_pages do
      true ->
        page_link("#", :disabled, do: label, class: disabled_class)

      false ->
        page_link(gen_href(conn, total_pages), do: label, class: normal_class)
    end
  end

  @doc """
  Returns the href url path.

  ## Example

      iex>conn = %{params: %{}, path_info: ["users"]}
      iex> Turbo.HTML.Views.PaginateView.gen_href(conn, 2)
      "/users?page=2"

  """
  def gen_href(conn, page_number) do
    params = Map.put(conn.params, "page", page_number)
    Path.join(["/" | conn.path_info]) <> "?" <> Plug.Conn.Query.encode(params)
  end
end
