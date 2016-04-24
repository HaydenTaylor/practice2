require 'rspec'
require 'player'

describe Player do
  subject(:brenda) { Player.new("Barbara", "Gruyere") }

  it "sets the name" do
    expect(brenda.name).to eq("Barbara")
  end

  it "sets the cheese preference" do
    expect(brenda.cheese_preference).to eq("Gruyere")
  end

  deck_cards = [1, 3, 6, 8, 8]
  let(:deck) { double("deck", :deal => deck_cards)}
  cards_hash = {
    1 => 1,
    3 => 1,
    6 => 1,
    8 => 2
  }

  let(:hand) { double("hand") }
  it "exposes the hand attribute" do
    expect { brenda.hand = hand } .not_to raise_error
  end

  context "when queried for hand contents" do
    describe '#have_any?' do
      it "delegates to hand's #count" do
        brenda.hand = hand
        allow(hand).to receive(:count).with(3).and_return(1)
        expect(hand).to receive(:count).with(3)
        brenda.have_any?(3)
      end
    end
  end

  context "during opponent interaction" do
    let(:lupe) { double("lupe") }
    let(:hand) { double("hand") }

    describe '#ask_for(val, opponent)' do
      before(:each) { brenda.hand = hand }

      it "asks opponent for cards" do
        allow(brenda.hand).to receive(:add_cards)
        allow(lupe.hand).to receive(:remove_cards)
        allow(lupe.hand).to receive(:count).with(11).and_return(3)
        expect(lupe).to receive(:have_any?).with(11).and_return(true)
        brenda.ask_for(11, lupe)
      end
    end

    let(:lupe) { Player.new("Lupe", "Queso fresco") }

    context "and opponent has requested card" do
      it "forces opponent to give card" do
        allow(lupe).to receive(:have_any?).with(1).and_return(true)
        allow(lupe.hand).to receive(:count).with(1).and_return(3)
        expect(lupe).to receive(:give).with(1, 3, brenda)
        brenda.ask_for(1, lupe)
      end
    end

    context "and opponent does not have requested card" do
      it "triggers hand#go_fish!" do
        allow(lupe.hand).to receive(:count).with(1).and_return(0)
        expect(brenda.hand).to receive(:go_fish!)
        brenda.ask_for(1, lupe)
      end
    end

    describe "#give(val, opponent)" do

      before(:each) { brenda.hand = hand }
      it "removes card(s) from hand" do

        allow(lupe).to receive(:receive).with(6, 3)
        expect(brenda.hand).to receive(:remove_cards).with(6)
        brenda.give(6, 3, lupe)
      end

      it "tells other player to receive card(s)" do
        allow(brenda.hand).to receive(:remove_cards).with(6)
        expect(lupe).to receive(:receive).with(6, 3)
        brenda.give(6, 3, lupe)
      end
    end

    describe "#receive(val, num_cards)" do
      it "adds card(s) to hand" do
        allow(brenda.hand).to receive(:add_cards)
        expect(brenda.hand).to receive(:add_cards).with(5, 2)
        brenda.receive(5, 2)
      end
    end
  end

  describe "#score_book" do
    before(:each) { brenda.hand = hand }
    it "scores a book as normal" do
      allow(brenda.hand).to receive(:play_book)
      brenda.score_book
      expect(brenda.score).to eq(1)
    end

    it "triggers the hand's #play_book method" do
      allow(brenda.hand).to receive(:play_book)
      expect(brenda.hand).to receive(:play_book)
      brenda.score_book
    end
  end
end
