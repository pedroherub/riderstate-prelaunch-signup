# -*- encoding : utf-8 -*-
class Activity < ActiveRecord::Base
  attr_accessible :riding_type, :burnedcalories, :departing, :distance, :duration_hours, :duration_minutes, :feeling, :heartbeats_average, :heartbeats_max, :name, :notes, :weather
  belongs_to :user
  has_one :track
  #validates_presence_of :name
  validates :name, :presence => true
  validates :distance, :presence => true
  validates :burnedcalories, :numericality => { :allow_nil => true }
  #validates :duration, :format => { :with => /^\d\d:\d\d$/,:message => "Wrong format" }
  validates :duration_minutes, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 60 }, :length => { :in => 1..2 }
  validates :duration_hours, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }, :length => { :in => 1..2 }
  validates :heartbeats_average, :numericality => { :allow_nil => true }
  validates :heartbeats_max, :numericality => { :allow_nil => true }
end
