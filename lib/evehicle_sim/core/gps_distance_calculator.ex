defmodule EvehicleSim.Core.GpsDistanceCalculator do
  def calculate_distance_km(lat1, lon1, lat2, lon2) do
    x1 = lat1 * (:math.pi() / 180)
    y1 = lon1 * (:math.pi() / 180)
    x2 = lat2 * (:math.pi() / 180)
    y2 = lon2 * (:math.pi() / 180)

    a =
      :math.pow(:math.sin((x2 - x1) / 2), 2) + :math.cos(x1) +
        :math.cos(x2) * :math.pow(:math.sin((y2 - y1) / 2), 2)

    angle = 2 * :math.asin(min(1, :math.sqrt(a)))

    angle_degrees = angle * 180 / :math.pi()

    60 * angle_degrees * 1.852
  end

  def calculate_distance_m(lat1, lon1, lat2, lon2) do
    calculate_distance_km(lat1, lon1, lat2, lon2) * 1000
  end
end
