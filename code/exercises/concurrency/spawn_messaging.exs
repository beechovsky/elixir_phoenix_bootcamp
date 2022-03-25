defmodule SpawnMessaging do
  def greet do
    receive do # greet now waits for a message
    {sender, msg} -> # expects the message to match this pattern
      send sender, {:ok, "Hello, #{msg}"} # sends a message back to the same process
    end
  end
end
