# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"
require 'open-uri'
require 'nokogiri'

team_abbrevs = {
	"Atlanta Hawks"=> "ATL",
	"Boston Celtics" => "BOS",
	"Brooklyn Nets" => "BRK",
	"New Jersey Nets" => "NJN",
	"New York Nets" => "NYN",
	"Charlotte Hornets" => "CHH",
	"Charlotte Bobcats" => "CHA",
	"Chicago Bulls" => "CHI",
	"Cleveland Cavaliers" => "CLE",
	"Dallas Mavericks" => "DAL",
	"Denver Nuggets" => "DEN",
	"Detroit Pistons" => "DET",
	"Golden State Warriors" => "GSW",
	"San Francisco Warriors" => "SFW",
	"Houston Rockets" => "HOU", 
	"San Diego Rockets" => "SDR",
	"Indiana Pacers" => "IND",
	"Los Angeles Clippers" => "LAC",
	"San Diego Clippers" => "SDC",
	"Buffalo Braves" => "BUF",
	"Los Angeles Lakers" => "LAL",
	"Memphis Grizzlies" => "MEM",
	"Vancouver Grizzlies" => "VAN",
	"Miami Heat" => "MIA",
	"Milwaukee Bucks" => "MIL",
	"Minnesota Timberwolves" => "MIN",
	"New Orleans Pelicans" => "NOH",
	"New Orleans/Oklahoma City Hornets"	=> "NOK",
	"New Orleans Hornets" => "NOH",
	"New York Knicks" => "NYK",
	"Oklahoma City Thunder" => "OKC",
	"Seattle SuperSonics" => "SEA",
	"Orlando Magic" => "ORL",
	"Philadelphia 76ers" => "PHI",
	"Phoenix Suns" => "PHO",
	"Portland Trail Blazers" => "POR",
	"Sacramento Kings" => "SAC",
	"Kansas City Kings" => "KCK",
	"Kansas City-Omaha Kings" => "KCO",
	"Cincinnati Royals" => "CIN",
	"San Antonio Spurs" => "SAS",
	"Toronto Raptors" => "TOR",
	"Utah Jazz" => "UTA",
	"New Orleans Jazz" => "NOJ",
	"Washington Wizards" => "WAS",
	"Washington Bullets" => "WSB",
	"Capital Bullets" => "CAP",
	"Baltimore Bullets" => "BAL"
}

def create_box_url(home_team_abv, away_team_abv, date)
	bbr_date = date.gsub("-","")
	home_box = "http://widgets.sports-reference.com/wg.fcgi?&site=bbr&url=%2Fboxscores%2F" + bbr_date + "0" + home_team_abv + ".html&div=div_" + home_team_abv + "_basic"
	away_box = "http://widgets.sports-reference.com/wg.fcgi?&site=bbr&url=%2Fboxscores%2F" + bbr_date + "0" + home_team_abv + ".html&div=div_" + away_team_abv + "_basic"
	return home_box, away_box
end

def parse_player_data(url)
	player_string = ""
	data = Nokogiri::HTML(open(url))
	data.css("td").each do |line|
		if line.content.length > 5 and line.content != "Team Totals"
			player_string += (line.content + " ")
		end
	end
	player_string
end

@i = 0
def seed_db(csv_file, team_abbrevs, value)
	CSV.foreach(csv_file, {headers: true, header_converters: :symbol}) do |row|
		game_type = row[:game_type]
		date = row[:date]
		home_team = row[:home_team]
		home_team_abv = team_abbrevs[home_team]
		home_score = row[:score_for]
		away_team = row[:away_team]
		away_team_abv = team_abbrevs[away_team]
		away_score = row[:score_against]
		team_urls = create_box_url(home_team_abv, away_team_abv, date)

		home_url = team_urls[0]
		home_players = parse_player_data(home_url)
		away_url = team_urls[1]
		away_players = parse_player_data(away_url)

		@i+=1
		if @i == value
			break
		end

		if @i % 500 == 0
			sleep(300)
			puts 'Sleep complete'
		end

		unless Game.find_by(date: date, home_team: home_team)
			puts 'Game created!' unless Rails.env["production"]
			game = Game.create(game_type: game_type, date: date, home_team: home_team, home_team_abv: home_team_abv, home_score: home_score, home_url: home_url, home_players: home_players, away_team: away_team, away_team_abv: away_team_abv, away_score: away_score, away_url: away_url, away_players: away_players)
      Resque.enqueue(YoutubeGetter, game.id)
		end
	end
end

if Rails.env["production"]
	seed_db(Rails.root.to_s + "/public/nba-data.csv", team_abbrevs, 50000)
else
	seed_db(Rails.root.to_s + "/public/nba-data.csv", team_abbrevs, 10)
end


