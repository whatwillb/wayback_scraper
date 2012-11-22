require 'nokogiri'
require 'open-uri'

class GrouphugPage
  def initialize(url)
    @full_page = Nokogiri::HTML(open(website))
  end

  def next_page_url
    @full_page.css('td#nav-pages-next a').attribute('href').value
  end

  def confessions
    out = []
    confession_nodes.each do |row|
      out << {
        :post_id => row.css('td.conf-id').css('h4').css('a').text.gsub!(/\n/, ''),
        :body => row.css('td.conf-text').css('p').text.gsub!(/\n|\t|\r/, '')
      }
    end
    out
  end

  private 
  def confession_nodes
    @full_page.css('table#confessions').css('tr')
  end
end