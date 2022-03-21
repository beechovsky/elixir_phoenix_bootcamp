# Pattern Matching
Pattern Mathcing is Elixir's replacement fro variable assignment.

Wait? Didn't we assign variables already? Like:
`deck = Cards.create_deck`

Yes, but we were actually using pattern matching. In simple cases the difference is subtle.

For an example, let's consider the `deal` method from the Cards module we're working on. The split method we're using from the Enum module returns a tuple containing two elements; the "hand", the elements parsed off of the original collection, and the "deck" the remaining collection. If we wish to access those elements individually, we need to assign that return value to a properly defined, matching data structure.
For example:

`{ hand, rest_of_deck } = Cards.deal(deck, 5)`

Aha! We now have a named element we can refer to for each part of the tuple.
```
iex(1)> recompile
Compiling 1 file (.ex)
:ok
iex(2)> deck = Cards.create_deck
["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
 "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
 "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
 "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
 "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
iex(3)> { hand, rest_of_deck } = Cards.deal(deck, 5)
{["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
  "Five of Spades"],
 ["Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
  "Five of Clubs", "Ace of Hearts", "Two of Hearts", "Three of Hearts",
  "Four of Hearts", "Five of Hearts", "Ace of Diamonds", "Two of Diamonds",
  "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]}
iex(4)> hand
["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
 "Five of Spades"]
iex(5)> rest_of_deck
["Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
 "Five of Clubs", "Ace of Hearts", "Two of Hearts", "Three of Hearts",
 "Four of Hearts", "Five of Hearts", "Ace of Diamonds", "Two of Diamonds",
 "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
```

Elixir looks at the return values of things on the right, and comapres it to what it sees on the left. If the data structure and/or number of elements on the left match return values, the assignment is made. Let's try another example.

Let's say you had a simple list with one element. How would you assign a variable to the element, and not the whole list?
```
iex(1)> color = ["blue"]
["blue"]
iex(2)> [color1] = color
["blue"]
iex(3)> color1
"blue"
```

Because the data structure on the left matched the data structure on the right, we were able to capture the element in a variable. Let's do it again.

```
iex(4)> [color1, color2, color3] = ["blue", "red", "green"]
["blue", "red", "green"]
iex(5)> color1
"blue"
iex(6)> color2
"red"
iex(7)> color3
"green"
```

Alright. So, what happens if they don't match?
```
iex(8)> [color1, color2, color3] = ["blue", "red"]
** (MatchError) no match of right hand side value: ["blue", "red"]
```
Elixir finds the structure on the left doesn't match, so it throws an error and no assignments are made.

## Hard-Coding Values
Consider the following:
`["red", color] = ["red", "blue"]`

Elixir will evaluate this and, since the first elements match, continue to attempt to match the second elements, which it can do. It assigns the value of "blue" to the variable `color`.

What about this:
`["red", color] = ["green", "blue"]`
Nope!
Elixir will return the follwing error:
`** (MatchError) no match of right hand side value: ["green", "blue"]`

Pretty clear what happened there - comparing the first elements of each array, Elixir could not make a match. The entire assignment fails.

