class HuntsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /hunts
  # GET /hunts.json
  def index
    @hunts = current_user.hunts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hunts }
    end
  end

  # GET /hunts/1
  # GET /hunts/1.json
  def show
    @hunt = Hunt.find(params[:id])

    # Is the current user invited to this hunt?
    @invitation = Invitation.where(
      :user_id => current_user.id,
      :hunt_id => @hunt.id,
      :status_cd => Invitation.invited
    ).first

    @submissions = Submission.where(:clue_id => @hunt.clues.collect(&:id)).order('created_at DESC')

    respond_to do |format|
      format.html
      format.json { render json: @hunt }
    end
  end

  # GET /hunts/new
  # GET /hunts/new.json
  def new
    @hunt = Hunt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hunt }
    end
  end

  # GET /hunts/1/edit
  def edit
    @hunt = Hunt.find(params[:id])
  end

  # POST /hunts
  # POST /hunts.json
  def create
    @hunt = Hunt.new(params[:hunt])
    @hunt.hunt_participants.build(:user => current_user, :status => :judge)

    respond_to do |format|
      if @hunt.save
        format.html { redirect_to @hunt, notice: 'Hunt was successfully created.' }
        format.json { render json: @hunt, status: :created, location: @hunt }
      else
        format.html { render action: "new" }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hunts/1
  # PUT /hunts/1.json
  def update
    @hunt = Hunt.find(params[:id])

    respond_to do |format|
      if @hunt.update_attributes(params[:hunt])
        format.html { redirect_to @hunt, notice: 'Hunt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hunts/1
  # DELETE /hunts/1.json
  def destroy
    @hunt = Hunt.find(params[:id])
    @hunt.destroy

    respond_to do |format|
      format.html { redirect_to hunts_url }
      format.json { head :no_content }
    end
  end

  def send_invitations
    @hunt = Hunt.find(params[:id])
  end
end
