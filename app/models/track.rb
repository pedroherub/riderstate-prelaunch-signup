class Track < ActiveRecord::Base
  attr_accessible :activity, :burnedcalories, :departing, :distance, :duration, :feeling, :heartbeats, :name, :notes, :type, :weather
  belongs_to :user
end
