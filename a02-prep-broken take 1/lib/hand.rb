require 'byebug'

class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_reader :cards

  def initialize(cards = deal_from(deck))
    @cards = cards
  end

  def points
    points = 0
    aces = 0

    cards.each do |card|
      case card.value
      when :ace
        aces += 1
        # treat aces as 11s, we'll reduce later
      else
        points += card.blackjack_value
      end
    end

    if aces > 0  # convert ace to 1 if score too high
      if points + (aces - 1) <= 10
        points += 11
      else
        points += aces
      end
    end
    points
  end

  def busted?
    points > 21
  end

  def hit(deck)
    raise "already busted" if busted?

    @cards.concat(deck.take(1))
  end

  def beats?(other_hand)
    return false if busted?
    return true if other_hand.busted?
    self.points > other_hand.points
  end

  def return_cards(deck)
    deck.return(cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
