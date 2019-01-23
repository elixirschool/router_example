defmodule RouterExampleTest do
  use ExUnit.Case
  doctest RouterExample

  test "greets the world" do
    assert RouterExample.hello() == :world
  end
end
