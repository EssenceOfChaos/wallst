# Wallst

API for getting stock and crypto data

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `wallst` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:wallst, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/wallst>.

## Example

Get some stock prices by calling the `StockServer.get_price/2` function.

```shell
StockServer.get_price(:iex_server, "ibm")
StockServer.get_price(:iex_server, "tsla")
StockServer.get_price(:iex_server, "aapl")
```

After making some calls, check the current state of the application using `StockServer.get_state/1`.

```shell
StockServer.get_state(:iex_server)
```
