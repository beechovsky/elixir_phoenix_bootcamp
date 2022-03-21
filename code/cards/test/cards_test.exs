defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck returns 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  # This isn't great - just an example.
  # On the chance shuffle returns a collection in teh same order, it will fail.
  test "shuffling a deck returns a randomized list of what was in deck" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end

end
