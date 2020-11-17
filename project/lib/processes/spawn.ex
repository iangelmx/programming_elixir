defmodule Spawn1 do

  @spec greet :: any
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
    end
  end
end
