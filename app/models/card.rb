# frozen_string_literal: true

class Card

  SPADE = :spade
  HEART = :heart
  CLUB = :club
  DIAMOND = :diamond

  SUITS = [
    SPADE, HEART, CLUB, DIAMOND 
  ].freeze
  
  RANKS = {
    ace: 14,
    king: 13,
    queen: 12,
    jack: 11,
    ten: 10,
    nine: 9,
    eight: 8,
    seven: 7,
    six: 6,
    five: 5,
    four: 4,
    three: 3,
    two: 2
  }.freeze

  class << self
    def deck
      @deck ||= SUITS.map do |suit|
        RANKS.map do |rank|
          new(suit:, rank:)
        end.flatten
      end.flatten

      @deck.clone
    end

    def shuffled_deck
      deck.shuffle!
    end
  end

  # rank is a 2d vector like [:ace, 14]
  attr_reader :rank
  attr_reader :suit

  def initialize(suit: nil, rank: nil)
    @rank = rank
    @suit = suit
  end

  def rank_name
    rank[0]
  end

  def value
    rank[1]
  end

  def spade?
    suit == SPADE
  end

  def heart?
    suit == HEART
  end

  def club?
    suit == CLUB
  end

  def diamond?
    suit == DIAMOND
  end

  def to_s
    "#{rank[0]} of #{suit}s"
  end
end
