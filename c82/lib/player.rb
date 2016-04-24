require_relative 'UI'
require 'byebug'


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
    return if @hand.any? {|c| c.valid_match?(deck.last_discarded)}
    @hand << deck.draw
  end

  def play_card(deck)
    card = @interface.choose_card(self)
    deck.discard(card)
    @interface.choose_suit if card.crazy?
    @hand.delete(card)
  end

end
