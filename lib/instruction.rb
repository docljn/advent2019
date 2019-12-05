# frozen_string_literal: true

class Instruction

  attr_reader :direction, :distance
  def initialize(data)
    @direction = data[0].upcase
    @distance = data.delete(direction).to_i
  end

  def ==(other)
    direction.equal?(other.direction)
    distance.equal?(other.distance)
  end

  def path_from(starting_point)
    x = starting_point[0]
    y = starting_point[1]
    path = []

    case direction
    when 'R'
      distance.times do 
        path << [x+=1, y]
      end
    when 'L'
      distance.times do 
        path << [x-=1, y]
      end
    when 'U'
      distance.times do 
        path << [x, y+=1]
      end
    when 'D'
      distance.times do 
        path << [x, y-=1]
      end
    end
    path
  end
end