require File.dirname(__FILE__) + "/../lib/wikipedia_top_us_cities"
include Scrapers
require 'mocha'

describe WikipediaTopUSCities do

  before(:each) do
    @page = WikipediaTopUSCities.new
  end

  it 'returns the city table' do
    @page.city_table.name.should == 'table'
  end

  it 'returns the first row' do
    @page.rows[0][:city].should == 'New York'
  end

end
