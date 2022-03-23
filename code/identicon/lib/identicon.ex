defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.

  """

  @doc """
  Gets a string from the user.

  ## Examples

      iex>

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    # OK. Elixir doesn't have any libraries to create the actual image, but Erlang does!
    # Lookup Erlang egd
    # egd considers top left to be the origin
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  # def pick_color(image) do
  #   # Let's use Pattern Matching to grab the hex property from Image struct.
  #   # %Identicon.Image{hex: hex_list} = image
  #   # Moar pattern Matching to grab the first 3 values
  #   # [r, g, b | _tail] = hex_list
  #   # Ah! The three initial values alone won't match hex_list, sionice it conatins more values.
  #   # We told Elixir using | to tuck the remaining elements into a variable _tail, which we'll ignore (hence the underscore).

  #   # Wait - we aren't using hex_list, so let's just put the second pattern match into the first.
  #   %Identicon.Image{hex: [r, g, b | _tail]} = image

  #   #[r, g, b]

  #   # Wait - didn't we created a Struct specifically to capture all the properties of our Indenticon?
  #   # Let's add our color values to our Struct.
  #   # Recall: We can't do so dynamically here; we need to add the property to our struct in image.ex.
  #   # Recall: We also need to use one of 2 methods for adding t our underlaying MAAp structure once we've defined the 'colors' property in our Image struct.
  #   # Let's use the special syntax method.
  #   %Identicon.Image{image | color: {r, g, b}} # image is what is already in the map/struct we were passed.
  #   # We took those properties and appended our new color porperties to create a new struct.

  #   # Waaaait - we can do one. more. refactor.
  #   # Elixir supports the ability to patten match values directly out of the argument list.
  #   # We can move the pattern matching up into the argument!
  #   # Let's just create a new method below.
  # end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}} # image is what is already in the map/struct we were passed.
    # We took those properties and appended our new color properties to create a new struct.

    # We're saying as we receive image as an arg, we're also pattern matching out of that argument.
    # If we were receiving another argument, say size, we would just place it after a comma.
    # We could also pattern match on that!
    # Ex.: def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image, {height, width} = size) do
  end

  # Alright! Let's make a grid!
  def build_grid(%Identicon.Image{hex: hex} = image) do
    # Recall: prefer using Std Lib wherever possible!
    # What is the hex property of our Image struct? It's a List, so we can probably use the Enum module to break out list into chucnks of 3.
    # Yup - Enum.chunk/2. Once we chunk it smaller lists of length 3, we need to mirror the rows.
    # NOTE: Enum.chunk/2 is deprecated. So, we'll try to use chunk_every/2 instead.
    # NOTE: chunk_every is subtly different, with a tailing entry.
    grid =
      hex
      |> Enum.chunk(3) # Enum.chunk(hex, 3)
      # no function in std. lib. that will mirrir rows, so we ahve to write one (see below)
      # Also, how do we map? You guessed it:
      #|> Enum.map(mirror_row) # won't work! Elixir sees this as mirror_row/0.
      # This is because we're invoking that mthod! Elixir sees mirror row and tries to run it. We need to pass a *reference* to mirror_row:
      |> Enum.map(&mirror_row/1) # I bet you can see we're going to be mapping over this grid again.
      |> List.flatten # Easier to iterate over a single list
      |> Enum.with_index # outputs a list of tuples including our exisiting values and their index.
      # OK. At this point we have a grid. We should add this to our Image struct as a property.
      # 'grid = ' was added after createing the struct property, as was the line below.
      %Identicon.Image{image | grid: grid} # return a new struct with grid populated.
  end

  def mirror_row(row) do
    # [145, 42, 230] -> [145, 42, 230, 42, 145]
    [first, second | _tail] = row
    row ++ [second, first] # New syntax! This is how you append to Lists.
  end

  # NOTE: mirror_row, and thus the  code that uses it, has no concept of index.
  # Most of the interation tools in Elixir works independently of index.
  # Well, Elixir actually has provided something for exactly this purpose. Enum.with_index, which we used above.

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    # Guess what? The Enum module has a filter method that does exactly what you think it does.
    # grid
    # We could write another helper function, but we should try some different syntax.
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0 # rem() is Elixir's built-in remainder function
    end # Recall: each element of the grid is a Tuple.

    %Identicon.Image{image | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    # grid
    # MATH! How do we get the exact coordinates for each square?
    # rem(index, 5) * 50 = 100 - gives us the x coordinate
    # div(index, 5) * 50 = 50 - gives us the y coordinate
    # We awant to iterates over the tuple and return two sets of coordinates for each, teh top left and bottom right
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  # NOTE: we previously set our pattern matched argument to image so we had image later in the method to pass to our new struct construction.
  # We don't need that here.
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
   # look at egd's doc and you'll see why we're creating these specific variables
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
    # WHOA! This is an instance where we're modifying something (image) in place!!!
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

end
