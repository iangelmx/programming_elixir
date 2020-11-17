defmodule WorkingWithMultipleProcesses do

  def sends_message(parent_pid) do
    send( parent_pid, {:ok, "Hey... dad?"} )
    exit(:kaboom)
    # raise "Exception raised :v"
  end

  def parent_proc() do
    receive do
      message ->
        IO.puts "MESSAGE RECEIVED: #{inspect message}"
        parent_proc()
    after 1000 -> IO.puts("Finished parent :$")
    end
  end

  def run() do
    IO.puts("Started...")
    # Process.flag(:trap_exit, true)

    # When we use spawn_link, we need to specify with Process.flag if we need to capture
    # the ends of a process. Although, it shows :EXIT signal when the process dies by
    # other reason
    # spawn_link(WorkingWithMultipleProcesses, :sends_message, [self()])

    # Spawn monitor tracks good the exit and failures of processes, but it shows :DOWN signal
    # when a process ends or fails.
    spawn_monitor(WorkingWithMultipleProcesses, :sends_message, [self()])

    :timer.sleep(500)

    parent_proc()

  end

end

WorkingWithMultipleProcesses.run()
