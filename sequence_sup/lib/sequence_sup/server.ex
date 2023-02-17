defmodule SequenceSup.Server do
  use GenServer
  alias SequenceSup.Impl
  alias SequenceSup.Stash

  #####
  # External API

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  @spec next_number() :: number()
  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  @spec increment_number(number()) :: :ok
  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  #####
  # GenServer implementation

  @spec init(any) :: {:ok, any}
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

  @spec format_status(any, list()) :: Keyword.t()
  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
