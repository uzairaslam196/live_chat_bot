defmodule LiveChatBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LiveChatBot.Repo,
      # Start the Telemetry supervisor
      LiveChatBotWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveChatBot.PubSub},
      # Start the Endpoint (http/https)
      LiveChatBotWeb.Endpoint
      # Start a worker by calling: LiveChatBot.Worker.start_link(arg)
      # {LiveChatBot.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveChatBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveChatBotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
