defmodule SomeApp.SchemaTest do
  use ExUnit.Case

  @valid_attrs %{event: "123", data: "Shane"}
  @valid_json_attrs Poison.encode!(@valid_attrs)

  test "#decode" do
    assert SomeApp.Schema.decode(@valid_json_attrs) == struct(SomeApp.Schema, @valid_attrs)
  end

  test "#to_string" do
    assert struct(SomeApp.Schema, @valid_attrs) |> to_string == @valid_json_attrs
  end
end
