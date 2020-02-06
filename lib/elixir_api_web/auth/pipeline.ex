defmodule ElixirApiWeb.Auth.Pipeline do
    @moduledoc """
    protecting/restricting access to 
    certain routes
    """
    use Guardian.Plug.Pipeline, otp_app: :elixir_api,
    module: ElixirApiWeb.Auth.Guardian,
    error_handler: ElixirApiWeb.Auth.ErrorHandler

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
end
