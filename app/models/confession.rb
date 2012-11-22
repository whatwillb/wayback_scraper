require_relative '../../db/config'
require_relative 'hug_scraper'

class Confession < ActiveRecord::Base
 attr_accessible :post_id, :body
 validates :post_id, :uniqueness => true

  def self.import(url, pages = 1)
    # create(:post_id => 5, :body => "I killed somebody")
    # create([
    #   {:post_id => 3, :body => "I saw him kill the guy"},
    #   {:post_id => 4, :body => "he killed me"}
    # ])
    create(HugScraper.scrape(url, pages))
  end
end