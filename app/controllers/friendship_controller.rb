class FriendshipController < ApplicationController

  def req
    #debugger
    @friend = User.find_by_id(params[:id])
    unless @friend.nil?
      if Friendship.request(@current_user, @friend)
        flash[:notice] = "Friendship with #{@friend.name} requested"
      else
        flash[:notice] = "Friendship with #{@friend.name} cannot be requested"
      end
    end
    redirect_to user_path(@current_user)
    #redirect_to user_path(@current_user)
  end

  def accept
    @friend = User.find_by_id(params[:id])
    unless @friend.nil?
      if Friendship.accept(@current_user, @friend)
        flash[:notice] = "Friendship with #{@friend.name} accepted"
      else
        flash[:notice] = "Friendship with #{@friend.name} cannot be accepted"
      end
    end
    redirect_to :controller => 'users', :action => 'show', :id => @current_user.id
    #redirect_to @current_user
    #redirect_to user_path(@current_user)
  end

  def reject
    @friend = User.find_by_id(params[:id])
    unless @friend.nil?
      if Friendship.reject(@current_user, @friend)
        flash[:notice] = "Friendship with #{@friend.name} rejected"
      else
        flash[:notice] = "Friendship with #{@friend.name} cannot be rejected"
      end
    end
    redirect_to :controller => 'users', :action => 'show', :id => @current_user.id
    #redirect_to user_path(@current_user)
  end

end
