require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  attr_reader :discard_pile
  def self.all_cards
    cards = []
    Card.suits.product(Card.values).each do |unique_card|
      cards << Card.new(*unique_card)
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
    @discard_pile = []
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  def shuffle

  end

  def last_discarded
    @discard_pile.last

  end

  # Takes a card from the top of the deck, returns a card.
  def draw
    raise "not enough cards" if @cards.empty?
    @cards.pop
  end

  # Allow players to place cards on the discard pile
  def discard(card)
    @discard_pile << card
  end

  # puts top card of the deck in the discard pile
  def show_top_card
    discard(draw)
  end
end
