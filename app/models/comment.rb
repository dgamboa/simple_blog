class Comment < ActiveRecord::Base
  include TextValidations

  belongs_to :article

  attr_accessible :body, :article_id

  validates :body, :length => { :maximum => 250 }
  validates :article_id, :presence => true
end
