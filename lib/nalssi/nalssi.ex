defmodule Nalssi do
  def temperatures_of(cities) do
    coordinator_pid = spawn(Nalssi.Coordinator, :async_loop, [[], Enum.count(cities)])

    cities
    |> Enum.each(fn city ->
      worker_pid = spawn(Nalssi.Worker, :loop, [])
      send(worker_pid, {coordinator_pid, city})
    end)
  end

  def temperatures_of_sync(cities) do
    results =
      cities
      |> Enum.each(fn city ->
        worker_pid = spawn(Nalssi.Worker, :loop, [])
        send(worker_pid, {self(), city})
      end)

    IO.puts(results |> Enum.sort() |> Enum.join(", "))
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
