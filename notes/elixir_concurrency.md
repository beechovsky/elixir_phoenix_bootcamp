# Elixir Concurrency
## General
A key feature of Elixir programming is code that can be run concurrently. Elixir packages code into small, independent chunkw with their own heap (which is garbage collected independently) that communicate via messaging.

This is known as the *Actor Model*, and these independent processes are called *Actors*. Actors share nothing with other Actor processes. They can send and receive messages, and spawn new processes, but that's about it.

That isolation alleviates much of the pain conventional languages suffer when invoking threads or operating system processes.

**NOTE:** Elixir processes != OS processes.

# Starting a New Process
To kick off a new process use a `spawn` function.
There are many flavors of `spawn`, but the simplest allow you to pass anonymous functions or Module functions along with a list of arguments.

Every spawn function returns a PID (process identifier, like `PID<0.23.0>`) and creates a new process to run whatever code we specify. **NOTE:** We don't know exactly when the process will execute; that process is initially only *eligilble* to run.

## Messaging between Processes
To send a message between processes, use the `send` function. Send requires a PID and a message, which is called a *term* in Elixir.

So, first you would grab a PID from a process, possibly by using `spawn()`, then pass that to `send`, like so:
```
pid = spawn(<some module>, <some module function>, [<list of argw to the function>])
send pid, {self(), "World!}
```
To wait for a message, use the `receive` function. The `receive` function acts similarly to case, in that it specifies a pattern it is looking to match on, and the first incoming message that fits that pattern is run.

The follwoing receive call would match on our example above:
```
receive do
{sender, message} ->
    IO.puts message
do
```


## Notes
See `/code/concurrency.exs` for code examples corresponding to these notes.

## References
https://pragprog.com/titles/elixir16/programming-elixir-1-6/
https://elixirschool.com/en/lessons/intermediate/concurrency
