# Introduction to Testing in Elixir
## General
Testing in Elixir is a *First-Class* feature, in that it is fully supported "out of the box". You don't need to import extra libraries.

When we created our project with Mix, we automatically had a directory and two files created to get us started.
```
test/
- cards_test.exs
- test_helper.exs
```

The `test_helper` file is for configuration of the test environment, and `cards_test` is where we'll write tests for our module.

You'll see a default test of some kind in `cards_test`. If it was related to the default `Cards.hello` method, and you removed that method, you can replace the test logic with something simple like:
`assert 1 + 1 == 2`.

Let's run the test. From the root directory, run `mix test`.

Let's break the test we just added to see what happens when a test fails. Change it to `assert 1 + 1 == 3` and run `mix test` again.

You'll see some helpful output like this:
```
 1) test the truth (CardsTest)
     test/cards_test.exs:5
     Assertion with == failed
     code:  assert 1 + 1 == 3
     left:  2
     right: 3
     stacktrace:
       test/cards_test.exs:6: (test)
```

Hold up - the terminal is telling me 2 test ran, when we only have one in cards_test.exs. That's right - we already wrote a test earlier without even knowing it! If you remove the trivial unit test from `cards_test` and run `mix test` again, you'll see a test was run. We'll discuss what happened just below.

## How to write Tests
There are two types of tests we can write in Elixir:
- Case (Unit) Tests - Test some singular fact or assumption with an `assert` or `refute` statement.
- Doc Tests - When we write function documentation with an `Example` block, Elixir's test module will run the code and test the return value.

Doc Tests are incredibly powerful and an immeasurable boon to developers. We can simply run code in our iex shell and copy/paste that code into our documentation - increasing the value of our documentation and trivially adding test coverage! You will need to trim the iex prompt a bit though, as the test module is looking for only 'iex>', and not numbers or parentheses.

NOTE: If we want to make additional assertions about the value of something in an example, we can add it without the 'iex>' at the beginning of the line. However, make sure we are targeting what we're testing precisely.

Case Tests are written in our module's Test module, and defined like so:
```
test "test one thing" do
    assert <something>
end
```
Note: The keywords `assert` and `refute` will be in most/all of your Case tests. `refute` is exactly what it sounds like, the opposite of `assert`, and is paired with `==`  instead of `!=`.

## What do we test?
Well, what behavior are you concerned with?
We want to ensure `create_deck` is giving us a list of expected size, for instance, or that `shuffle` randomizes the contents of a deck. Take a look at the `cards_test` module to see how we've done this.

NOTE: By testing the length of the deck, we're also implicitly testing that we're receiving a list. Case Tests should be granularly focused, but you can limit their volume with such behavior.