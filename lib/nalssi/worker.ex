defmodule Nalssi.Worker do
  def temperature_of(location) do
    result = url_for(location)
  end

  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{:api_key}"
  end

  defp parse_response({:ok, %HTTPoinson.Response{body: body, status_code: 200}}) do
    body |> JSON.decode!
  end
end
