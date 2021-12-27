defmodule Wallst.Api.Market do
  require Logger

  @logo_url "https://sandbox.iexapis.com/stable/stock/{SYMBOL}/logo?token=Tpk_e370cc9230a611e9958142010a80043c"
  @price_url "https://sandbox.iexapis.com/stable/stock/{SYMBOL}/price?token=Tpk_e370cc9230a611e9958142010a80043c"
  @sector_perf "https://sandbox.iexapis.com/stable/stock/market/sector-performance?token=Tpk_e370cc9230a611e9958142010a80043c"

  def get_logo(sym) do
    uri = String.replace(@logo_url, "{SYMBOL}", sym)

    case HTTPoison.get(uri) do
      {:ok, %{status_code: 200, body: body}} -> process_response(body)
      # 404 Not Found Error
      {:ok, %{status_code: 404}} -> "Not found"
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end

  def get_price(sym) do
    uri = String.replace(@price_url, "{SYMBOL}", sym)

    case HTTPoison.get(uri) do
      {:ok, %{status_code: 200, body: body}} -> process_response(body)
      {:ok, %{status_code: 404}} -> "Not found"
      {:ok, %{status_code: 400}} -> "Bad Request"
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end

  def get_sector_perf() do
    uri = @sector_perf

    case HTTPoison.get(uri) do
      {:ok, %{status_code: 200, body: body}} -> process_response(body)
      # 404 Not Found Error
      {:ok, %{status_code: 404}} -> "Not found"
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end

  defp process_response(body) do
    body
    |> Jason.decode!()
  end
end

# iex(1)> Wallst.Api.Market.get_logo("tsla")
# %{"url" => "opapo.ap/et-itoLh3h/SAapdsgcse/ul:icxgirgm/golloot/sol/p.7ogTes.gn"}

# iex(3)> Wallst.Api.Market.get_price("tsla")
# 962.8

# iex(6)> Wallst.Api.Market.get_sector_perf()
# %{
#   "lastUpdated" => 1693959507103,
#   "name" => "stlaraeMi",
#   "performance" => -0.0128,
#   "symbol" => "XLB",
#   "type" => "sector"
# }
# ...
