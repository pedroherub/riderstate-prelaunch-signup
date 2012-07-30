class Track < ActiveRecord::Base
  belongs_to :activity
  # attr_accessible :title, :body
  has_attached_file :geolocation
end
