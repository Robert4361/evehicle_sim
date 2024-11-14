defmodule EvehicleSim.Core.RadarDriveData do
  alias __MODULE__
  alias EvehicleSim.Core.VehicleDriveData

  @type t :: %RadarDriveData{
          id: integer(),
          time: float(),
          gps_speed: float(),
          latitude: float(),
          longitude: float()
        }
  defstruct [:id, :time, :gps_speed, :latitude, :longitude]

  def new(id, vehicle_drive_data) do
    %VehicleDriveData{
      milliseconds_since_epoch: milliseconds_since_epoch,
      gps_speed: gps_speed,
      latitude: latitude,
      longitude: longitude
    } = vehicle_drive_data

    %RadarDriveData{
      id: id,
      time: milliseconds_since_epoch,
      gps_speed: gps_speed,
      latitude: latitude,
      longitude: longitude
    }
  end

  def new(id, time, gps_speed, latitude, longitude) do
    %RadarDriveData{
      id: id,
      time: time,
      gps_speed: gps_speed,
      latitude: latitude,
      longitude: longitude
    }
  end
end
