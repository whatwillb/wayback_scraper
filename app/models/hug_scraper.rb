require 'nokogiri'
require 'open-uri'
require_relative 'confession'

class HugScraper

  # Look to use mechanize http://mechanize.rubyforge.org/ to automate the process of scraping

  def self.scrape(url, pages = 1)
    confessions = []
    pages.times do
      nokodata = Nokogiri::HTML(url_test(url))
      confessions += parse_page(nokodata)
      p url
      url = next_url(nokodata)
    end
    confessions
  end

  def self.url_test(url)
    w = open(url)
     rescue OpenURI::HTTPError => the_error
       p the_error
       sleep 5
       Confession.import(url, 10)
     else
    w
  end

# I really like the fact that this is all being done as class methods. Its what is allowing all of the methods to be called without needing an instance of the class to be created, this allows us to remove/reduce the number of instance variables.
  def self.parse_page(page)
    out = []
    confession_nodes(page).each do |row|
      out << {
        :post_id => clean(row.css('td.conf-id').css('h4').css('a').text),
        :body => clean(row.css('td.conf-text').css('p').text)
      }
    end
    out
  end

  def self.next_url(nokodata)
    nokodata.css('td#nav-pages-next a').attribute('href').value
  end

  def self.confession_nodes(page)
    page.css('table#confessions').css('tr')
  end

  def self.clean(string)
    string.gsub!(/\n|\t|\r/, '')
  end
end