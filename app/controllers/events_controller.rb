class EventsController < ApplicationController

  layout 'home'

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def joined_events
    @events = @current_user.events
    render 'index'
    #respond_to do |format|
    #  format.html  index.html.erb
    #  format.json { render json: @events }
    #end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @users = @event.users
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    #debugger
    @options = Array.new
    @options << ['Toda la web','Toda la web']
    if params[:from] == 'user'
      @options << ['Mi grupo','Mi grupo']
      @options << ['Mis contactos','Mis contactos']
      @options << ['Algunos contactos','Algunos contactos']
      @group = false
    else #params[:from] == 'club'
      @options << ['Otros grupos','Otros grupos']
      @group = true
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])

    @options = Array.new
    @options << ['Toda la web','Toda la web']
    if @event.group == false
      @options << ['Mi grupo','Mi grupo']
      @options << ['Mis contactos','Mis contactos']
      @options << ['Algunos contactos','Algunos contactos']
      @group = false
    else #@event.group == true
      @options << ['Otros grupos','Otros grupos']
      @group = true
    end
  end

  # POST /events
  # POST /events.json
  def create
    #debugger
    @event = Event.new(params[:event])
    @event.owner = current_user.id
    #@event.update_attribute(:owner,@current_user.id)
    @current_user.events << @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  # GET /event/1/register?userid=1
  # Register a user to an event
  def register
  
    @event = Event.find(params[:id])
    #@user = User.find(params[:userid])
  
    # Register a user if it is not registered already
    unless @event.registered?(@current_user)
      # Add event to a user's events list
      @current_user.events << @event
      flash[:notice] = 'User registered at the event successfully'
    else
      flash[:error] = 'User already registered'
    end
    # Redirect to the action "show"
    redirect_to :action => :show, :id => @event
    # Redirect to the action "users"
    # Redirect to /event/1/users for event id 1
    #redirect_to :action => :users, :id => @event
  end
  
  # Unregister a user to an event
  def unregister
    
    @event = Event.find(params[:id])
    #@user = User.find(params[:userid])
    @event.users.delete(@current_user)

    # Redirect to the action "show"
    redirect_to :action => :show, :id => @event
    # Redirect to the action "users"
    # Redirect to /event/1/users for event id 1
    #redirect_to :action => :users, :id => @event
  end

  # Display all users of an event
  # GET /event/1/users
  def users
    @users = Event.find(params[:id]).users
  end

end
