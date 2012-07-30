class Municipality < ActiveRecord::Base
  belongs_to :region
  attr_accessible :name
  has_many :districts
end
