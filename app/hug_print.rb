require 'nokogiri'
require 'open-uri'


class Confession
  def initialize(import = "")
    @poster_id = []
    @confession = []
    @full_page = import
  end

  def self.from_html(website)
    self.new(Nokogiri::HTML(open(website)))
  end

  def raw_confession
    @full_page.css('table#confessions').css('tr')
  end

  def print_from_table(array)
    array.each do |row|
      poster_id = poster_id(row)
      confession = confession(row)
      print "#{poster_id} : #{confession} \n\n"
    end 
  end

  def poster_id(row)
    row.css('td.conf-id').css('h4').css('a').text
  end

  def confession(row)
    row.css('td.conf-text').css('p').text.gsub!(/\n|\t|\r/, '')
  end

  def clean(array)
    array.map! do |item|
      item.text.gsub!(/\n|\t/, '')
    end
  end
end


test = Confession.from_html("http://web.archive.org/web/20061119120435/http://grouphug.us/page/12/n")
test.print_from_table(test.raw_confession)