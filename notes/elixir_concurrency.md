# Elixir Concurrency
## General
A key feature of Elixir programming is code that can be run concurrently. Elixir  (well, the BEAM) packages code into small, independent chunks with their own heap (which is garbage collected independently) that communicate via messaging.

This is known as the *Actor Model*, and these independent processes are called *Actors*. Actors are isolated; share nothing with other Actor processes. They can send and receive messages, and spawn new processes, but that's about it.

That isolation alleviates much of the pain conventional languages suffer when invoking threads or operating system processes.

**NOTE:** Elixir processes != OS processes.

# Starting a New Process
The simplest way to kick off a new process is to use a `spawn` function.
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

The following `receive` call would match on our example above:
```
receive do
{sender, message} ->
    IO.puts message
do
```
Check out `/code/concurrency/spawn_basic.exs` and `spawn_messaging.exs`. Try to interact with those modules in IEx.

## Handling mUltiple Messages
In IEx, if you try to send a second message to `SpawnMessage.greet` after grabbing the PID only once, you'll see the system hang. That's because greet, or more specifically the receive inside of greet, was waiting for a message, which it got, then it stops waiting.

You can add a timeout message using `after` inside of the receive block, but what if you want greet to handle multiple messages?

We can leverage Elixir's recursion implementation. You may be worried immediately about blowing up your stack, as recursion in conventional languages will simply keep piling on. Elixir, however, uses *tail-recursion optimization*. In Elixir, if the last thing a function does is call itself, there's no need to actually call it and place it on the call stack. Instead, the runtime simply jumps back to the start of the function, updating any parameters with arguments passed to the recursive call. See `/code/concurrency/spawn_multiple.exs` for an example.

**NOTE:** be careful that the method is actually the last argument. The following will NOT work:
```
def factorial(0), do: 1
def factorial(n), do: n * factorial(n-1)
```
In this case, while the method call is the last thing written, the last part executed is `n * <return value of call to factorial()>`.





## Notes
See `/code/concurrency.exs` for code examples corresponding to these notes.

## References
https://pragprog.com/titles/elixir16/programming-elixir-1-6/
https://elixirschool.com/en/lessons/intermediate/concurrency
