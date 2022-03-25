defmodule SpawnMultiple do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello #{msg}"}
        greet() # tail recursion
    end
  end
end
