class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :status, :user_id
  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
  validates_presence_of :user_id, :friend_id

  def self.are_friends(user, friend)
    return false if user == friend
    if find_by_user_id_and_friend_id(user,friend) and find_by_user_id_and_friend_id(friend,user)
      f1 = find_by_user_id_and_friend_id(user,friend)
      f2 = find_by_user_id_and_friend_id(friend,user)
      return false unless f1.status == "accepted" and f2.status == "accepted"
    else 
      return false
    end
    true
  end

  def self.are_friends_pending(user, friend)
    return false if user == friend
    if find_by_user_id_and_friend_id(user,friend) and find_by_user_id_and_friend_id(friend,user)
      f1 = find_by_user_id_and_friend_id(user,friend)
      f2 = find_by_user_id_and_friend_id(friend,user)
      return false unless f1.status == "pending" and f2.status == "requested"
    else 
      return false
    end
    true
  end

  def self.are_friends_requested(user, friend)
    return false if user == friend
    if find_by_user_id_and_friend_id(user,friend) and find_by_user_id_and_friend_id(friend,user)
      f1 = find_by_user_id_and_friend_id(user,friend)
      f2 = find_by_user_id_and_friend_id(friend,user)
      return false unless f1.status == "requested" and f2.status == "pending"
    else 
      return false
    end
    true
  end

  def self.request(user, friend)
    return false if are_friends(user, friend)
    return false if user == friend
    f1 = new(:user_id => user.id, :friend_id => friend.id, :status => "pending")
    f2 = new(:user_id => friend.id, :friend_id => user.id, :status => "requested")
    transaction do
      f1.save
      f2.save
    end
    return true
  end

  def self.accept(user, friend)
    f1 = find_by_user_id_and_friend_id(user, friend)
    f2 = find_by_user_id_and_friend_id(friend, user)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.update_attributes(:status => "accepted")
        f2.update_attributes(:status => "accepted")
      end
    end
    return true
  end
    
  def self.reject(user, friend)
    f1 = find_by_user_id_and_friend_id(user, friend)
    f2 = find_by_user_id_and_friend_id(friend, user)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.destroy
        f2.destroy
        return true
      end
    end
  end

end
