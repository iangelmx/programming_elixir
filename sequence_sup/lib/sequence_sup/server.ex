defmodule SequenceSup.Server do
  use GenServer
  alias SequenceSup.Impl
  alias SequenceSup.Stash

  #####
  # External API

  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  #####
  # GenServer implementation

  def init(_) do
    { :ok, SequenceSup.Stash.get() }
  end

  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, Impl.next(current_number) }
  end

  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, Impl.increment(current_number,delta)}
  end

  def terminate(_reason, current_number) do
    Stash.update(current_number)
  end
  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
