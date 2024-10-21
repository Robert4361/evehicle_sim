defmodule EvehicleSim.Core.Radar do
  alias __MODULE__

  @type t :: %Radar{
          id: integer(),
          max_speed: integer(),
          max_duration: integer(),
          max_distance: integer(),
          radar_address: String.t(),
          gps_width: float(),
          gps_length: float()
        }
  defstruct [
    :id,
    :max_speed,
    :max_duration,
    :max_distance,
    :radar_address,
    :gps_width,
    :gps_length
  ]

  @spec new([{String.t(), String.t()}]) :: t()
  def new(radar_info) do
    fields =
      radar_info
      |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)

    struct(__MODULE__, fields)
  end
end
