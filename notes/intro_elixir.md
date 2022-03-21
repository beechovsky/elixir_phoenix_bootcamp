# Elixir Warmup
This document covers some foundational, essential Elixir knowledge to help us get started.

## Help, Resources, Community
### Bootcamp Official Repo
https://github.com/StephenGrider/ElixirCode

### Discord
https://discord.gg/vvcyvjDkdC

## Installation
Course show general installation info; I'll be using asdf:
https://github.com/asdf-vm/asdf
https://github.com/asdf-vm/asdf-erlang
https://github.com/asdf-vm/asdf-elixir
https://www.cogini.com/blog/using-asdf-with-elixir-and-phoenix/

## IEX
Before we jump into writing code, it's important to know how to run what we write.

IEX is an interactive Elixir REPL invoked from the command line.

If we start it using:
`iex -S mix`

it will compile our Cards project so we have access to the Cards module's methods in the shell.

To update the shell after making changes, simply run `recompile`.

That's enough about IEX for now. To see more:
https://hexdocs.pm/iex/1.13/IEx.html

## Example Project
Objective: Creating and dealing a hand of cards - CLI

### Generating a Project with Mix
Mix creates and compiles projects, runs *Tasks*, and manages dependencies.

Usage:
`mix new <project name>`

This creates a project, which is simply a directtory structure containing the bare minimum to get stared, the most important of which is the project's core *Module*.

Create the Cards project and run IEX from within /path/to/cards/ to interact with the prject and default `hello` method.

```
iex(1)> Cards
Cards
iex(2)> Cards.hello
:world
```

## Modules and Methods
Code we write in Elixir is organzied into Modules. Modules are collections of methods or functions, created withte following structure:

```
defmodule <Module name> do
  ...
end
```

NOTE: In Elixir, we favor delegating to modules wherever possible over writing new code. Always persue the documentation before deciding to roll your own. Of course, if exisitng solutions are insufficient, go for it.

## Lists and Strings
We'll get into these in more depth later, but in order to get rolling on the project, ;et's take a quick look.

Arrays (lists) in Elixir are declared with square brackets like many other languages.

Strings are declared using double quotes, which is the convnetion in Elixir.

## OOP vs. Functional Programming
How do we write code in Elixir?
What are the design patterns?

Note we didn't create an instance variable in our create_deck method in the Cards project. We simply return a value. This is an example of the fundamental differences between Object Orientied Programming (OOP) and Functional Programming.

### OOP
In OOP, for our example project, we might create a Cards Class, and a Deck Class. These are Object definitions outlining what properties and methods might belong to every instance of CLass and Deck. Cards may have suit an value, for instance:
```
this.suit
this.value
```

and Deck would have an array of Cards and methods for shuffle, save, etc. that would work on a local (`this`) instance variable of Deck of Card.

### Functional Programming
In Functional Programming, we have no concept of Classes and, therefore, instances of Classes. We instead have collections of methods (Modules) that operate on primitives (Strings, Numbers) and data structures used to organize primitives (Arrays).
For instance, a functional shuffle() method would receive a list of strings representing a deck of cards, and return another array of strings representing a new, shuffled deck of cards.

### Method Arguments

## The Enum Module
To shuffle our deck of cards, let's taek a look at our first module in the Elixir Standard Library.

See: https://hexdocs.pm/elixir/Kernel.html

We need a module that will help us shuffle. Let's take a look at `Enum` - the module for working with lists and other collections. Sure enough, there's a `shuffle/1` method in the `Enum` module.

### A Note about Arity
In the definiton of an elixir method you'll see a numer, like so:
`shuffle/1`

That number indicates the number of arguments the method expects/accepts, which is called *Arity*. There may be multiple version of the method accepting differing numbers of arguments.

## Immutability
As described above, functional methods receive a data structure or primitive and return another. We never modify them in place.

In your `iex` shell, assign the output of `Cards.create_deck` to a variable deck:
`iex()> deck = Cards.create_deck`

Pass that deck to `Cards.shuffle`:
`iex()> Cardsshuffle(deck)`

Then, enter just `deck` in the REPL to trace it's values. You'll see they haven't changed. `deck` was not modifed - shuffle gave us another data structure.

## Searching a List
What if we want to know if a card is in our deck? So, we need a `contains` method that searches the deck and returns a boolean value.

Unsurprsingly, we can find one in the same Enum module we used earlier. We'll use the `Enum.member?/2` method.

## List Comprehensions

See Cards.create_deck

