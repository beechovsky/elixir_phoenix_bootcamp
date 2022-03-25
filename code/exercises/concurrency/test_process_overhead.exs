defmodule ProcessOverhead do
  @moduledoc """
    This module is for testing process overhead by chaining `n` processes together.
    The first process sends a number to the second, which increments `n` and passes it to the third process, etc.
    until the nth process, which will pass the number back to the top level.
    Example taken from here:
      https://pragprog.com/titles/elixir16/programming-elixir-1-6/

    NOTE: NEEDS WORK - syntax isn't correct
  """


  # This is the code run in separate processes.
  def counter(next_pid) do
    receive do
      n -> # waits for a number
        send next_pid, n + 1 # sends the incremented number to the next process
    end
  end

  # arg n is the number of processes to create
  # send_to is the arg passed to counter
  def create_processes(n) do
    # This anonymous function creates the processes
    code_to_run = fn (_, send_to) ->
      # each process needs the PID of the previous process so it knows who to send the updated number to
      spawn(ProcessOverhead, :counter, [send_to])
    end

    # current PID set as accumulator
    last = Enum.reduce(1..n, self(), code_to_run)

    # start the count by sending 0 to the last process
    send(last, 0)

    receive do # wait for a result
      final_answer when is_integer(final_answer) -> # note the guard; qualifies the pattern for `receive`
        "Result is #{inspect(final_answer)}"
    end
  end

  # Command line entrypoint. Ex.:
  # elixir -r test_process_overhead.exs -e "ProcessOverhead.run(10)"
  def run(n) do
    :timer.tc(ProcessOverhead, :create_processes, [n])
    |> IO.inspect
  end
end
