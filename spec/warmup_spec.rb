require_relative '../lib/warmup'

describe Warmup do

  let(:wm) {Warmup.new}

  describe "#gets_shout" do

    it "takes user input and returns it in all caps" do
      allow(wm).to receive(:gets).and_return("something")
      expect(wm.gets_shout).to eq("SOMETHING")
    end

  end

  describe "#triple_size" do

    context "given an array" do

      let(:fake_array) do
        double( "array", size: 5 )
      end

      it "should return the size of the array multiplied by 3" do
        expect(wm.triple_size(fake_array)).to eq(15)
      end

    end

  end

  describe "#calls_some_methods" do

      it "Should take that string and make it all caps with upcase! call" do
        my_string = double("string", upcase!: "I'M A UPCASE STRING", empty?: false)
        expect(my_string).to receive(:upcase!)
        wm.calls_some_methods(my_string)
      end

      it "Should take that string in all caps and make it backwards with reverse! call" do
        my_string = double("string", upcase!: "BACKWARDS", reverse!: "SDRAWKCAB", empty?: false)
        expect(my_string.upcase!).to receive(:reverse!)
        wm.calls_some_methods(my_string)
      end

      it "Should return a different string than the one provided" do
        my_string = double("string", upcase!: "BACKWARDS", reverse!: "SDRAWKCAB", empty?: false)
        expect(wm.calls_some_methods(my_string)).to_not eq(my_string)
      end

  end

end
