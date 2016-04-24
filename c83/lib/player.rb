require_relative 'UI'

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name, interface = Interface.new)
    @name = name
    @hand = []
    @interface = interface
  end

  def hand_size
    @hand.count
  end

  def draw(deck)
    @hand << deck.draw
  end

  def play_turn(deck)
    get_cards(deck)
    play_card(deck)
  end

  #in this version, you can only draw if you have no valid cards to play.
  def get_cards(deck)
    draw(deck) unless @hand.any? {|card| card.valid_match?(deck.last_discarded)}
  end

  def play_card(deck)
    card = @interface.choose_card(self)
    if card.crazy?
      card.set_suit(@interface.choose_suit)
    end
    deck.discard(card)
    @hand.delete(card)

  end

end
