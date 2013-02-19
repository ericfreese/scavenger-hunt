class HuntUsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user, :through => :hunt

  def index
    @hunt = Hunt.find(params[:hunt_id])
    @users = @hunt.users

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def new
    @hunt = Hunt.find(params[:hunt_id])
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def create
    @hunt = Hunt.find(params[:hunt_id])
    @user = User.invite!(params[:user])

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
end
