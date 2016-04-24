require 'byebug'
class Deck
  def self.all_cards
    cards = []
    (1..13).each do |i|
      4.times do
        cards << i
      end
    end
    cards
  end



  def initialize(cards = Deck.all_cards)
    @cards = cards
    #@cards.shuffle! #cannot just call shuffle. rspec issue on 25
  end

  def shuffle!
    # debugger
    @cards.shuffle!
  end

  def deal_five
    @cards.shift(5)
  end

  def take
    raise "No more cards!" if @cards.count < 1
    @cards.shift
  end


  private
  attr_reader :cards



end
