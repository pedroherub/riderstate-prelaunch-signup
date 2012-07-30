class Event < ActiveRecord::Base
  attr_accessible :name, :publish, :starting, :riding_type, :photo, :group
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
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
