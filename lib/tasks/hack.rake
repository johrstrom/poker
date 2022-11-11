namespace :hack do

  task :run => :environment do
    Card.shuffled_deck.select do |card|
      card.diamond?
    end.each do |card|
      puts card
    end
    # Card.deck.select { |c| puts c.class }
  end
end