class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Foot.new(deck.take(2))
  end

  def initialize(cards)
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
        points += 11
      else
        points += card.value
      end
    end

    aces.times do
      # convert ace to 1 if score too high
      points -= 11 if points > 21
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

    (other_hand.busted?) || (self.points > other_hand.points)
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
