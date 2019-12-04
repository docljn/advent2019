# frozen_string_literal: true

require './lib/intcode'

RSpec.describe Intcode do
  let(:program) { [1, 0, 0, 3, 99] }

  it "has an opcode at position zero if valid" do
    expect { Intcode.new(program) }.not_to raise_error
    expect([1, 2, 99]).to include(Intcode.new(program).opcode)
  end

  it "errors if the opcode is not 1,2 or 99" do
    expect { Intcode.new([4, 1, 2, 99]) }.to raise_error(RuntimeError)
  end

  context "parsing the opcode" do
    it "halts on 99, leaving the program unchanged" do
      intcode = Intcode.new([99, 4, 5, 6])
      intcode.run
      expect(intcode.program).to eq([99, 4, 5, 6])
    end

    it "treats the three numbers following the opcode as indexes" do
      intcode = Intcode.new([1, 2, 3, 4, 99])
      expect(intcode.input_1_value).to eq(3)
      expect(intcode.input_2_value).to eq(4)
      expect(intcode.write_address).to eq(4)
    end

    it "adds following opcode 1" do
      intcode = Intcode.new([1, 2, 3, 2, 99])
      intcode.run
      expect(intcode.program).to eq([1, 2, 5, 2, 99])
    end

    it "multiplies following opcode 2" do
      intcode = Intcode.new([2, 2, 3, 2, 99])
      intcode.run
      expect(intcode.program).to eq([2, 2, 6, 2, 99])
    end

    it "continues to run, finding an opcode every 4th index, until it reaches 99" do
      intcode = Intcode.new([1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50])
      intcode.run
      expect(intcode.program).to eq([3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50])
    end

    it "matches the examples given" do
      intcode = Intcode.new([1,0,0,0,99])
      intcode.run
      expect(intcode.program).to eq([2,0,0,0,99])

      intcode = Intcode.new([2,3,0,3,99])
      intcode.run
      expect(intcode.program).to eq([2,3,0,6,99])

      intcode = Intcode.new([2,4,4,5,99,0])
      intcode.run
      expect(intcode.program).to eq([2,4,4,5,99,9801])

      intcode = Intcode.new([1,1,1,4,99,5,6,0,99])
      intcode.run
      expect(intcode.program).to eq([30,1,1,4,2,5,6,0,99])
    end
  end

  # context "the actual query" do
  #   program = [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,19,5,23,2,23,9,27,1,5,27,31,1,9,31,35,1,35,10,39,2,13,39,43,1,43,9,47,1,47,9,51,1,6,51,55,1,13,55,59,1,59,13,63,1,13,63,67,1,6,67,71,1,71,13,75,2,10,75,79,1,13,79,83,1,83,10,87,2,9,87,91,1,6,91,95,1,9,95,99,2,99,10,103,1,103,5,107,2,6,107,111,1,111,6,115,1,9,115,119,1,9,119,123,2,10,123,127,1,127,5,131,2,6,131,135,1,135,5,139,1,9,139,143,2,143,13,147,1,9,147,151,1,151,2,155,1,9,155,0,99,2,0,14,0]
  #   intcode = Intcode.new(program)
  #   intcode.run
  #   puts
  #   puts
  #   puts "POSITION 0: "
  #   puts program[0]
  # end

  context "the second query" do
    it "calculates what pair of inputs produces the output 19690720." do
      answer = 19690720
      noun = 0
      verb = 0
      program = [1,noun,verb,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,19,5,23,2,23,9,27,1,5,27,31,1,9,31,35,1,35,10,39,2,13,39,43,1,43,9,47,1,47,9,51,1,6,51,55,1,13,55,59,1,59,13,63,1,13,63,67,1,6,67,71,1,71,13,75,2,10,75,79,1,13,79,83,1,83,10,87,2,9,87,91,1,6,91,95,1,9,95,99,2,99,10,103,1,103,5,107,2,6,107,111,1,111,6,115,1,9,115,119,1,9,119,123,2,10,123,127,1,127,5,131,2,6,131,135,1,135,5,139,1,9,139,143,2,143,13,147,1,9,147,151,1,151,2,155,1,9,155,0,99,2,0,14,0]

      original = program.dup
      
      for noun in 0..99 do
        for verb in 0..99 do
          starting_point = original.dup
          starting_point[1] = noun
          starting_point[2] = verb
          intcode = Intcode.new(starting_point)
          intcode.run
          if starting_point[0] == answer
            puts "noun: #{noun}"
            puts "verb: #{verb}"
            puts "starting_point[0] #{starting_point[0]}"
            puts (100 * noun + verb).to_s and return
          end
        end
      end
    end
  end
end
