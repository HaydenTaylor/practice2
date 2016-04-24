class Deck
  attr_reader :cards

  def initialize(decks = 1)
    cards = []
    decks.times do
      Card.suits.product(Card.values).each do |card_type|
        cards << Card.new(*card_type)
      end
    end
    @cards = cards
  end





end #deck class
