# frozen_string_literal: true

require 'instruction'

class Wire

  def initialize(route = nil)
    @route = route
  end

  def path
    co_ordinates = [[0,0]]
    return co_ordinates unless route

    instructions.each do |instruction|
      starting_point = co_ordinates.last
      co_ordinates = co_ordinates + instruction.path_from(starting_point)
    end
    co_ordinates
  end

  def points
    path.uniq
  end

  def instructions
    @instructions ||= route.map { |element| Instruction.new(element) }
  end

  private

  attr_reader :route

  

end