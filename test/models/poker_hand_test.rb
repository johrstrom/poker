
class PokerHandTest < ActiveSupport::TestCase

  test 'straight flush' do
    straight_flush = Card.deck.select { |c| c.heart? && c.rank >= Card::EIGHT }
    flush_hand = PokerHand.flush(straight_flush)
    assert_not_nil flush_hand
    assert_equal flush_hand.size, 7

    straight_hand = PokerHand.straight(straight_flush)
    assert_not_nil straight_hand
    assert_equal straight_flush, straight_hand
  end
end