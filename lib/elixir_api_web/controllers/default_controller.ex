defmodule ElixirApiWeb.DefaultController do
    use ElixirApiWeb, :controller
    def index(conn, _params) do
        text conn, "Elixir Api practice"
    end
end
