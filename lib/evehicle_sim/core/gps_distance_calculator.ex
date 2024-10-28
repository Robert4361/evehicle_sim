defmodule EvehicleSim.Core.GpsDistanceCalculator do
  @earth_radius 6371.009

  # formula taken from https://www.vcalc.com/wiki/vcalc/haversine-distance
  def calculate_distance_km(lat1, lon1, lat2, lon2) do
    lat1 = degrees_to_radians(lat1)
    lon1 = degrees_to_radians(lon1)
    lat2 = degrees_to_radians(lat2)
    lon2 = degrees_to_radians(lon2)

    dlat = lat2 - lat1
    dlon = lon2 - lon1

    a = :math.sin(dlat / 2) |> :math.pow(2)
    b = :math.sin(dlon / 2) |> :math.pow(2)
    c = :math.cos(lat1) * :math.cos(lat2)
    d = :math.sqrt(a + b * c)

    2 * :math.asin(d) * @earth_radius
  end

  def calculate_distance_m(lat1, lon1, lat2, lon2) do
    calculate_distance_km(lat1, lon1, lat2, lon2) * 1000
  end

  def degrees_to_radians(value), do: value * (:math.pi() / 180)
end
