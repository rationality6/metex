defmodule Nalssi do
  def temperatures_of(cities) do
    coordinator_pid = spawn(Nalssi.Coordinator, :async_loop, [[], Enum.count(cities)])

    cities
    |> Enum.each(fn city ->
      worker_pid = spawn(Nalssi.Worker, :loop, [])
      send(worker_pid, {coordinator_pid, city})
    end)
  end
end


# cities = [
#   "Seoul",
#   "Osaka",
#   "Singapore",
#   "Monaco",
#   "Vatican City",
#   "Hong Kong",
#   "Macau",
#   "Someware"
# ]
