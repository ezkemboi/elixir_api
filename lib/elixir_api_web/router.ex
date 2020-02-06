defmodule ElixirApiWeb.Router do
  use ElixirApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  # allow handling of html resources
  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", ElixirApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

  pipeline :auth do
    plug ElixirApiWeb.Auth.Pipeline
  end

  scope "/api", ElixirApiWeb do
    pipe_through [:api, :auth] 
    resources "/business", BusinessController, except: [:new, :edit]
  end
end
