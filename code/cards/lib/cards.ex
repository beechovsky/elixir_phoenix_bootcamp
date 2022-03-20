defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

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

  def contains?(deck, card) do # ? - indicates this method returns a boolean
    Enum.member?(deck, card)
  end

  # Let's make a method to deal a hand.
  # So, we need to split the deck, removing some items and leaving others behind.
  def deal(deck, hand_size) do
    # Let's try Enum.split()
    Enum.split(deck, hand_size) # { hand, remaining deck}

    # Interesting. We get two lists enclosed in {}.
    # This is a tuple, which we should ahve expected after looking at Enum.plit() in the documentation.
    # Tuples are like arrays, but can contain heterogenous types, and the order of the elements conveys some meaning.

    # Okay, but what if we want just the hand and not the entire tuple?
    # Index access methods you may be used to like tuple[0] won't work.

  end


end
