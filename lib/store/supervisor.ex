defmodule Store.Supervisor do
  use Supervisor

  alias Store.Struct, as: StoreStruct
  alias Store.Server, as: Server

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg,  name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      create_store(%StoreStruct{name: "Test1", employees: 2}),
      create_store(%StoreStruct{name: "Test2", employees: 2})
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp create_store(%StoreStruct{} = store) do
    %{
      id: String.to_atom(store.name),
      start: {Server, :start_link, [store]}
    }
  end
end