## Tuples
At this point in the example code project, we've just leveraged `Enum.split()` to deal a hand from the deck. That method returns a collection of strings, enclosed in curly brackets: `{}`. This is a Tuple.
Tuples are like Arrays/Lists, but they can contain heterogenous types and the order the elements are in conveys some kind fo meaning. In the case of the `split` method above, the first element is the list parsed off of the larger colelction, and the second element is the remaining elements of the origianl collection.

### Accessing the Elements of a Tuple
What if we wanted to return only the hadn, the first element of the tuple returned from our deal method? Naively, you may try index access common to collections in other languages, such as `my_tuple[0]`.
You'll be met with an error message, as that won't work for tuples. How, exactly, to access the lements of a tuples brings us to one of the fundamental, and most powerful, features of Elixir: Pattern Matching. This is a big topic so that is covered in another set of notes; see pattern_matching.md.

## Elixir and Erlang
You may already know Elixir is built upon Erlang, another programming language created decades ago for telecommunications. Elixir code isn't even excuted as Exilir code! It is fed to the Elixir runtime, then transpiled to Erlang before being compiled and executed by the BEAM.

Erlang is somewhat notorious for unfreindly syntax. Enter Elixir: a better interface to Erlang.

BEAM stands for Bogdan's/Bjorn's Erlang Abstract Machine. BEAM is a virtual machine, similar to the JVM for Java (in that it compiles and executes; they are fundametally quite different).

You don't need to master the BEAM, or Erlang, to be a good Elixir developer, but you will find small amounts of Erlang very helpful. For instnace, see the `Cards.save()` and `load()` methods.

## Atoms
You may have seen the following syntax in our project or elsewhere:
`:ok`

This is an example of the primitive data type *Atom*.

From the docs:
https://hexdocs.pm/elixir/1.12.3/Atom.html
*"Atoms are constants whose values are their own name."*

Atoms are often used to express the state of an operation, by using values such as `:ok` and `:error`.

*"Elixir allows you to skip the leading : for the atoms `false`, `true`, and `nil`."*

While they are different, it can be helpful to think of atoms as strings in some cases.

## The Pipe Operator
RTFM: https://elixir-lang.org/getting-started/enumerables-and-streams.html#the-pipe-operator

Pipe operators take *"the output from the expression on its left side and passes it as the first argument to the function call on its right side. It’s similar to the Unix | operator."*

An example from our `Cards` module:
```
def create_hand(hand_size) do
  Cards.create_deck
  |> Cards.shuffle
  |> Cards.deal(hand_size)
end
```

## Module Documentation
Three steps are required for adding documentation to a project:
- add the ExDoc package to mix.exs
- install the dependency
- write the documentation

Adding the package
In your project's top level directory, find the file called "mix.exs". This is commonly referred to as "the Mix file".
NOTE: This is just another module! Look at the def signature at the top of the file.

Now, look for the following block:
```
defp deps do
  ...
end
```

This is where we define dependencies. Dependencies are defined by a tuple including the package name and a target version, like so:
```
defp deps do
  {:ex_doc, "~> 0.27"}
end
```

Next, we'll install the dependency using Mix. In the top level directory, run:
`mix deps.get`

### Module Documentation and Function Documentation
These are exactly what they sound like. Modules and functions each have their own slightly different syntax for declaring comments. Add the following near the top of your Cards mudule, just below the first line with `defmodule`:
```
@moduledoc """
  Provides methods for creating and handling a deck of cards.
"""
```

Now, in the command line, from the top-level driectory, run `mix docs`.

You'll see the system working in the terminal output, and when it completes open the file at doc/index.html.

Huzzah! You now have spiffy Elxir-like docs for your project.

Now let's add some function doc. You probably noticed the module doc picked up the existence of your methods, but had no information abut them. So, we just need to add a blurb above each method.

Add the following above your create_deck method:
```
@doc """
  Returns a list of strings representing a deck of cards
"""
```

Run `mix docs` again and you'll see your update in the html.

Of course, in the real world, you'll want to include as much helpful information as possible, such as a listing and description of method arguments.
To indicate a method argument in function documentation, use backticks like so:
```
@doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.
"""
```

Finally, you may want to give the developers reading your docs a small example of usable code. Begin an example block with two octalthorps aadn make sure your example code his indented 3 tabs, like so:
```
@doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Example
      iex> deck = Cards.create_deck
      iex> {hand,deck} = Cards.deal(deck, 1)
      iex> hand
      ["Aces of Spades"]
  """
  ```
