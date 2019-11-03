# Turbo.HTML

## Table of contents

* [Getting started](#getting-started)
* [Demo](#demo)
* [Contributing](#contributing)
* [Make a pull request](#make-a-pull-request)
* [License](#license)
* [Credits](#credits)


## Getting started

`Turbo.HTML` is a [Turbo.Ecto](https://github.com/zven21/turbo_ecto) at Phoenix framework supported.

```elixir
def deps do
  [
    {:turbo_html, "~> 0.2.3"}
  ]
end
```

For use with Phoenix.HTML, configure the config/config.exs like the following:

```elixir
config :turbo_html, Turbo.HTML,
  view_style: :semantic    # default bootstrap.
```

Two methods are provided:

* `turbo_search_input`: for search input.
* `turbo_pagination_links`: for pagination view.
* `turbo_pagination_custom`: for pagination when using own css classes.

## Basic usage:
```
    <%= turbo_pagination_view(@conn, @paginate) %>
```
```
    <%= form_for @conn, Routes.permit_path(@conn, :index), [method: :get, class: ""], fn f -> %>
      <%= turbo_search_input f, "q[user_name_or_address_like]", placeholder: "name or address", class: "form-input" %>
      <%= submit "search", class: "" %>
    <% end %>
```
```
    <%= turbo_pagination_custom(@conn, @paginate, class: "border-2 p-2 font-bold",
        normal_class: "bg-secondary", active_class: "bg-primary", disabled_class: "bg-disabled") %>
```

## Demo

The dummy app shows a simple turbo_ecto example.

Clone the repository.

```bash
https://github.com/zven21/turbo_ecto.git
```

Change directory

```bash
$ cd dummy
```

Run mix

```bash
$ mix deps.get && yarn --cwd=assets
```

Preparing database

```bash
$ mix ecto.setup
```

Start the Phoenix server

```bash
$ ./script/server
```

Open your browser, and visit `http://localhost:4000`

## Contributing

Bug report or pull request are welcome.

### Make a pull request

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Please write unit test with your code if necessary.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Credits

* [scrivener_html](https://github.com/mgwidmann/scrivener_html) - Initial inspiration of this project.
