require File.dirname(__FILE__) + "/../lib/acronymfinder_us_state_abbreviations"
require 'spec'
include Scrapers

describe AcronymfinderUsStateAbbreviations do

  before(:each) do
    @page = AcronymfinderUsStateAbbreviations.new
  end

  it 'returns the us states abbreviations table' do
    (@page.state_abbreviations_table/'tr').size.should == 60
  end

  it 'returns the first row' do
    @page.rows[0][:abbreviation].should == 'AK'
  end

  it 'returns the state abbreviation' do
    @page.state_abbreviation_for('District of Columbia').should == 'DC'
  end

end
