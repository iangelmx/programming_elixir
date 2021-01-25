defmodule Stack do
  @moduledoc """
  This module is the external API for the Stack structure using GenServers.
  """

  @server Stack.Server

  @spec start_link(list()) :: :ignore | tuple()
  def start_link(initial_stack) do
    GenServer.start_link(@server, initial_stack, name: @server)
  end

  @spec pop :: integer()
  def pop() do
    GenServer.call(@server, :pop)
  end

  @spec push(any) :: :ok
  def push(new_element) do
    GenServer.cast(@server, {:push, new_element})
  end

  @spec show :: list()
  def show() do
    GenServer.call(@server, :show)
  end


end
