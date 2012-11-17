require 'nokogiri'
require 'open-uri'

class Confessions

  def initialize
  	@poster_ids = []
  	@confession_text = []
    @matched_confessions = []
  end

  def self.from_website(url = "http://web.archive.org/web/20071025014638/http://grouphug.us/")
    Nokogiri::HTML(open(url))
  end

   full_page = Nokogiri::HTML(open("http://web.archive.org/web/20071025014638/http://grouphug.us/"))

   @poster_id 


class Confession

  def initialize
    @poster_id = []
    @confession = []
  end

  def self.from_table
    take the array that was parsed from the tabel and split it to poster ids and confeesion text
    for each from the array
      run poster id to yield id
      run
  end

end

  def posters
    full_page.css('td.conf-id').css('h4').css('a')
   end

  def confessions
    full_page.css('td.conf-text').css('p')
  end

  def clean(in_array, out_array)
    array.each do |item|
      out_array << item.text.gsub!(/\n|\t/, '')
    end
  end
end