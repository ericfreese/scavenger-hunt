class SubmissionVotesController < ApplicationController
  def create
    @submission = Submission.find(params[:submission_id])
    @vote = @submission.votes.build(params[:vote].merge(:user_id => current_user.id))

    respond_to do |format|
      if @vote.save
        format.html { redirect_to vote_clue_submissions_path(@submission.clue), notice: 'Vote was successfully saved.' }
        format.json { render json: @clue, status: :created, location: @clue }
      else
        format.html { redirect_to vote_clue_submissions_path(@submission.clue), alert: 'There was a problem saving your vote.' }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @submission = Submission.find(params[:submission_id])
    @vote = @submission.votes.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to vote_clue_submissions_path(@submission.clue), notice: 'Vote was successfully saved.' }
        format.json { render json: @clue, status: :created, location: @clue }
      else
        format.html { redirect_to vote_clue_submissions_path(@submission.clue), alert: 'There was a problem saving your vote.' }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end
end