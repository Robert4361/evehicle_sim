defmodule EvehicleSim.Core.Simulator do
  alias EvehicleSim.Core.Vehicle
  alias EvehicleSim.Runtime.Supervisors.RadarSupervisor

  def start_radars() do
    RadarSupervisor.start_radar("radar1.txt")
    RadarSupervisor.start_radar("radar2.txt")
    RadarSupervisor.start_radar("radar3.txt")
    RadarSupervisor.start_radar("radar4.txt")
  end

  def start_vehicle() do
    vehicle = Vehicle.new("vehicle1.csv")
    Vehicle.start_drive(vehicle)
  end
end
