class Article < ActiveRecord::Base
  attr_accessible :article_xml, :error, :plos_id, :ref_xml
end
