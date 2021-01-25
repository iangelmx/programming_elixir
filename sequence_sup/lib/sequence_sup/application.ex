defmodule SequenceSup.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: SequenceSup.Worker.start_link(arg)
      # {SequenceSup.Worker, arg}
      {SequenceSup.Stash, 123},
      {SequenceSup.Server, nil},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: SequenceSup.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
