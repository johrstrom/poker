class PokerHand

  class << self
    def flush(cards)
      cards.group_by(&:suit).map do |_suit, suited_cards|
        return suited_cards.sort_by(&:rank) if suited_cards.size >= 5
      end

      nil
    end

    def straight(cards)
      sorted = cards.sort_by(&:rank).reverse
      running = true

      sorted.each_cons(2).with_index do |couple, idx|
        difference = couple.first.rank - couple.second.rank
        running = false unless difference == 1 && idx <= 5

        break unless running
      end

      running ? sorted : nil
    end

    def full_house(cards)
      three_kind = nil
      pair = nil

      cards.group_by(&:rank).each do |_rank, group|
        case group.size
        when 3
          three_kind = group
        when 2
          pair = group
        end
      end

      if three_kind && pair
        hand = three_kind + pair
        extra = cards - hand

        hand + extra
      end
    end

    def multiple_of_a_kind(cards)
      groups = cards.group_by(&:rank)
      if groups.size == 7
        nil
      else
        cards.sort_by(&:rank).reverse
      end
    end
  end

  attr_reader :cards, :flush_cards, :straight_cards

  def initialize
    @cards = []
  end

  def <<(card)
    @cards << card if card.is_a?(Card)
  end

  def best5(community_cards)
    all_seven = @cards + community_cards
    # four of a kind
    # full house
    # flush
    # straight
    # three of a kind
    # two of a kind
    # sorted by rank
  end

  def flush_high
    flush.first.rank if flush?
  end

  def straight_high
  end

  def straight_flush?
  end

  
end