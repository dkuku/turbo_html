defmodule Turbo.HTML.ThemeAdapter.Custom do
  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @moduledoc """
  Custom Theme.
  """

  defmacro pagination_links(class, do: expression) do
    quote do
      Phoenix.HTML.Tag.content_tag :div, class: unquote(class) do
        unquote(expression)
      end
    end
  end

  defmacro page_link(url, :disabled, do: text, class: class) do
    quote do
      Phoenix.HTML.Link.link to: unquote(url), class: unquote(class) do
        unquote(text)
      end
    end
  end

  defmacro page_link(url, :active, do: text, class: class) do
    quote do
      Phoenix.HTML.Link.link to: unquote(url), class: unquote(class) do
        unquote(text)
      end
    end
  end

  defmacro page_link(url, do: text, class: class) do
    quote do
      Phoenix.HTML.Link.link to: unquote(url), class: unquote(class) do
        unquote(text)
      end
    end
  end
end
