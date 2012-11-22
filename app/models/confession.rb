require_relative '../../db/config'

class Confession < ActiveRecord::Base
  attr_accessible :post_id, :body
end