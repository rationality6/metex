defmodule Store.Server do
  use GenServer

  alias Store.Struct, as: Store

  def start_link(%Store{} = store) do
    GenServer.start_link(__MODULE__, store, name: String.to_atom(store.name))
  end

  @impl true
  def init(%Store{} = store) do
    {:ok, store}
  end

  def current(name) do
    GenServer.call(name, :current)
  end

  @impl true
  def handle_call(:current, _from, status) do
    {:reply, status, status}
  end

  @impl true
  def handle_call(:store, _from, %Store{} = store) do
    {:reply, store, store}
  end

  @impl true
  def handle_cast({:add_employees, amount}, %Store{} = store) do
    store =
      store
      |> Map.put(:employees, store.employees + amount)

    {:noreply, store}
  end
end
