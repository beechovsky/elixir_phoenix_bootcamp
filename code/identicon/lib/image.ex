defmodule Identicon.Image do
  @moduledoc """
    This module defines our Struct for containing the various bits of data we need.
    Accessed via %Identicon.Image{}
  """

  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end
