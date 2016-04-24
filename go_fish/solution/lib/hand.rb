# require_relative 'deck'

class Hand
  def self.deal_from(deck)
    cards_hash = Hash.new { |h, k| h[k] = 0 }
    1.upto(13) { |num| cards_hash[num] }

    deck.deal_five.each do |card|
      cards_hash[card] += 1
    end

    Hand.new(cards_hash)
  end

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def have_book?
    cards.values.include?(4)
  end


  def count(val)
    @cards[val]
  end

  def play_book!
    raise "No book found!" unless have_book?

    cards.each do |val, num|
      cards[val] = 0 if num == 4
    end
  end

  def go_fish!(deck)
    @cards[deck.take] += 1
  end

  def add_cards(val, num_cards)
    @cards[val] += num_cards
  end

  def remove_cards(val)
    @cards[val] = 0
  end

end
