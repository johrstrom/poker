module ApplicationHelper

  def card_to_img(card)
    "cards/#{card.rank}_of_#{card.suit}s.svg"
  end
end
