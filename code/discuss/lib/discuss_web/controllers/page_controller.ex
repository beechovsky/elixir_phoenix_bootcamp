defmodule DiscussWeb.PageController do
  use DiscussWeb, :controller

  # This is the action mentioned in the router for requests to "/"
  # Recall: the controller takes data and HTML templates and puts them topgether, and renders it back to the user.
  # Note: no model is used here. Some pages are that simple.
  # There is nothing special about PageController - it is simply the default controller.
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
