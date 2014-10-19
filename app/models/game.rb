class Game < ActiveRecord::Base
	has_many :videos
<<<<<<< ours
end
=======
  include AlgoliaSearch

  algoliasearch per_environment: true do
    attributesToIndex ['date', 'home_team', 'away_team', 'home_players', 'away_players']
  end
end

>>>>>>> theirs
