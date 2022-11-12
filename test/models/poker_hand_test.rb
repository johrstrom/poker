
class PokerHandTest < ActiveSupport::TestCase

  test 'straight flush' do
    straight_flush = Card.deck.select { |c| c.heart? && c.rank >= Card::EIGHT }
    flush_hand = PokerHand.flush(straight_flush)
    assert_not_nil(flush_hand)
    assert_equal(flush_hand.size, 7)

    # sorted
    straight_hand = PokerHand.straight(straight_flush)
    assert_not_nil(straight_hand)
    assert_equal(straight_flush, straight_hand)

    # unsorted
    straight_hand = PokerHand.straight(straight_flush.shuffle)
    assert_not_nil(straight_hand)
    assert_equal(straight_flush, straight_hand)
  end

  test '4 or less straight' do
    cards = [
      Card.new(suit: Card::HEART, rank: Card::ACE),
      Card.new(suit: Card::HEART, rank: Card::KING),
      Card.new(suit: Card::HEART, rank: Card::QUEEN),
      Card.new(suit: Card::HEART, rank: Card::JACK),
      Card.new(suit: Card::SPADE, rank: Card::TWO),
      Card.new(suit: Card::CLUB, rank: Card::FIVE),
      Card.new(suit: Card::CLUB, rank: Card::SEVEN),
    ]

    hand = PokerHand.straight(cards)
    assert_nil hand

    hand = PokerHand.flush(cards)
    assert_nil hand
  end

  test 'full house' do
    cards = [
      Card.new(suit: Card::HEART, rank: Card::ACE),
      Card.new(suit: Card::DIAMOND, rank: Card::ACE),
      Card.new(suit: Card::DIAMOND, rank: Card::QUEEN),
      Card.new(suit: Card::CLUB, rank: Card::QUEEN),
      Card.new(suit: Card::SPADE, rank: Card::QUEEN),
      Card.new(suit: Card::CLUB, rank: Card::FIVE),
      Card.new(suit: Card::CLUB, rank: Card::SEVEN),
    ]

    hand = PokerHand.full_house(cards)
    assert_not_nil(hand)
    assert_equal(7, hand.size)
    assert_equal(cards.map(&:to_s).sort, hand.map(&:to_s).sort)
    hand[0..2].each { |c| assert_equal(Card::QUEEN, c.rank) }
    hand[3..4].each { |c| assert_equal(Card::ACE, c.rank) }

    # unsorted
    hand = PokerHand.full_house(cards.shuffle)
    assert_not_nil(hand)
    assert_equal(7, hand.size)
    assert_equal(cards.map(&:to_s).sort, hand.map(&:to_s).sort)
    hand[0..2].each { |c| assert_equal(Card::QUEEN, c.rank) }
    hand[3..4].each { |c| assert_equal(Card::ACE, c.rank) }
  end

end