# Elixir Warmup
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
Before we jump into writing code, it's important to know how to interact whit it.

IEX is an interactive elixir REPL invoked from the command line.

If we Start it using:
`iex -S mix`

it will compile our Cards project so we have access to the Module's methods in the shell.

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
You'll be met with an error message, as that won;t work for tuples. How, exactly, to access the lements of a tuples brings us to one of the fundamental, and most powerful, features of Elixir: Pattern Matching. We'll discuss this in the next set of notes.