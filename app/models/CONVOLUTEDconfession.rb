require 'nokogiri'
require 'open-uri'
require_relative '../../db/config'

class Confession < ActiveRecord::Base
  # serialize :preferences, Hash
  attr_accessible :post_id, :body

  # STARTING_URL = "http://web.archive.org/web/20060306154841/http://grouphug.us/"

  def initialize(import = nil)
    @full_page = import
    extract_post_id_and_body if @full_page
  end

  def self.save_confessions_from_starting_url(url)
    page = Nokogiri::HTML(open(website))
    while page
      page.css('table#confessions').css('tr').each do |node|
        confession = self.from_nokogiri_node(node)
        confession.save!
      end
      next_page = page.css('td#nav-pages-next a').attribute('href').value
      page = next_page ? Nokogiri::HTML(open(next_page)) : nil
    end
  end

  def self.from_nokogiri_node(node)
    confession = self.new
    confession.post_id => node.css('td.conf-id').css('h4').css('a').text.gsub!(/\n/, ''),
    confession.body => node.css('td.conf-text').css('p').text.gsub!(/\n|\t|\r/, '')
    confession
  end

  def raw_confession
    @full_page.css('table#confessions').css('tr')
  end

  def list
    out = []
    raw_confession.each do |row|
      h = {
        :post_id => row.css('td.conf-id').css('h4').css('a').text.gsub!(/\n/, ''),
        :body => row.css('td.conf-text').css('p').text.gsub!(/\n|\t|\r/, '')
      }
      out << h
    end
    out
  end

  def self.print_from_table
    list.each do |row|
      print "#{row[:post_id]} : #{row[:body]} \n\n"
    end 
  end

  def clean(array)
    array.map! do |item|
      item.text.gsub!(/\n|\t/, '')
    end
  end

  def next_link
    @full_page.css('td#nav-pages-next a').attribute('href').value
  end

  def save
    # @confession.save
    # list.each do |row|
    # db.execute <<-SQL
    # INSERT INTO confessions
    # ('post_id', 'body')
    # VALUES (row[:post_id], row[:body])
    # SQL
    # end
    list.each do |row|
      puts row[:post_id], row[:body]
    end
  end

  def post_id
    
  end
end
