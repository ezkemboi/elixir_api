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

    def authenticate(email, password) do
        # check if user exists
        with {:ok, user} <- Accounts.get_by_email(email) do
            case validate_password(password, user.encrypted_password) do
                true ->
                    create_token(user)
                false ->
                    {:error, :unauthorized}
            end
        end
    end

    def validate_password(password, encrypted_password) do
        Bcrypt.verify_pass(password, encrypted_password)
    end

    def create_token(user) do
        {:ok, token, _claims} = encode_and_sign(user)
        {:ok, user, token}
    end
end