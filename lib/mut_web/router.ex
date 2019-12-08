defmodule MutWeb.Router do
  use MutWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MutWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", MutWeb do
    pipe_through :api

    get "/get/:code/:num/state.txt", MutController, :show
    get "/update/:code/:num", MutController, :update
    get "/new/:code", MutController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", MutWeb do
  #   pipe_through :api
  # end
end
