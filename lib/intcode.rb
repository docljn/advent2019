# frozen_string_literal: true

require 'pry-byebug'

class Intcode
  attr_reader :program, :opcode_address

  def initialize(program)
    @program = program
    @opcode_address = 0
    validate
  end

  def run
    validate
    return unless opcode_address < program.size
    return if opcode == 99

    case opcode
    when 1
      program[write_address] = (input_1_value + input_2_value)
      self.opcode_address += 4
      run
    when 2
      program[write_address] = (input_1_value * input_2_value)
      self.opcode_address += 4
      run
    else
      raise RuntimeError
    end
  end

  def opcode
    program[opcode_address]
  end

  def input_1_value
    program[program[opcode_address + 1]]
  end

  def input_2_value
    program[program[opcode_address + 2]]
  end

  def write_address
    program[opcode_address + 3]
  end

  private

  attr_writer :opcode_address

  def validate
    raise RuntimeError unless [1, 2, 99].include?(program[opcode_address])
  end
end
