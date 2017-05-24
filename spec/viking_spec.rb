require_relative '../lib/viking'

describe Viking do

  let(:viking) {Viking.new("Viking", 98)}


  context "on initialize" do

    describe "#name" do

      it "Should accept and set name attribute" do
        expect(viking.name).to eq("Viking")
      end

    end

    describe "#health" do

      it "Should accept and set HEALTH attribute" do
        expect(viking.health).to eq(98)
      end

      it "Cannot be overwritten once initialized" do
        expect{viking.health = 100}.to raise_error
      end

    end

    describe "#weapon" do

      it "Should begin game with nil" do
        expect(viking.weapon).to be_nil
      end

    end

  end

  describe "#pick_up_weapon" do

    let(:weapon) {Weapon.new("Bow")}
    let(:non_weapon) {"Kisses"}
    let(:new_weapon) {Weapon.new("Axe")}

    it "Should set Weapon as Viking's Weapon" do
      viking.pick_up_weapon(weapon)
      expect(viking.weapon.name).to eq("Bow")
    end

    it "Should raise an error if it is not a weapon" do
      expect {viking.pick_up_weapon(non_weapon)}.to raise_error("Can't pick up that thing")
    end

    it "Should replace weapon Viking currently has" do
      viking.pick_up_weapon(weapon)
      viking.pick_up_weapon(new_weapon)
      expect(viking.weapon).to eq(new_weapon)
    end

  end

  describe "#drop_weapon" do

    it "Should leave Viking weaponless, ie) weapon is nil" do
      viking.drop_weapon
      expect(viking.weapon).to eq(nil)
    end

  end

  describe "#receive_attack" do

    it "Reduces health by specified amount" do
      expect{ viking.receive_attack(3) }.to change{ viking.health }.by(-3)
    end

    it "It calls #take_damage" do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(3)
    end

  end

  describe "#attack" do

    let(:another_viking) {Viking.new("Another Viking")}

    it "Causes recipient Viking's health to decrease" do
      expect{ viking.attack(another_viking) }.to change{ another_viking.health }
    end

    it "Calls #take_damage on recipient Viking" do
      expect(another_viking).to receive(:take_damage)
      viking.attack(another_viking)
    end

    context "Without a weapon" do

      it "Calls #damage_with_fists" do
         expect(another_viking).to receive(:damage_with_fists).and_call_original
         another_viking.attack(viking)
      end

      it "Deals damage equal to @fist multiplier times @strength" do
        expected_damage = another_viking.strength * Fists.new.use
        expect(viking).to receive(:receive_attack).with(expected_damage)
        another_viking.attack(viking)
      end

    end

    context "With a weapon" do

      let(:bow) {Weapon.new("Bow")}

      it "Calls #damage_with_weapon" do
        viking.pick_up_weapon(bow)
        expect(viking).to receive(:damage_with_weapon).and_call_original
        viking.attack(another_viking)
      end

      it "Deals damage equal to Viking's @strength times @weapons multiplier" do
        another_viking.pick_up_weapon(bow)
        expected_damage = another_viking.strength * bow.use
        expect(viking).to receive(:receive_attack).with(expected_damage)
        another_viking.attack(viking)
      end

    end

    context "With a Bow without enough arrows" do

      it "Uses Fists instead" do
        bow = Bow.new(1)
        another_viking.pick_up_weapon(bow)
        another_viking.attack(viking)
        expect(another_viking).to receive(:damage_with_fists).and_call_original
        another_viking.attack(viking)
      end
  
    end

  end

  describe "#check_death" do

    it "Raises and error when a Viking dies" do
      new_viking = Viking.new("Bob", 1)
      expect{viking.attack(new_viking)}.to raise_error
    end

  end

end
