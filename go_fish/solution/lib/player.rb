class Player

  attr_accessor :hand
  attr_reader :name, :cheese_preference, :score

  def initialize(name, cheese_preference)
    @name = name
    @cheese_preference = cheese_preference
    @score = 0
  end

  def have_any?(val)
    @hand.count(val) > 0
  end

  def give(val, num_cards, player)
    @hand.remove_cards(val)
    player.receive(val, num_cards)
  end

  def receive(val, num_cards)
    @hand.add_cards(val, num_cards)
  end

  def ask_for(val, opponent)
    if opponent.have_any?(val)
      opponent.give(val, opponent.hand.count(val), self)
    else
      @hand.go_fish!
    end
  end

  def score_book
    @score += 1
    @hand.play_book
  end
end
