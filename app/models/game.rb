# == Schema Information
#
# Table name: games
#
#  id            :integer          not null, primary key
#  game_type     :text
#  date          :date
#  home_team     :text
#  home_team_abv :text
#  home_score    :integer
#  home_url      :text
#  home_players  :text
#  away_team     :text
#  away_team_abv :text
#  away_score    :integer
#  away_url      :text
#  away_players  :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_games_on_away_players  (away_players)
#  index_games_on_away_team     (away_team)
#  index_games_on_date          (date)
#  index_games_on_home_players  (home_players)
#  index_games_on_home_team     (home_team)
#

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
