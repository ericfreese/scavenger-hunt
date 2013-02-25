class HuntTeamsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user, :through => :hunt

  def index
    @hunt = Hunt.find(params[:hunt_id])
    @teams = @hunt.teams

    respond_to do |format|
      format.html
      format.json { render json: @teams }
    end
  end

  def new
    @hunt = Hunt.find(params[:hunt_id])
    @team = @hunt.teams.build

    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def edit
    @hunt = Hunt.find(params[:hunt_id])
    @team = @hunt.teams.find(params[:id])
  end

  def show
    @hunt = Hunt.find(params[:hunt_id])
    @team = @hunt.teams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clue }
    end
  end

  def create
    @hunt = Hunt.find(params[:hunt_id])
    @team = @hunt.teams.build(params[:team])

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

  def update
    @hunt = Hunt.find(params[:hunt_id])
    @team = @hunt.teams.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to hunt_team_path(@hunt, @team), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @hunt = Hunt.find(params[:hunt_id])
    @team = @hunt.teams.find(params[:id])
    @hunt_participant = current_user.hunt_participants.where(:hunt_id => @hunt.id).first
    @hunt_participant.team = @team;

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
