class Club < ActiveRecord::Base
  attr_accessible :foundation, :name, :district_id, :logo
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :district
end
