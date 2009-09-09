require 'open-uri'
require 'hpricot'

module Scrapers

  class WikipediaTopUSCities

    def initialize
      uri = URI.parse('http://en.wikipedia.org/wiki/List_of_United_States_cities_by_population')
      open(uri, "User-Agent" => "Mozilla/4.8 [en] (Windows NT 6.0; U)") do |f|
        @response = f.read
      end
      @parsed = Hpricot(@response)
    end

    def city_table
      (@parsed/"//#bodyContent/table[@class='wikitable sortable']").first
    end

    def rows
      cities=[]
      rows = (city_table/'tr') 
      rows.shift
      rows.each do |row| 
        city=Hash.new
        city[:rank] = (row/'td')[0].inner_html
        city[:city] = ((row/'td')[1]/'a').inner_html
        city[:state] = ((row/'td')[2]/'a').inner_html
        city[:population] = (row/'td')[3].inner_html.gsub(((row/'td')[3]/'span').to_html, "")
        cities << city
      end
      cities
    end

  end
end
