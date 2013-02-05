class Article < ActiveRecord::Base
  attr_accessible :error, :plos_id, :sequence, :xml
end
