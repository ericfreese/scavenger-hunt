class HuntTeamsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user, :through => :hunt

  def index
    @hunt = Hunt.find(params[:hunt_id])
    @hunt_teams = @hunt.hunt_teams

    respond_to do |format|
      format.html
      format.json { render json: @teams }
    end
  end

  def new
    @hunt = Hunt.find(params[:hunt_id])
    @hunt_team = @hunt.hunt_teams.build

    respond_to do |format|
      format.html
      format.json { render json: @hunt_team }
    end
  end

  def edit
    @hunt = Hunt.find(params[:hunt_id])
    @hunt_team = @hunt.hunt_teams.find(params[:id])
  end

  def show
    @hunt = Hunt.find(params[:hunt_id])
    @hunt_team = @hunt.hunt_teams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clue }
    end
  end

  def create
    @hunt = Hunt.find(params[:hunt_id])
    @hunt_team = @hunt.hunt_teams.build(params[:hunt_team])

    respond_to do |format|
      if @hunt.save
        format.html { redirect_to @hunt, notice: 'Team was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @hunt = Hunt.find(params[:hunt_id])
    @hunt_team = @hunt.hunt_teams.find(params[:id])
    @hunt_participant = current_user.hunt_participants.where(:hunt_id => @hunt.id).first
    @hunt_participant.hunt_team = @hunt_team;

    respond_to do |format|
      if @hunt_participant.save
        format.html { redirect_to @hunt, notice: 'Successfully joined team.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to @hunt, alert: 'Failed to join team.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
