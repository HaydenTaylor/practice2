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
    @hand << deck.draw if @hand.none? {|card| card.valid_match?(deck.last_discarded)}
  end

  def play_card(deck)
    card = @interface.choose_card(self)
    card.set_suit(@interface.choose_suit) if card.crazy?
    deck.discard(card)
    @hand.delete(card)
  end

end
