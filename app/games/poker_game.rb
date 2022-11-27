class PokderGame

  attr_reader :players, :deck, :flop, :turn, :river

  def initialize(players: [])
    @players = players
  end

  def start
    new_deck!
    deal!
  end

  def new_deck!
    @deck = Card.shuffled_deck.map do |card|
      ActiveCard.new(card)
    end
  end

  def flop!
    @flop = []
    burn!
    (1...3).each do |card|
      @flop << card
    end
  end

  def turn!
    burn!
    @turn = @deck.pop
  end

  def river!
    burn!
    @river = @deck.pop
  end

  def burn!
    @deck.pop
  end

  def deal!(times = 0)
    (0...times).each do |_|
      # FIXME: deals wrong
      players.each do |player|
        player.add_card(deck.pop)
      end
    end
  end
end