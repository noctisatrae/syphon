defmodule Scan do
  require Logger

  # https://hexdocs.pm/elixir/1.16.1/Port.html
  def targets(target_map, default_flags, timeout) do
    Enum.map(target_map, fn {target, flags} ->
      scan_task = Scan.Genserver.start_link(target, default_flags ++ flags, timeout)
      scan_task
    end)
  end

  def targets(target_map, timeout) do
    Enum.map(target_map, fn {target, flags} ->
      scan_task = Scan.Genserver.start_link(target, flags, timeout)
      scan_task
    end)
  end
end

defmodule Scan.Genserver do
  use GenServer
  require Logger

  def start_link(target, flags, timeout) do
    # Generate a unique atom based on the module name and the target
    name = Module.concat(__MODULE__, String.replace(target, ".", "_"))
    GenServer.start_link(__MODULE__, %{target: target, flags: flags, timeout: timeout}, name: name)
  end


  def init(%{target: target, flags: flags, timeout: timeout}) do
    # Initialize the state with the target and flags
    state = %{target: target, flags: flags}
    # Log the initialization + add timeout
    Process.send_after(self(), :kill_process, timeout)
    Logger.info("Starting scan with target: #{target} and flags: #{inspect(flags)}")
    # Return the initial state and the continue action
    {:ok, state, {:continue, :start_scan}}
  end

  def handle_continue(:start_scan, state = %{target: target, flags: flags}) do
    cmd = "nmap #{target} #{flags}"

    port = Port.open({:spawn, cmd}, [:binary, :exit_status])

    state = Map.put(state, :port, port)
    {:noreply, state}
  end

  def handle_info({port, {:data, result}}, state) when is_port(port) do
    target = state.target
    today = Date.utc_today() |> Date.to_string()

    File.mkdir_p("scans_result/#{today}/")
    File.write!("scans_result/#{today}/#{String.replace(target, ["."], "_")}.txt", result, [:append])
    {:noreply, state}
  end

  def handle_info({port, {:exit_status, status}}, state) when is_port(port) do
    case status do
      0 -> {:stop, :normal, state}
      _ -> {:stop, :error, state}
    end
  end

  def handle_info(:kill_process, state) do
    Logger.warning("GenServer took too long, terminating process.")
    {:stop, :timeout, state}
  end

  def terminate(reason, state) do
    Logger.info("Scan exited with reason #{inspect(reason)} and state #{inspect(state)}.")
  end
end

# defmodule OSScan do
#   require Arguments

#   def scan(target) do
#     {stream, err_code} = System.cmd("nmap", ["#{target}"], into: IO.stream())
#     {stream, err_code}
#   end
# end
