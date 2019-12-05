# frozen_string_literal: true

require './lib/passcode'

RSpec.describe Passcode do

  it "is invalid outside the given range" do
    expect(Passcode.new(271_972).valid?).to be false
    expect(Passcode.new(785_962).valid?).to be false
  end

  it "is invalid if all digits are identical" do
    expect(Passcode.new(333_333).valid?).to be false
  end

  it "is invalid if there are no double digits" do
    expect(Passcode.new(345_678).valid?).to be false
  end

  it "is invalid if there is a run of five digits the same" do
    expect(Passcode.new(333_338).valid?).to be false
    expect(Passcode.new(566_666).valid?).to be false
  end

  it "is invalid if there is a run of four digits the same and no other double" do
    expect(Passcode.new(333_378).valid?).to be false
    expect(Passcode.new(333_388).valid?).to be true
  end

  it "is invalid if the digits decrease in value" do
    expect(Passcode.new(679_988).valid?).to be false
  end
end
