class Deck
  def self.all_cards
    ((1..13).to_a * 4)
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def shuffle!
    @cards = cards.shuffle
  end

  def deal_five
    @cards.shift(5)
  end

  def take
    raise "No more cards!" if @cards.empty?
    @cards.shift
  end
end
