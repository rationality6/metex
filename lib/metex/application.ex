defmodule Metex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [

    ]

    opts = [strategy: :one_for_one, name: Metex.Supervisor]
    Supervisor.start_link(children, opts)
    Store.Supervisor.start_link([])
  end
end
