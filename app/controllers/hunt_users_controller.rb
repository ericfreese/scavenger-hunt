class HuntUsersController < ApplicationController
  before_filter :authenticate_user!

  # GET /clues
  # GET /clues.json
  def index
    @hunt = Hunt.find(params[:hunt_id])
    @users = @hunt.users

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clues }
    end
  end

  # # GET /clues/1
  # # GET /clues/1.json
  # def show
  #   @hunt = Hunt.find(params[:hunt_id])
  #   @clue = Clue.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @clue }
  #   end
  # end

  # GET /clues/new
  # GET /clues/new.json
  def new
    @hunt = Hunt.find(params[:hunt_id])
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # # GET /clues/1/edit
  # def edit
  #   @hunt = Hunt.find(params[:hunt_id])
  #   @clue = Clue.find(params[:id])
  # end

  # POST /clues
  # POST /clues.json
  def create
    @hunt = Hunt.find(params[:hunt_id])
    @user = User.invite!(params[:user])

    # @invite = User.invite!(@user.attributes)
    # @user = @hunt.users.build(params[:user])
    # @user.hunts = @hunt
    # logger.debug @user.attributes
    # @user = User.invite!(@hunt.users.build(params[:user]).attributes, current_user)

    respond_to do |format|
      if @user.errors.empty?
        @hunt.users << @user
        format.html { redirect_to @hunt, notice: 'User was successfully invited.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PUT /clues/1
  # # PUT /clues/1.json
  # def update
  #   @hunt = Hunt.find(params[:hunt_id])
  #   @clue = Clue.find(params[:id])

  #   respond_to do |format|
  #     if @clue.update_attributes(params[:clue])
  #       format.html { redirect_to hunt_clue_path(@hunt, @clue), notice: 'Clue was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @clue.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /clues/1
  # # DELETE /clues/1.json
  # def destroy
  #   @clue = Clue.find(params[:id])
  #   @clue.destroy

  #   respond_to do |format|
  #     format.html { redirect_to clues_url }
  #     format.json { head :no_content }
  #   end
  # end
end