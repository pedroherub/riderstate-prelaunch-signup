class Region < ActiveRecord::Base
  belongs_to :country
  attr_accessible :name
  has_many :municipalities
end
