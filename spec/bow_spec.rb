require_relative '../lib/weapons/bow.rb'

describe Bow do

  let(:bow) {Bow.new}

  describe "#arrows" do

    it "Should be readable" do

    end

    it "Should start with 10 arrows" do
      expect(bow.arrows).to eq(10)
    end

    it "Should initialize with number of arrows specified" do
      new_bow = Bow.new(20)
      expect(new_bow.arrows).to eq(20)
    end


  end

  describe "#use" do

    it "should reduce arrows by one every time use is called" do
      expect{bow.use}.to change{bow.arrows}.by(-1)
    end

    it "Should throw an error when there arrows = 0" do
      bow = double("empty bow", out_of_arrows?: true)
      expect{bow.use}.to raise_error{"Out of arrows"}
    end

  end

end
