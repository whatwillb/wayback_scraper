require_relative '../app/models/confession'

module ConfessionsImporter
  # def initialize(website)
  #   @next_link = website
  # end

  def self.import(website)
    # page = website ? Nokogiri::HTML(open(website)) : nil
    # while page
    #   page.css('table#confessions').css('tr').each do |node|
    #     confession = Confession.from_nokogiri_node(node)
    #     confession.save!
    #   end
    #   next_page = page.css('td#nav-pages-next a').attribute('href').value
    #   page = next_page ? Nokogiri::HTML(open(next_page)) : nil
    # end

    next_link = website
    while next_link
      taco = GrouphugPage.new(next_link) 
      next_link = taco.next_link
      puts next_link
      puts taco.class
      taco.list.each do |h|
        Confession.create!(h)
      end
    end
  end
end