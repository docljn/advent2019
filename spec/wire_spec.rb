# frozen_string_literal: true

require './lib/wire'

RSpec.describe Wire do

  it "starts at 0,0" do
    wire = Wire.new
    expect(wire.path).to eq([[0,0]])
  end

  it "has many instructions" do
    wire = Wire.new(['R5', 'L5'])
    expect(wire.instructions).to eq([Instruction.new('R5'), Instruction.new('L5')])
  end

  it "builds a path from instructions" do
    wire = Wire.new(['U5'])
    expect(wire.path).to eq([[0,0],[0,1],[0,2],[0,3],[0,4],[0,5]])

    wire = Wire.new(['U2', 'D2'])
    expect(wire.path).to eq([[0,0],[0,1],[0,2],[0,1],[0,0]])
  end

  it "excludes self-crossing points" do
    wire = Wire.new(['U2', 'D2'])
    expect(wire.path).to eq([[0,0],[0,1],[0,2],[0,1],[0,0]])
    expect(wire.points).to eq([[0,0],[0,1],[0,2]])
  end

  it "calculates the number of steps to a given point on the path" do
    wire = Wire.new(['U2', 'R2'])
    expect(wire.steps_to([0,0])).to eq(0])
    expect(wire.steps_to([1,2])).to eq(3)
  end
end