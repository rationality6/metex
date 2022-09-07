defmodule Store.Client do
  alias Store.Struct, as: Store

  def open(%Store{} = store) do
    store
    |> Core.Store.start_link()
  end

  def get_store(%Store{} = store) do
    GenServer.call(String.to_atom(store.name), :store)
  end

  def add_employees(%Store{} = store, amount) do
    GenServer.cast(String.to_atom(store.name), {:add_employees, amount})
  end
end
