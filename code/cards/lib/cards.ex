defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of cards
  """
  def create_deck do
    # we need to track both number and suit
    values = ["Ace", "Two", "Three", "Four", "Five"] # double quotes are elixir convention
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # How do we pair each number with each suit?
    # Naively, we could do nested iteration/loops.
    # Elixir employs list comprehensions like so
    # for suit <- suits do
    #   suit
    # end

    # OK, but that doesn't get us the mapping we need.

    # Don't do this (try it in the shell, though):
    # for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}" # string interpolation
    #   end
    # end

    # That created a list of lists of strings, one string for each value.
    # We want a single list of strings.
    # Let's take a look at the Elixir Standard Library again.
    # Specifically, the List module. Lists in Elixir are Linked Lists, BTW.
    # We can use List.flatten() to make the output form the loop above a sinlge list.
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}" # string interpolation
    #   end
    # end

    # List.flatten(cards)

    # But, don't do that either.
    # We can remove the need for the inner comprehension and the processing of List.flatten.
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck) # there's a module and method for that!
  end

  def contains?(deck, card) do # ? is a note for devs to indicates this method returns a boolean
    Enum.member?(deck, card)
  end

  # Let's make a method to deal a hand.
  # So, we need to split the deck, removing some items and leaving others behind.
  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Example
      iex> deck = Cards.create_deck
      iex> {hand,deck} = Cards.deal(deck, 1)
      iex> hand
      ["Aces of Spades"]
  """
  def deal(deck, hand_size) do
    # Let's try Enum.split()
    Enum.split(deck, hand_size) # { hand, remaining deck}

    # Interesting. We get two lists enclosed in {}.
    # This is a tuple, which we should have expected after looking at Enum.split() in the documentation.
    # Tuples are like arrays, but can contain heterogenous types,
    # and the order of the elements conveys some meaning.

    # Okay, but what if we want just the hand and not the entire tuple?
    # Index access methods you may be used to like tuple[0] won't work.

  end

  # Let's write a method to save the state of the deck to the filesystem.
  # The Standard Library contains everyting we need to interact with the filesystem.
  # Also, we can call underlying Erlang code directly, too, and in fact the Elixir libraries leave some things out that are easily accessed in Eralng.
  def save(deck, file_name) do
    # Let's convert the deck object to something we can write to filesystem
    binary = :erlang.term_to_binary(deck)
    # Now, using the File module, let's save it.
    File.write(file_name, binary)
  end

  # Now let's write a method for loading the deck we've saved from the filesystem.
  # This is basically the opposite of what we did in save().
  # First, run File.read("my_deck") in iex and see what you get.
  # We get a tuple containing as one of its values a list of integers representing our data.
  # To get to that data, we're going to use pattern matching.
  # def load(file_name) do
  #   {status, binary} = File.read(file_name) # Leverage File module
  #   :erlang.binary_to_term(binary) # leverage underlying Erlang
  # end

  # The method above is fine, but what if we try to open a file that doesnt exist?
  # We need some error handling.
  # We'll use the first, "status" element of the tuple returned from File.read().
  # Naively, you may want to use a condtitional (if) statement, but pattern matching gives us a better way.
  # def load(file_name) do
  #   {status, binary} = File.read(file_name)

  #   case status do
  #     :ok -> :erlang.binary_to_term(binary)
  #     :error -> "Can't find file '#{file_name}'"
  #   end
  # end

  # OK, that's much better. However, we can still improve our error handling.
  # We can streamline this code further by better harnessing the power of patten mathcing.
  def load(file_name) do
    case File.read(file_name) do
      # Comparison and assignment in one line!
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "Can't find file '#{file_name}'. #{reason}"
      # Note: If we don't use reason, or any other variable declared in function scope, we'll get a warning from the compiler.
      # We don't have to use it though, if we don't want to.
      # We do need to leave it in the lefthand expression for correct pattern mathcing.
      # So, we can prepend an underscore to the variable, like so: _reason
      # TODO: Update the method to use underscore and rewrite this note.
    end
  end

  # This is a good start!
  # However, after some feedback, we realize everyone runs the same 3 commands in a ro every time:
  # create_deck > shuffle > deal
  # Let's add a method to do all of these at once.
  # How do we chain method calls?
  # def create_hand(hand_size) do
  #   deck = Cards.create_deck
  #   deck = Cards.shuffle(deck)
  #   hand = Cards.deal(deck, hand_size)
  # end

  # OK, that will work, but Elixir has a tool we can use that makes this much cleaner.
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
    # |> is the Pipe Operator.
    # Look at the method arguments - Elixir is automatically injecting the return values as arguments!
    # This means the Pipe Operator demands consistent first arguments.
  end
end
