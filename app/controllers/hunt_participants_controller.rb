class HuntParticipantsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def edit
    @hunt = Hunt.find(params[:hunt_id])
    @hunt_participants = @hunt.hunt_participants

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clues }
    end
  end

  def update
    @hunt = Hunt.find(params[:hunt_id])

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
end
