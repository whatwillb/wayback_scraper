require_relative '../app/models/hug_scraper'

class Confession < ActiveRecord::Base
  def self.import(url)
    HugScrape(url).page_content.each do |confession|
      Confession.create!(confession)
    end    
  end
end