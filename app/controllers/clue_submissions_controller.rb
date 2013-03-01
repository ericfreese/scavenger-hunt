class ClueSubmissionsController < ApplicationController
  def show
    @hunt = Hunt.find(params[:hunt_id])
    @clue = Clue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clue }
    end
  end

  def new
    @clue = Clue.find(params[:clue_id])
    @submission = @clue.submissions.build :user_id => current_user.id

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def create
    @clue = Clue.find(params[:clue_id])
    @submission = @clue.submissions.build params[:submission].merge(:user_id => current_user.id)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @clue.hunt, notice: 'Submission was successfully created.' }
        format.json { render json: @clue, status: :created, location: @clue }
      else
        format.html { render action: "new" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def vote
    @clue = Clue.find(params[:clue_id])
    @submissions = Submission.where(:clue_id => @clue.id).group_by{ |s| s.team }

    respond_to do |format|
      format.html
      format.json { render json: @submissions }
    end
  end
end
