defmodule SomeApp.Schema do
  @derive [Poison.Encoder]
  defstruct event: "noop", data: %{}

  def decode(payload), do: payload |> Poison.decode!(as: %__MODULE__{})
end

defimpl String.Chars, for: SomeApp.Schema do
  def to_string(payload), do: payload |> Poison.encode!
end
