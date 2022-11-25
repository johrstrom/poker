class PokerHand

  FOUR_OF_A_KIND = 1
  STRAIGHT_FLUSH = 2
  FULL_HOUSE = 3
  FLUSH = 4
  STRAIGHT = 5
  THREE_OF_A_KIND = 6
  TWO_PAIR = 7
  PAIR = 8
  HIGHEST_CARD = 9

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

    def straight_flush(cards)
      straight(cards) ? flush(cards) : nil
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

    def four_of_a_kind(cards)
      n_of_a_kind(cards, 4)
    end

    def three_of_a_kind(cards)
      n_of_a_kind(cards, 3)
    end

    def two_of_a_kind(cards)
      n_of_a_kind(cards, 2)
    end

    def n_of_a_kind(cards, n)
      groups = cards.group_by(&:rank).sort_by { |arr| arr.second.size }.reverse

      if groups.first.second.size == n
        cards = groups.map(&:second).flatten
        pair = cards[0..n - 1]
        others = cards.reject { |c| pair.include?(c) }.sort_by(&:rank).reverse

        pair + others
      end
    end

    def two_pair(cards)
    end
  end

  attr_reader :cards

  def initialize
    @cards = []
  end

  def <<(card)
    @cards << card if card.is_a?(Card)
  end

  def hand(community_cards)
    all_seven = @cards + community_cards
    hand = PokerHand.full_house(all_seven)
    if hand
      @hand = PokerHand::FULL_HOUSE
    end

    hand = PokerHand.straight_flush(all_seven)
    if hand
      @hand = PokerHand::STRAIGHT_FLUSH
    end

    hand = PokerHand.flush(all_seven)
    if hand
      @hand = PokerHand::FLUSH
    end

    hand = PokerHand.straight(all_seven)
    if hand
      @hand = PokerHand::STRAIGHT
    end

    hand = PokerHand.three_of_a_kind(cards)
    if hand
      @hand = PokerHand::THREE_OF_A_KIND
    end

    # hand = PokerHand.multiple_of_a_kind(all_seven)

    # four of a kind
    # full house
    # flush
    # straight
    # three of a kind
    # two of a kind
    # sorted by rank
  end

  def ==(other)
  end

  def >=(other)
  end

  def flush_high
    flush.first.rank if flush?
  end

  def straight_high
  end

  def straight_flush?
  end

  
end