defmodule ElixirApiWeb.Auth.Guardian do
    @moduledoc """
    the module helps to
        - create token
        - decode token
        - refresh token
        - revoke token
    """
    use Guardian, otp_app: :elixir_api

    alias ElixirApi.Accounts

    def subject_for_token(user, _claims) do
        sub = to_string(user.id)
        {:ok, sub}
    end

    def resource_from_claims(claims) do
        id = claims["sub"]
        resource = Accounts.get_user!(id)
        {:ok, resource}
    end
end