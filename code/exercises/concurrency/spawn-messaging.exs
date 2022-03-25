defmodule SpawnMessaging do
  def greet do
    receive do # wait for a message
    {sender, msg} ->
      send sender, {:ok, "Hello, #{msg}"}
    end
  end
end
