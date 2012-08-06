class Club < ActiveRecord::Base
  attr_accessible :foundation, :name, :district_id, :logo
  has_attached_file :logo,
           :styles => {
               :thumb=> "100x100#",
               :small  => "300x300>" },
           :storage => :s3,
           :bucket => 'bucket-riderstate',
                  :s3_credentials => {
             :access_key_id => ENV['RS_AWS_ACCESS_KEY'],
                      :secret_access_key => ENV['RS_AWS_SECRET_KEY']
         },
           #:s3_credentials => "/usr/share/nginx/www/riderstate.es/current/config/s3.yml",
           :path => "/club/:style/:id/:filename"

  belongs_to :district
end
