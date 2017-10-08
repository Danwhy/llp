defmodule LlpWeb.Router do
  use LlpWeb, :router

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

  scope "/", LlpWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/radicals", RadicalController
    resources "/kanji", KanjiController
  end

  # Other scopes may use custom stacks.
  # scope "/api", LlpWeb do
  #   pipe_through :api
  # end
end
