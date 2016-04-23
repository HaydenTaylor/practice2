require 'byebug'
class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    points = 0
    aces = 0
    @cards.each do |card|
      if card.value == :ace
        aces += 1
        next
      end
      points += card.blackjack_value
    end
    if aces > 0
      if points + ( aces - 1 ) <= 10
        points += 11 + (aces - 1)
      else
        points += aces
      end
    end
    points
  end

  def busted?
    return true if points > 21
  end

  def hit(deck)
    raise "already busted" if busted?
    @cards += deck.take(1)
  end

  def beats?(other_hand)
    return false if busted?
    return true if other_hand.busted?
    self.points > other_hand.points
  end

  def return_cards(deck)
    deck.return(@cards.pop(cards.length))
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
