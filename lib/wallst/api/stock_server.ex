defmodule Wallst.Api.StockServer do
  @moduledoc """
    Defines the Wallst API for retreiving market and stock data
  """
  use GenServer

  @base "https://sandbox.iexapis.com/"
  @version "stable"
  @req_type "/stock/{SYMBOL}/quote?"
  @test_token "token=Tpk_e370cc9230a611e9958142010a80043c"
  # @url "https://sandbox.iexapis.com/stable/stock/{SYMBOL}/quote?token=Tpk_e370cc9230a611e9958142010a80043c"

  ## ------------------------------------------------- ##
  ##                   Client API                      ##
  ## ------------------------------------------------- ##
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: :iex_server)
  end

  def get_price(name, stock) do
    GenServer.call(name, {:stock, stock})
  end

  def get_state(name) do
    GenServer.call(name, :get_state)
  end

  def reset_state(name) do
    GenServer.cast(name, :reset_state)
  end

  def stop(name) do
    GenServer.cast(name, :stop)
  end

  ## ------------------------------------------------- ##
  ##                   Server API                      ##
  ## ------------------------------------------------- ##

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:stock, stock}, _from, state) do
    case price_of(stock) do
      {:ok, price} ->
        new_state = update_state(state, stock, price)
        {:reply, "#{price}", new_state}

      _ ->
        {:reply, :error, state}
    end
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    # action, response, new state(no change)
    {:reply, state, state}
  end

  @impl true
  def handle_cast(:reset_state, _state) do
    # note: no response
    # action, current state(set to empty map)
    {:noreply, %{}}
  end

  @impl true
  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  @impl true
  def terminate(reason, stats) do
    # We could write to a file, database etc
    IO.puts("server terminated because of #{inspect(reason)}")
    inspect(stats)
    :ok
  end

  @impl true
  def handle_info(msg, state) do
    IO.puts("received #{inspect(msg)}")
    {:noreply, state}
  end

  ## ------------------------------------------------- ##
  ##                   Helper Functions                ##
  ## ------------------------------------------------- ##

  defp price_of(stock) do
    uri = String.replace(@req_type, "{SYMBOL}", stock)

    case HTTPoison.get(@base <> @version <> uri <> @test_token) do
      {:ok, %{status_code: 200, body: body}} -> process_response(body)
      # 404 Not Found Error
      {:ok, %{status_code: 404}} -> "Not found"
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end

  defp process_response(body) do
    # process the response from HTTPoisen.get
    body
    |> Jason.decode!()
    |> IO.inspect()
  end

  defp update_state(old_state, stock, price) do
    case Map.has_key?(old_state, stock) do
      true ->
        Map.update!(old_state, stock, price)

      false ->
        Map.put_new(old_state, stock, price)
    end
  end
end
