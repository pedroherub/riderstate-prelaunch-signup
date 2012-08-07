class Event < ActiveRecord::Base
  attr_accessible :name, :publish, :starting, :riding_type, :photo, :group
  has_attached_file :photo,
           :styles => {
             :thumb=> "100x100#",
             :small  => "300x300>" },
           :storage => :s3,
           #url: ":s3_domain_url",
           :s3_credentials => "/usr/share/nginx/www/riderstate.es/current/config/s3.yml",
           #:s3_credentials => "/home/pedroherub/dev/riderstate-prelaunch-signup/config/s3.yml",
          :path => "/event/:style/:id/:filename"

  has_and_belongs_to_many :users

  validates :name, :presence => true

  def registered?(user)
    self.users.include?(user)
  end

  def owner?(user)
    self.owner == user.id rescue nil
  end

  def type_checked?(type)
    @event.riding_type == type rescue nil
  end

  def publish_checked?(publish)
    @event.publish == publish rescue nil
  end
end
