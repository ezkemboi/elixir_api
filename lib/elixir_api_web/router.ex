defmodule ElixirApiWeb.Router do
  use ElixirApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirApiWeb do
    pipe_through :api
    resources "/business", BusinessController, except: [:new, :edit]
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
end
