defmodule Nalssi.WorkerTest do
  use ExUnit.Case

  test "Nalssi.Worker 가 잘 동작하는지" do
    location = "seoul"
    result = Nalssi.Worker.temperature_of(location)
    expacted = "seoul: 19.1°C"
    assert(result, expacted)
  end
end
