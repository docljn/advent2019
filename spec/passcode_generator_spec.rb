# frozen_string_literal: true

require './lib/passcode_generator'

RSpec.describe PasscodeGenerator do
  it "generates codes" do
    generator = PasscodeGenerator.new
    expect(generator.for_range(271973,785961).count).to be(607)
  end
end
