defmodule Nalssi.Worker do
  @api_key Application.get_env(:metex, :api_key)

  @absolute_zero -273.15

  def loop do
    receive do
      {sender_pid, location} ->
        send(sender_pid, {:ok, temperature_of(location)})

      _ ->
        IO.puts("what is this?")
    end

    loop()
  end

  def temperature_of(location) do
    result = url_for(location) |> HTTPoison.get() |> parse_response

    case result do
      {:ok, temp} ->
        "#{location}: #{temp}°C"

      :error ->
        "#{location} not found"
    end
  end

  def url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{@api_key}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode!() |> compute_temperature
  end

  defp parse_response(_) do
    :error
  end

  defp compute_temperature(json_body) do
    try do
      temp = (json_body["main"]["temp"] + @absolute_zero) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
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

# cities
# |> Enum.each(fn city ->
#   pid = spawn(Nalssi.Worker, :loop, [])
#   send(pid, {self, city})
# end)

# flush
