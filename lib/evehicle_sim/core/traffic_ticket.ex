defmodule EvehicleSim.Core.TrafficTicket do
  alias __MODULE__

  @type t() :: %TrafficTicket{
          vehicle_id: integer(),
          time_start: integer(),
          time_end: integer(),
          speed: float(),
          gps_width: float(),
          gps_length: float(),
          radar_name: String.t()
        }

  defstruct [
    :vehicle_id,
    :time_start,
    :time_end,
    :speed,
    :gps_width,
    :gps_length,
    :radar_name
  ]

  @spec new(integer(), integer(), integer, float(), float(), float(), String.t()) :: t()
  def new(
        vehicle_id,
        time_start,
        time_end,
        speed,
        gps_width,
        gps_length,
        radar_name
      ) do
    %TrafficTicket{
      vehicle_id: vehicle_id,
      time_start: time_start,
      time_end: time_end,
      speed: speed,
      gps_width: gps_width,
      gps_length: gps_length,
      radar_name: radar_name
    }
  end
end
