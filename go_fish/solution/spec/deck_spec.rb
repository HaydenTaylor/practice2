require 'rspec'
require 'deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "starts with a count of 52" do
      expect(all_cards.count).to eq(52)
    end

    it "returns 1-13 with four copies of each" do
      1.upto(13) { |num| expect(all_cards.count(num)).to eq(4) }
    end
  end

  subject(:deck) { Deck.new }

  it "does not expose its cards directly" do
    expect(deck).not_to respond_to(:cards)
  end

  it "initializes with the factory method" do
    expect(Deck).to receive(:all_cards)
    Deck.new
  end

  let(:cards) { [1, 4, 9, 3, 5, 7, 1] }

  describe '#deal_five' do
    let(:deck) { Deck.new(cards) }

    it "takes five cards from the top" do
      expect(deck.deal_five).to eq([1, 4, 9, 3, 5])
    end
  end

  describe "#take" do
    let(:deck) { Deck.new(cards) }
    # The front of the array is the 'top'
    it "takes one card the top of the deck" do
      expect(deck.take).to eq(1)
    end

    # let(:empty_deck) { double("deck", :take => raise("No more cards in deck!")) }
    it "doesn't allow taking cards from empty deck" do
      deck = Deck.new([])
      expect{deck.take}.to raise_error "No more cards!"
    end
  end
end
