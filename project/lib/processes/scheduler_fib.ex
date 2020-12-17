defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    #|> IO.inspect(label: "Enviando a spawn de FibSolver :fib")
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    #|> IO.inspect( label: "Received from Fibsolver.fib")
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [ next | tail ] = queue
        send pid, {:fib, next, self()}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        #IO.inspect(pid, label: "Killing Process")
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_}  -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [ {number, result} | results ])
    end
  end
end
