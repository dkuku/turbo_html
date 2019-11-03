defmodule Turbo.HTML do
  @moduledoc """
  Turbo view support.
  """

  alias Turbo.HTML.Views.{
    PaginateView,
    PaginateCustomView,
    SearchInputView
  }

  alias Turbo.HTML.Config, as: TConfig

  @doc """
  paginate view
  """
  def turbo_pagination_links(conn, paginate, opts \\ []) do
    PaginateView.pagination_links(conn, paginate, opts)
  end

  @doc """
  custom paginate view
  allows to specify classes for pagination:
    parent_class: "parent"
    disabled_class: "disabled"
    active_class: "active"
    normal_class: "normal"
    class: ""
  class is common and is concatenated to all the pagination links
  """
  def turbo_pagination_custom(conn, paginate, opts \\ []) do
    PaginateCustomView.pagination_links(conn, paginate, opts)
  end

  @doc """
  search input view.
  """
  def turbo_search_input(conn, field, opts \\ []) do
    SearchInputView.search_input(conn, field, opts)
  end

  def view_style do
    TConfig.view_style()
  end
end
