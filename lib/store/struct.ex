defmodule Store.Struct do
  @enforce_keys [:name, :employees]
  defstruct [:name, :employees]
end
