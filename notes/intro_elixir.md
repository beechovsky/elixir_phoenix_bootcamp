# Elixir Warmup
This document covers some foundational, essential Elixir knowledge to help get started.

## Help, Resources, Community
### Bootcamp Official Repo
https://github.com/StephenGrider/ElixirCode

### Discord
https://discord.gg/vvcyvjDkdC

## Installation
The course shows very general installation info; I'll be using `asdf`:
https://github.com/asdf-vm/asdf

https://github.com/asdf-vm/asdf-erlang

https://github.com/asdf-vm/asdf-elixir

https://www.cogini.com/blog/using-asdf-with-elixir-and-phoenix/

## IEX
Before we jump into writing code, it's important to know how to run what we write.

IEX is an interactive Elixir REPL invoked from the command line.

To compile a project to have access to the module's methods in the shell, start IEX using:

`iex -S mix`

To update the shell after making changes, simply run `recompile`.

That's enough about IEX for now. To see more:
https://hexdocs.pm/iex/1.13/IEx.html

## Example Project
Objective: Creating and dealing a hand of cards via CLI

**NOTE:** I'll be referencing sections from the example project(s) throughout these notes, so perusing the code, which is heavily commented, ahead of time won't hurt.

### Generating a Project with Mix
Mix creates and compiles projects, runs *Tasks*, and manages dependencies.

Usage:
`mix new <project name>`

This creates a project, which is simply a directory structure containing the bare minimum to get stared, the most important of which is the project's core *Module*.

Create the Cards project and run IEX from within `/path/to/cards/` to interact with the project and default `hello` method like so:

```
iex(1)> Cards
Cards
iex(2)> Cards.hello
:world
```

## Modules and Methods
Code we write in Elixir is organized into Modules. Modules are collections of methods or functions, created with the following signature:

```
defmodule <Module Name> do
  ...
end
```

**NOTE:** In Elixir, favor delegating to exisiting modules wherever possible over writing new code. Always peruse the documentation before deciding to roll your own. Of course, if exisitng solutions are insufficient, go for it.

## Creating Lists and Strings
In order to get rolling on the project, let's take a quick look at these basic data types.

Lists in Elixir are declared with square brackets like many other languages, and are implemented as Linked Lists.

See the doc:
https://hexdocs.pm/elixir/List.html

The convention for declaring Strings in Elixir Strings is to use double quotes.

String Interpolation is possible using `#{}`:

`"My name is #{name}."`

String doc:
https://hexdocs.pm/elixir/String.html

## OOP vs. Functional Programming
How do we write code in Elixir? What are the design patterns?

Note we didn't create an instance variable in our `create_deck` method in the `Cards` project. We simply return a value. This is an example of the fundamental differences between Object Oriented Programming (OOP) and Functional Programming.

### OOP
In OOP, for our example project, we might create a `Cards` *Class* and a `Deck` *Class*. Classes are Object definitions outlining what properties and methods might belong to every *instance* of the class. Cards may have suit and value, for instance:
```
class Cards {
  this.suit
  this.value
}
```

and `Deck` would have an array of `Card`s and methods for shuffling, saving, etc. that would work on a local (`this`) instance variable of `Deck` of `Card`.

### Functional Programming
In Functional Programming, we have no concept of Classes and, therefore, of instances of Classes. We instead have collections of methods (Modules) that operate on primitives (Strings, Numbers, etc.) and data structures used to organize primitives (Lists, Maps, etc.).
For instance, a functional `shuffle()` method would receive a list of strings representing a deck of cards, and return another list of strings representing a new, shuffled deck of cards.

### Method Arguments
Exactly as you expect; passed between the parentheses. Elixir will warn you if you don't use them.

## The Enum Module
To shuffle our deck of cards, let's take a look at our first module in the Elixir Standard Library.

See: https://hexdocs.pm/elixir/Kernel.html

We need a module that will help us shuffle. Let's take a look at `Enum` - the module for working with lists and other collections. Sure enough, there's a `shuffle/1` method in the `Enum` module.

### A Note about Arity
In the definition of an Elixir method you'll see a number, like so:
`shuffle/1`

That number indicates the number of arguments the method expects/accepts, which is called *Arity*. There may be multiple versions of the method accepting differing numbers of arguments.

## Immutability
As described above, functional methods receive a data structure or primitive and return another. We never modify them in place.

In your `iex` shell, assign the output of `Cards.create_deck` to a variable deck:
`iex()> deck = Cards.create_deck`

Pass that deck to `Cards.shuffle`:
`iex()> Cards.shuffle(deck)`

