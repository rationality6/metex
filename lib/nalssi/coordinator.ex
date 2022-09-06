defmodule Nalssi.Coordinator do

  def block_loop do
    receive do
      {sender_pid, location} ->
        send(sender_pid, {:ok, Nalssi.Worker.temperature_of(location)})
      _ ->
        IO.puts("what is this?")
    end
    block_loop
  end

  def async_loop(results \\ [], results_expected) do
    receive do
      {:ok, result} ->
        new_results = [result|results]
        if results_expected == Enum.count(new_results) do
          send self, :exit
        end
        async_loop(new_results, results_expected)
      :exit ->
        IO.puts(results |> Enum.sort |> Enum.join(", "))
      _ ->
        async_loop(results, results_expected)
    end
  end

end


# cities = ["Singapore", "Monaco", "Vatican City", "Hong Kong", "Macau"]

# cities
# |> Enum.each(fn city ->
#   pid = spawn(Nalssi.Coordinator, :block_loop, [])
#   send(pid, {self, city})
# end)

# flush
