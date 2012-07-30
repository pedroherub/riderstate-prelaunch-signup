class District < ActiveRecord::Base
  belongs_to :municipality
  attr_accessible :name
  has_many :clubs
end
