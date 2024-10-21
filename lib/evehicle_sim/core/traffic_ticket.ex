defmodule EvehicleSim.Core.TrafficTicket do
  alias __MODULE__

  @type t() :: %TrafficTicket{
          vehicle_id: integer(),
          time_start: integer(),
          time_end: integer(),
          speed: float(),
          gps_width: float(),
          gps_length: float(),
          radar_gps_width: float(),
          radar_gps_length: float()
        }

  defstruct [
    :vehicle_id,
    :time_start,
    :time_end,
    :speed,
    :gps_width,
    :gps_length,
    :radar_gps_width,
    :radar_gps_length
  ]

  @spec new(integer(), integer(), integer, float(), float(), float(), float(), float()) :: t()
  def new(
        vehicle_id,
        time_start,
        time_end,
        speed,
        gps_width,
        gps_length,
        radar_gps_width,
        radar_gps_length
      ) do
    %TrafficTicket{
      vehicle_id: vehicle_id,
      time_start: time_start,
      time_end: time_end,
      speed: speed,
      gps_width: gps_width,
      gps_length: gps_length,
      radar_gps_width: radar_gps_width,
      radar_gps_length: radar_gps_length
    }
  end
end
