# Wallst

API for getting stock and crypto data

[![CircleCI](https://circleci.com/gh/EssenceOfChaos/wallst/tree/master.svg?style=svg)](https://circleci.com/gh/EssenceOfChaos/wallst/tree/master)

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

To run the app locally install the dependencies by running `mix deps.get` in the root directory.
Start a development mix server with `iex -S mix`, then begin by calling the `get_price/1` function in the **Market** module, passing in the ticker of the stock you are interested in.

```shell
iex(2)> Market.get_price("ibm")
136.53
iex(3)> Market.get_price("tsla")
1102.06
iex(4)> Market.get_price("iipr")
261.65
```
