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

  def shortest_loop
    return if intersections.empty?

    loops = []
    # refactor to abort if the path you're looking at is longer than the one found!
    intersections.each do |point|
      path1 = wire1.steps_to(point)
      next if (!loops.empty? && (path1 >= loops.last) )

      path2 = wire2.steps_to(point)

      total_path = path1 + path2

      loops << total_path unless (!loops.empty? && (total_path >= loops.last)) 
    end

    loops.sort!
    loops[0]
  end
end