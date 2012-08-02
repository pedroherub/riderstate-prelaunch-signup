class ClubsController < ApplicationController
  autocomplete :district, :name

  layout 'club', :except => [:new]

  # GET /clubs
  # GET /clubs.json
  def index
    @clubs = Club.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clubs }
    end
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show

    #params[:id] = @current_user.club_id
    @club = Club.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @club }
    end
  end

  def view
    params[:id] = @current_user.club_id
    @club = Club.find(params[:id])
    render :show
  end
  
  # GET /clubs/new
  # GET /clubs/new.json
  def new
    @club = Club.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @club }
    end
  end

  # GET /clubs/1/edit
  def edit
    #debugger
    @club = Club.find(params[:id])

  end

  # POST /clubs
  # POST /clubs.json
  def create
    #debugger
    @club = Club.create(params[:club])
    @current_user.club_id = @club.id

    @current_user.save

    params.each do |key, value|
      if (key.to_s[/adduser.*/])
        #if param[key].blank?
        #  @object.errors.add_to_base("All new user fields are required.")
        #end
        @user = User.new
        @user.update_attribute(:email,params[key])
        @user.update_attribute(:club_id,params[:id])
        @user.save
        #@user.send_confirmation_instructions
      end
    end

    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: 'Club was successfully created.' }
        format.json { render json: @club, status: :created, location: @club }
      else
        format.html { render action: "new" }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clubs/1
  # PUT /clubs/1.json
  def update
    @club = Club.find(params[:id])

    params.each do |key, value|
      if (key.to_s[/adduser.*/])
        #if param[key].blank?
        #  @object.errors.add_to_base("All new user fields are required.")
        #end
        #debugger
        @user = User.new
        #clean_up_passwords @user
        @user.update_attribute(:email,params[key])
        @user.update_attribute(:club_id,params[:id])
        @user.save
        #@user.send_confirmation_instructions
      end
    end

    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
    @club = Club.find(params[:id])
    @club.destroy

    respond_to do |format|
      format.html { redirect_to clubs_url }
      format.json { head :no_content }
    end
  end
end
