class Simulation

  def initialize
    players = []
    @game = PokerGame.new(players: players)
  end
end