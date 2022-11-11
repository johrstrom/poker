class PokerHand

  attr_reader :cards, :flush_cards, :straight_cards

  def initialize
    @cards = []
  end

  def flush?
    @flush_clards ||= cards.group_by do |c| 
      c.suit
    end.map do |suit, cards|
      if cards.size >= 5
        @flush_suit = suit
        cards.sort_by(&:c.rank)
      end
    end.compact.first

    !@flush_cards.nil?
  end

  def flush_high
    flush.first.rank if flush?
  end

  def straight?
    cards.sort_by(&:c.rank).inject(false) do |straight, cards|
      cards.each_cons(5) do |straight_cards|
        
      end
    end
  end

  def straight_high
  end

  def straight_flush?
  end

  
end