Then, enter just `deck` in the REPL to trace it's values. You'll see they haven't changed. `deck` was not modifed - shuffle gave us another data structure.

## Searching a List
What if we want to know if a card is in our deck? We need a `contains` method that searches the deck and returns a boolean value.

Unsurprsingly, we can find one in the same Enum module we used earlier. We'll use the `Enum.member?/2` method.

## List Comprehensions
Where another language may use a loop, Elixir utilizes List Comprehensions:
```
for n <- N do
  ...
end
```

List Comprehensions allow succint syntax for more complex looping operations. For exmaple, where you may write nested loops in another language, the following comprehension will do in Elixir:
```
for m <- M, n <- N do
  <some op on both m and n>
end
```

See Cards.create_deck for how we used it in our example project.

## Tuples
At this point in the example code project, we've just leveraged `Enum.split()` to deal a hand from the deck. That method returns a collection of strings, enclosed in curly brackets: `{}`. This is a Tuple.

Tuples are like Lists, but they are intended for use as fixed-size containers for multiple elements and the order the elements are in conveys some kind of meaning. In the case of the `split` method above, the first element is the list parsed off of the larger collection, and the second element is the remaining elements of the original collection.

**NOTE:** If you intend to manipulate a collection, use a List instead. `Enum` methods do not work on Tuples.

See doc:
https://hexdocs.pm/elixir/Tuple.html

### Accessing the Elements of a Tuple
What if we wanted to return only the hand, the first element of the tuple returned from our deal method? Naively, you may try index access common to collections in other languages, such as `my_tuple[0]`.
You'll be met with an error message, as that won't work for tuples. How, exactly, to access the elements of a tuple brings us to one of the fundamental, and most powerful, features of Elixir: *Pattern Matching*. This is a big topic so that is covered in another set of notes; see `pattern_matching.md`.

## Elixir and Erlang
You may already know Elixir is built upon Erlang, another programming language created decades earlier for telecommunications. Elixir code isn't even excuted as Exilir code! It is fed to the Elixir runtime, then transpiled to Erlang before being compiled and executed by the BEAM.

Erlang is somewhat notorious for unfriendly syntax. Enter Elixir: a more developer-friendly interface to Erlang.

BEAM stands for "Bogdan's/Bjorn's Erlang Abstract Machine". BEAM is a virtual machine, similar to the JVM for Java (in that it compiles and executes; they are fundamentally quite different).

You don't need to master the BEAM, or Erlang, to be a good Elixir developer, but you will find small amounts of Erlang very helpful. To use Erlang methods, you'll want to invoke Erlang using the *Atom* `:erlang`.

For examples, see the `Cards.save()` and `load()` methods where we leverage Erlang methods.

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
Here, the output from `Cards.shuffle` (a new list of "cards") is the first argument to `Cards.deal`, and the method argument `hand_size` is the second argument.

## Module Documentation
Three steps are required for adding documentation to a project:
- add the ExDoc package to `mix.exs`
    - Actually, this apperas to be installed by default now and doesn't require an additional dependency.
- install the dependency with `mix`
- write the documentation

To add the package, find the file called "mix.exs" in your project's root directory. This is commonly referred to as "the Mix file".

**NOTE:** This is just another module! Look at the `def` signature at the top of the file.

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
These are exactly what they sound like. Modules and functions each have their own slightly different syntax for declaring comments. Add the following near the top of your Cards module, just below the first line with `defmodule`:
```
@moduledoc """
  Provides methods for creating and handling a deck of cards.
"""
```

Now, in the command line, from the project's root directory, run `mix docs`.

You'll see the system working in the terminal output, and when it completes open the newly created file at doc/index.html.

Huzzah! You now have spiffy Elixir-like docs for your project.

Now let's add some function doc. You probably noticed the module doc picked up the existence of your methods, but had no information about them. So, we just need to add a helpful descriptive blurb above each method.

Add the following above your create_deck method:
```
@doc """
  Returns a list of strings representing a deck of cards
"""
```

Run `mix docs` again and you'll see your update in the html.

Of course, in the real world, you'll want to include as much helpful information as possible, such as a listing and description of method arguments. To indicate a method argument in function documentation, use backticks like so:
```
@doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.
"""
```

Finally, you may want to give the developers reading your docs a small example of usable code. Begin an example block with two octothorps and make sure your example code is indented 3 tabs, like so:
```
@doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Example
      iex> deck = Cards.create_deck
      iex> {hand,deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
```

