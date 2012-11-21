require 'nokogiri'
require 'open-uri'
require_relative '../../db/config'

class Confession < ActiveRecord::Base
  # serialize :preferences, Hash
  attr_accessible :post_id, :body

  # STARTING_URL = "http://web.archive.org/web/20060306154841/http://grouphug.us/"

  def initialize(import = "")
    @post_id = []
    @confession = []
    @full_page = import
  end

  def self.from_web(website)
    self.new(Nokogiri::HTML(open(website)))
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
