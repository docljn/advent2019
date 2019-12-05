# frozen_string_literal: true

class Grid

  attr_reader :wire1, :wire2

  def initialize(wire1, wire2)
    @wire1 = wire1
    @wire2 = wire2
  end

  def intersections
    crossing_points = wire1.points & wire2.points
    crossing_points.delete([0,0])
    crossing_points
  end

  def manhattan_distance
    return if intersections.empty?
    
    distances = intersections.map { |intersection| intersection[0].abs + intersection[1].abs }
    distances.sort!
    distances[0]
  end
end