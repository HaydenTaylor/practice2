require_relative 'card'
require 'byebug'

# Represents a deck of playing cards.
class Deck

  # Returns an array of all 52 playing cards.
  def self.all_cards
    cards = []
    Card.suits.product(Card.values).each do |card_type|
      cards << Card.new(*card_type)
      # debugger
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards

  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if count < n
    @cards.shift(n)
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards.push(*cards) #splat to remove from array
  end
end
