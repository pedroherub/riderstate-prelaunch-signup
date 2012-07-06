class Track < ActiveRecord::Base
  attr_accessible :activity, :burnedcalories, :departing, :distance, :duration_hours, :duration_minutes, :feeling, :heartbeats_average, :heartbeats_max, :name, :notes, :type, :weather
  belongs_to :user
  validates_presence_of :name
  validates :burnedcalories, :numericality => true
  validates :duration_minutes, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 60 }, :length => { :in => 1..2 }
  validates :duration_hours, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }, :length => { :in => 1..2 }
  validates :heartbeats_average, :numericality => true
  validates :heartbeats_max, :numericality => true
end
