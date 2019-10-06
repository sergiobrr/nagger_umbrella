defmodule NaggerWeb.Router do
  use NaggerWeb, :router

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

  scope "/", NaggerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/nuances", NuanceController
  end

  scope "/api", NaggerWeb do
    pipe_through :api
    resources "/tags", TagController, except: [:new, :edit]
  end

  forward "/admin", AdminWeb.Router
  forward "/apiweb", ApiWeb.Router

end
