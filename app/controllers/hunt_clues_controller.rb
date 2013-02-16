class HuntCluesController < ApplicationController
  # GET /clues
  # GET /clues.json
  def index
    @hunt = Hunt.find(params[:hunt_id])
    @clues = Clue.where(:hunt_id => params[:hunt_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clues }
    end
  end

  # GET /clues/1
  # GET /clues/1.json
  def show
    @hunt = Hunt.find(params[:hunt_id])
    @clue = Clue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clue }
    end
  end

  # GET /clues/new
  # GET /clues/new.json
  def new
    @hunt = Hunt.find(params[:hunt_id])
    @clue = @hunt.clues.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clue }
    end
  end

  # GET /clues/1/edit
  def edit
    @hunt = Hunt.find(params[:hunt_id])
    @clue = Clue.find(params[:id])
  end

  # POST /clues
  # POST /clues.json
  def create
    @hunt = Hunt.find(params[:hunt_id])
    @clue = @hunt.clues.build(params[:clue])

    respond_to do |format|
      if @clue.save
        format.html { redirect_to @hunt, notice: 'Clue was successfully created.' }
        format.json { render json: @clue, status: :created, location: @clue }
      else
        format.html { render action: "new" }
        format.json { render json: @clue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clues/1
  # PUT /clues/1.json
  def update
    @hunt = Hunt.find(params[:hunt_id])
    @clue = Clue.find(params[:id])

    respond_to do |format|
      if @clue.update_attributes(params[:clue])
        format.html { redirect_to hunt_clue_path(@hunt, @clue), notice: 'Clue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clues/1
  # DELETE /clues/1.json
  def destroy
    @clue = Clue.find(params[:id])
    @clue.destroy

    respond_to do |format|
      format.html { redirect_to clues_url }
      format.json { head :no_content }
    end
  end
end
