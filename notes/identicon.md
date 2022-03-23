# Identicon Example Project
Let's take advantage of what we've learned so far and make another application.

Let's make Identicons! Identicons are a 5x5 grid of squares, each 50px a side, typically mirrored about the center (ours will be).
Requirements:
- each identicon shall not be randomly generated
- each identicon shall be generated based on string input

https://en.wikipedia.org/wiki/Identicon

## Planning
(Very General) Flow: String -> Identicon -> Image

Detailed Flow:
String ->
    Compute MD5 Hash of String ->
        List of numbers based on String ->
            Pick color ->
                Build grid ->
                    Convert Grid to Image ->
                        Save Image


You may have noticed the numbers we're receiving are limited to 255, so we can use them as RGB values to determine color! We'll simply pick the first 3 numbers.

For the grid, imagine a series of lists with indices mirrored about he center:
1  2  3  2  1
4  5  6  5  4
7  8  9  8  7
10 11 12 11 10
13 14 15 14 13

Now, imagine we're simply mapping the indices of the number array we generated to the positions in the grid indices.

Also, let's say that if a index value is even, we'll color that square.

At this point, we're keeping track of several bits of data: a string, a list of numbers, RGB data, etc.
We need an efficient way to store and keep track of these items.

Elixir has a data structure perfect for this: *Struct*. Check out the `image.ex` module for how we implement a struct, and review the `intro_elixir.md` notes for an introduction to structs in general.

**NOTE:** At this point, the project is code heavy, with several iterations over possible method implementations worth keeping and commenting out. Please see the files in identicon/lib for further discussion in the comments.