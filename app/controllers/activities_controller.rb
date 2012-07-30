# -*- encoding : utf-8 -*-
class ActivitiesController < ApplicationController

  layout "home", :only => [:index,:new,:show,:edit]

  def index
    @user = User.find(params[:user_id])
    @activities = @user.activities.all
    #debugger
    #@activities = @current_user.activities.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @activity = @user.activities.find(params[:id])
    #@activity = @current_user.activities.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  def new
    #@user = User.find(params[:user_id])
    #@activity = @user.activities.build
    @activity = @current_user.activities.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    #  format.js do
    #    render :new do |page|
    #      page.replace_html "home-content", :partial => "form"
    #    end
    #  end
    end
  end

  def edit
    #debugger
    #@user = User.find(params[:user_id])
    #@activity = @user.activities.find(params[:id])
    @activity = @current_user.activities.find(params[:id])
  end

  def create
    debugger
    #@activity = Activity.new(params[:activity])
    @activity = @current_user.activities.create(params[:activity])
    if @activity.save
      @current_user.distance += @activity.distance
      @current_user.save
    end
    #if @current_user.save
    #  redirect_to user_activities_path(@current_user)
    #else
    #  render :action => "new"
    #end
    respond_to do |format|
      if @activity.save
        #debugger
        #redirect_to user_activity_path(@current_user,@activity)
        format.html { redirect_to user_activity_path(@current_user,@activity), notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        #redirect_to new_user_activities_path(@current_user,@activity)
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #@activity = Activity.find(params[:id])
    @activity = @current_user.activities.find(params[:id])
    @activity.destroy
    redirect_to user_activities_path(@current_user)

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end
end
