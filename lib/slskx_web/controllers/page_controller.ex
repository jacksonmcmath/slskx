defmodule SLSKXWeb.PageController do
  use SLSKXWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
