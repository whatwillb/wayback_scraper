require 'nokogiri'
require 'open-uri'
require_relative '../../db/config'

class Confession < ActiveRecord::Base
  attr_accessible :post_id, :body

  # def self.save_confessions_from_starting_url(url)
  #   page = Nokogiri::HTML(open(website))
  #   while page
  #     page.css('table#confessions').css('tr').each do |node|
  #       confession = self.from_nokogiri_node(node)
  #       confession.save!
  #     end
  #     next_page = page.css('td#nav-pages-next a').attribute('href').value
  #     page = next_page ? Nokogiri::HTML(open(next_page)) : nil
  #   end
  # end

  # def self.from_nokogiri_node(node)
  #   confession = self.new
  #   confession.post_id => node.css('td.conf-id').css('h4').css('a').text.gsub!(/\n/, ''),
  #   confession.body => node.css('td.conf-text').css('p').text.gsub!(/\n|\t|\r/, '')
  #   confession
  # end
end