## More Data Structures: Maps and Keyword Lists
### Maps
Maps are collections of key: value pairs, like Ruby hashes and Python dictionaries. They are created with the following syntax:

`color = %{favorite: blue}`

Map elements can be accessed via dot notation:
```
iex> colors.favorite
"blue"
```

Maps work very well with Pattern Matching. We can extract data from existing Maps using Pattern Matching like so:
```
iex> colors = %{first: "blue", second: "yellow"}
%{first: "blue", second: "yellow"}
iex> %{second: secondary_color} = colors
%{first: "blue", second: "yellow"}
iex> secondary_color
"yellow"
```

Elixir first recognized the top-level datatypes matched on both sides, then found a matching `second` field in both Maps. Finally, it recognized `secondary_color` as a variable, and thus populated it with the value of `second` from the original Map on the right.

**NOTE:** While creating and reading from Maps follows lots of exisiting patterns, *updating* Maps is more complicated.

Let's try to update a value inside a Map using dot syntax:
```
iex(9)> colors = %{first: "blue"}
%{first: "blue"}
iex(10)> colors.first = "red"
** (CompileError) iex:10: cannot invoke remote function colors.first/0 inside a match
```
Nope! Recall: Data is immutable in Elixir. Every data structure we ever create, we do not change. Instead, we have to create a new map containing the updated value.

#### Two ways to update a Map
We can use a function, or a nifty bit of syntax, to update Maps.

Let's look at functions first. You guessed it - there's a Map module with methods for working with Maps. For updating, we can use the `put` method.
```
iex(10)> Map.put(colors, :first, "red")
%{first: "red"}
iex(11)> colors
%{first: "blue"}
```
That's right - `Maps.put()` returned a new map. `colors` was unaffected. You may have noticed we used an *atom* to refer to the map field we're assigning a new value to.

Let's try the syntax-based update next:
```
iex(12)> colors
%{first: "blue"}
iex(13)> %{ colors | first: "red" }
%{first: "red"}
iex(14)> colors
%{first: "blue"}
```

As we expected, this returned a new map with the new key:value pair.

**NOTE:** This way of updating Maps can only be used when we are updating an existing property. We cannot use it to add a property.

See doc:
https://hexdocs.pm/elixir/1.12/Map.html

### Keyword Lists
*Keyword Lists* merge the concepts of Lists (arrays of arbitrary length) and Tuples (collections where the order has special meaning) together. They also resemble Maps in construction.
```
colors = [{:first, "red"}, {:second, "blue"}]
```

Yup; that looks like a list of Maps, with Atoms as keys.

Let's see how to access one fo those values.
```
iex(1)> colors = [{:first, "red"}, {:second, "blue"}]
[first: "red", second: "blue"]
iex(2)> colors[:first]
"red"
```

It's important to note that in Elixir, the list elements are still considered Tuples.

Let's make things weird. You can also define a Keyword List exactly as it is displayed in the output above:
```
iex(3)> colors = [first: "blue", second: "red"]
[first: "blue", second: "red"]
```
*insert mind_blown.gif*

#### Where would we use Keyword Lists?
Consider Maps: we can only collect one property type per Map.
```
iex(4)> colors = %{first: "red", first: "blue"}
warning: key :first will be overridden in map
  iex:4

%{first: "blue"}
```

With a Keyword list, we can make the same key as many times as we want and they won't be overwritten.
```
iex(5)> colors = [first: "red", first: "blue"]
[first: "red", first: "blue"]
```
OK, but why would we need two items with the same key?
The best example of using Keyword Lists is the *Ecto* library, used for working with Databases. We'll see more on that later, but for now, let's pretend we're making a query to a database full of users.

```
query = User.find_where([where: user.age > 10, where: user.subscribed == true])
```

Ah! So we can pass mulitple where clause query parameters, for instance.

Recall: There's a shortcut where we remove the braces representing interior tuples. There's another shortcut: If we pass a Keyword List to a function, as the last argument, we can also remove the square brackets.
```
query = User.find_where(where: user.age > 10, where: user.subscribed == true)
```
This looks like two separate arguments, but under the hood this is still a single Keyword List.

You can also remove the parentheses from function calls, in general, so this could look like this:
```
query = User.find_where where: user.age > 10, where: user.subscribed == true
```

See doc:
https://elixir-lang.org/getting-started/keywords-and-maps.html#keyword-lists

## Conclusion
That's it for our introduction to Elixir. It's enough to get started writing code, but make sure to check out the other notes, such as `pattern_matching.md` and especially `testing.md`.
