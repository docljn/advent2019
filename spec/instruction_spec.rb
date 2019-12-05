# frozen_string_literal: true

require './lib/instruction'

RSpec.describe Instruction do
  it "determines direction and distance" do
    instruction = Instruction.new("R5")
    expect(instruction.direction).to eq("R")
    expect(instruction.distance).to eq(5)
  end

  it "creates a series of points based on a starting reference" do
    instruction = Instruction.new("R2")
    expect(instruction.path_from([0,0])).to eq([[1,0],[2,0]])

    instruction = Instruction.new("L2")
    expect(instruction.path_from([0,0])).to eq([[-1,0],[-2,0]])

    instruction = Instruction.new("U2")
    expect(instruction.path_from([0,0])).to eq([[0,1],[0,2]])

    instruction = Instruction.new("D2")
    expect(instruction.path_from([0,0])).to eq([[0,-1],[0,-2]])
  end
end