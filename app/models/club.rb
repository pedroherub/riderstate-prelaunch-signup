class Club < ActiveRecord::Base
  attr_accessible :foundation, :name, :district_id, :logo
  has_attached_file :logo,
           :styles => {
               :thumb=> "100x100#",
               :small  => "300x300>" },
           :storage => :s3,
           #url: ":s3_domain_url",
           :s3_credentials => "/home/pedroherub/dev/riderstate-prelaunch-signup/config/s3.yml",
           :path => "/club/:style/:id/:filename"

  belongs_to :district
end
