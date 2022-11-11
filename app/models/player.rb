class Player

  attr_reader :hand

  def add_card(card)
    @hand << card
  end

  def clear_hand
    @hand = PokerHand.new()
  end
end