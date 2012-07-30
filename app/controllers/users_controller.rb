# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:mark_as_betatester,:info_club]

  layout "home", :only => :index

  #def index
  #  authorize! :index, @user, :message => 'Not authorized as an administrator.'
  #  @users = User.accessible_by(current_ability, :index)
  #  @chart = create_chart
  #end

  def index
    #debugger
    #@users = User.accessible_by(current_ability, :index)
    @users = User.find(:all, :limit => 5, :order => 'distance DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def update
    #authorize! :update, @user, :message => 'Not authorized as an administrator.'
    #debugger
    #current_user.update_attribute :betatester, true
    #if current_user.save 
      #(render(:partial => 'thankyou2', :layout => false) && return)  if request.xhr?
    #end
  end

  def mark_as_betatester
    #debugger
    @user = User.find(params[:id])
    @user.update_attribute :betatester, true
    if @user.save
      (render(:partial => 'newbetatester', :layout => false) && return) if request.xhr?
    end
  end
  
  def info_club
    #debugger
    @user = User.find(params[:id])
    @user.update_attribute :betatester, true
    render(:partial => 'newbetatester', :layout => false) && return
  end
  
  
  def show
    @user = User.find(params[:id])
  end

  def invite
    authorize! :invite, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    @user.send_confirmation_instructions
    redirect_to :back, :notice => "Sent invitation to #{@user.email}."
  end

  def bulk_invite
    authorize! :bulk_invite, @user, :message => 'Not authorized as an administrator.'
    users = User.where(:confirmation_token => nil).order(:created_at).limit(params[:quantity])
    users.each do |user|
      user.send_confirmation_instructions
    end
    redirect_to :back, :notice => "Sent invitation to #{users.count} users."
  end
  
  private

  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
 
  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end
  
  def create_chart
    users_by_day = User.group("DATE(created_at)").count
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date')
    data_table.new_column('number')
    users_by_day.each do |day|
      data_table.add_row([ Date.parse(day[0]), day[1]])
    end
    @chart = GoogleVisualr::Interactive::AnnotatedTimeLine.new(data_table)
  end

end
