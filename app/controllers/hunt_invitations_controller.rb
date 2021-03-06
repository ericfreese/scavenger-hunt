class HuntInvitationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user, :through => :hunt

  def index
    @hunt = Hunt.find(params[:hunt_id])
    @invitations = @hunt.invitations

    respond_to do |format|
      format.html
      format.json { render json: @invitations }
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

    # Select user if it already exists, otherwise send an invitation and create the user
    @user = User.where(:email => params[:user][:email]).first || User.invite!(:email => params[:user][:email])

    respond_to do |format|
      if @user.errors.empty?
        @hunt.invitations.create! :user => @user, :status => :invited #, :invited_by => current_user
        format.html { redirect_to @hunt, notice: 'User was successfully invited.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @hunt = Hunt.find(params[:hunt_id])
    @invitation = @hunt.invitations.find(params[:id])
    @hunt.hunt_participants.build(:user => @invitation.user, :status => :player)
    @invitation.status = :accepted

    respond_to do |format|
      if @hunt.save && @invitation.save
        format.html { redirect_to @hunt, notice: 'Invitation was successfully accepted.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to @hunt, alert: 'Failed to accept invitation.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def decline
    @hunt = Hunt.find(params[:hunt_id])
    @invitation = @hunt.invitations.find(params[:id])
    @invitation.status = :declined

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @hunt, notice: 'Invitation was successfully accepted.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to @hunt, alert: 'Failed to accept invitation.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @hunt = Hunt.find(params[:hunt_id])
    @invitation = @hunt.invitations.find(params[:id])
    @invitation.status = :canceled

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @hunt, notice: 'Invitation was successfully canceled.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to @hunt, alert: 'Failed to cancel invitation.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
