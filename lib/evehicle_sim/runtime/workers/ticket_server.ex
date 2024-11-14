defmodule EvehicleSim.Runtime.Workers.TicketServer do
  use GenServer

  def start_link(_init_arg) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def create_ticket(ticket) do
    GenServer.cast(__MODULE__, {:create_ticket, ticket})
  end

  @impl true
  def init(_init_arg) do
    {:ok, []}
  end

  @impl true
  def handle_cast({:create_ticket, ticket}, ticket_list) do
    {:noreply, [ticket | ticket_list]}
  end
end
