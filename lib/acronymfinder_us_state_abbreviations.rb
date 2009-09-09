require 'open-uri'
require 'hpricot'

module Scrapers

  class AcronymfinderUsStateAbbreviations

    def initialize
      uri = URI.parse('http://www.acronymfinder.com/stateabbreviations.asp')
      open(uri, "User-Agent" => "Mozilla/4.8 [en] (Windows NT 6.0; U)") do |f|
        @response = f.read
      end
      @parsed = Hpricot(@response)
    end

    def state_abbreviations_table
      (@parsed/"//table")[2]
    end

    def rows
      states=[]
      rows = (state_abbreviations_table/'tr') 
      rows.shift
      rows.each do |row| 
        state=Hash.new
        state[:abbreviation] = ((row/'td')[0]/'p/b/font').inner_html.strip
        state[:state] = ((row/'td')[1]/'font').inner_html.strip
        state[:capital] = ((row/'td')[2]/'font/a').inner_html.strip
        state[:old_abbreviation] = ((row/'td')[3]/'font').inner_html.strip
        states << state
      end
      states
    end

    def state_abbreviation_for(state)
      match = rows.reject { |row| row[:state].downcase != state.downcase }
      match.first[:abbreviation] if match
    end

  end
end

