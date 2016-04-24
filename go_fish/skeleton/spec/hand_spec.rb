require 'rspec'
require 'hand'

describe Hand do
  describe "::deal_five_from" do

    deck_cards = [6, 3, 8, 8, 1]
    cards_hash = {
      1 => 1,
      3 => 1,
      6 => 1,
      8 => 2
    }
    let(:deck) { double("deck", :deal_five => deck_cards) }

    it "deals a hand of five cards" do
      hand = Hand.deal_from(deck)
      expect(hand.cards).to include(
      1 => 1,
      3 => 1,
      6 => 1,
      8 => 2
      )
    end
  end

  let(:book_deck) { double("book_deck", :deal_five => [1, 2, 1, 1, 1]) }
  let(:no_book_deck) { double("no_book_deck", :deal_five => [1, 2, 3, 4, 5]) }

  describe '#have_book?' do
    it "returns true if book found" do
      hand = Hand.deal_from(book_deck)

      expect(hand.have_book?).to eq(true)
    end

    it "returns false if no book found" do
      hand = Hand.deal_from(no_book_deck)

      expect(hand.have_book?).to eq(false)
    end
  end

  describe '#count(val)' do
    it "returns the relevant number of cards" do
      hand = Hand.deal_from(no_book_deck)
      expect(hand.count(5)).to eq(1)
      expect(hand.count(7)).to eq(0)
    end
  end

  describe 'play_book!' do
    it "raises error if no book found" do
      hand = Hand.deal_from(no_book_deck)
      expect{ hand.play_book! }.to raise_error("No book found!")
    end

    it "removes book" do
      hand = Hand.deal_from(book_deck)
      hand.play_book!
      expect(hand.cards[1]).to eq(0)
    end
  end

  describe 'go_fish!(deck)' do
    let(:deck) { double("deck", :take => 7) }
    let(:empty_deck) do
      double("empty_deck", :take => raise("No more cards!"))
    end

    it "takes a card from the deck" do
      hand = Hand.deal_from(no_book_deck)

      expect(deck).to receive(:take)
      hand.go_fish!(deck)
      expect(hand.cards[7]).to eq(1)
    end
  end

  context "adding/removing cards" do
    let(:deck) { double("deck", :deal_five => [7, 12, 12, 12, 12]) }
    subject(:hand) { Hand.deal_from(deck) }

    describe '#add_cards(val)' do

      it "adds a card" do
        hand.add_cards(4, 1)
        expect(hand.cards[4]).to eq(1)
      end

      it "adds several cards in succession" do
        hand.add_cards(4, 2)
        hand.add_cards(4, 1)
        expect(hand.cards[4]).to eq(3)
      end
    end

    describe '#remove_cards(val)' do
      let(:deck) { double("deck", :deal_five => [1, 12, 12, 12, 12]) }
      subject(:hand) { Hand.deal_from(deck) }

      it "removes a card and all its duplicates" do
        hand.remove_cards(12)
        expect(hand.cards[12]).to eq(0)
      end
    end
  end
end
