# require_relative 'deck'

class Hand
  def self.deal_from(deck)
    Hand.new(deck.deal_five)
  end

  attr_reader :cards

  def initialize(cards_array)
    cards = {}
    cards_array.each do |card|
      if cards[card]
        cards[card] += 1
      else
        cards[card] = 1
      end
    end
    @cards = cards
  end

  def have_book?
  end

  def count
  end

  def play_book!
  end

  def go_fish!
  end

  def add_cards
  end

  def remove_cards
  end

end
