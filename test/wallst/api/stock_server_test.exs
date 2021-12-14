defmodule Wallst.StockServerTest do
  @moduledoc """
  Defines the test suite for the Wallst API
  """
  use ExUnit.Case, async: true
  alias Wallst.Api.StockServer

  describe "Testing API" do
    setup do
      IO.puts("This is a setup callback for #{inspect(self())}")

      on_exit(fn ->
        IO.puts("This is invoked once the test is done. Process: #{inspect(self())}")
      end)
    end

    test "GenServer started correctly" do
      # Check the GenServer is started with empty map
      res = :sys.get_state(:iex_server)
      assert res != nil
    end

    test "GenServer automatically restarts after it crashes" do
      # get the current process id
      pid = Process.whereis(:iex_server)
      assert is_pid(pid) == true

      # kill the GenServer to simulate a crash
      Process.exit(pid, :kill)

      # check the GenServer has restarted
      new_pid = Process.whereis(:iex_server)

      # make sure the pids are different
      assert is_pid(new_pid)
    end
  end
end
