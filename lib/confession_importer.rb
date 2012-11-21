require_relative '../app/models/confession'

module ConfessionImporter
  def self.import(website)
    next_link = website
    while next_link
      taco = Confession.from_link(website) 
      next_link = taco.next_link
      puts taco.class
      puts taco.inspect
      # attribute_hash = Hash[field_names.zip(data)]
      Confession.create!(taco.list)
    end
  end
end