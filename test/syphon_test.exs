defmodule SyphonTest do
  use ExUnit.Case
  doctest Syphon

  test "greets the world" do
    assert Syphon.hello() == :world
  end
end
