defmodule WallstTest do
  use ExUnit.Case
  doctest Wallst

  test "greets the world" do
    assert Wallst.hello() == :world
  end
end
