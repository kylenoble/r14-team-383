require 'open-uri'
require 'nokogiri'

module GamesHelper
	def create_box(url, team)
		new_data = ''
		data = Nokogiri::HTML(open(url))
		data.css("table").each do |line|
			table = data.at_css "table"
			table.set_attribute('align', 'center')
			table.set_attribute('class', 'sortable  stats_table ' + team)
			new_data = line
		end
		new_data.to_html
	end
end
