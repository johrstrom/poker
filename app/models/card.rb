# frozen_string_literal: true

class Card
  SPADE = :spade
  HEART = :heart
  CLUB = :club
  DIAMOND = :diamond

  SUITS = [
    SPADE, HEART, CLUB, DIAMOND
  ].freeze

  ACE =  14
  KING = 13
  QUEEN = 12
  JACK = 11
  TEN = 10
  NINE = 9
  EIGHT = 8
  SEVEN = 7
  SIX = 6
  FIVE = 5
  FOUR = 4
  THREE = 3
  TWO = 2

  RANKS = [
    ACE, KING, QUEEN, JACK, TEN, NINE, EIGHT, SEVEN, SIX, FIVE, FOUR, THREE, TWO
  ].freeze

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

    def rank_lookup
      @rank_lookup ||= Hash.new do |hash, key|
        name = Card.constants.find { |k| Card.const_get(k) == key }

        hash[key] = name.to_s.downcase
      end
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
    Card.rank_lookup[rank]
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
    "#{rank_name} of #{suit}s"
  end

  def asset_path
    "cards/#{to_s.gsub(' ', '_')}.svg"
  end
end
