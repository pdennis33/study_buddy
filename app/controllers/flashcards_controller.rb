class FlashcardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic
  before_action :set_flashcard, only: %i[ edit update destroy move_up move_down ]

  TEMP_SEQUENCE_INDEX = -1

  # GET /flashcards or /flashcards.json
  def index
    @flashcards = @topic.flashcards.where.not(id: nil).order(:sequence_index)
    @flashcard = @topic.flashcards.build
  end

  # GET /flashcards/1 or /flashcards/1.json
  def show
    redirect_to topic_flashcards_url
  end

  # GET /flashcards/new
  def new
    @flashcard = @topic.flashcards.new
  end

  # GET /flashcards/1/edit
  def edit
  end

  # POST /flashcards or /flashcards.json
  def create
    @flashcard = @topic.flashcards.new(flashcard_params)

    respond_to do |format|
      if @flashcard.save
        format.html { redirect_to topic_flashcards_url, notice: "Flashcard was successfully created." }
        format.json { render :show, status: :created, location: @flashcard }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flashcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flashcards/1 or /flashcards/1.json
  def update
    respond_to do |format|
      if @flashcard.update(flashcard_params)
        format.html { redirect_to topic_flashcards_url, notice: "Flashcard was successfully updated." }
        format.json { render :show, status: :ok, location: @flashcard }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flashcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flashcards/1 or /flashcards/1.json
  def destroy
    @flashcard.destroy

    respond_to do |format|
      format.html { redirect_to topic_flashcards_url, notice: "Flashcard was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def move_up
    this_flashcard_sequence_index = @flashcard.sequence_index
    if this_flashcard_sequence_index > 1
      previous_flashcard = @topic.flashcards.find_by(sequence_index: this_flashcard_sequence_index - 1)
      if previous_flashcard
        ActiveRecord::Base.transaction do
          @flashcard.update(sequence_index: TEMP_SEQUENCE_INDEX)
          previous_flashcard.update(sequence_index: this_flashcard_sequence_index)
          @flashcard.update(sequence_index: this_flashcard_sequence_index - 1)
        end
      else
        flash[:alert] = "No previous flashcard found."
      end
    end

    redirect_back(fallback_location: topic_flashcards_url)
  end

  def move_down
    this_flashcard_sequence_index = @flashcard.sequence_index
    if this_flashcard_sequence_index < @topic.flashcards.count
      next_flashcard = @topic.flashcards.find_by(sequence_index: this_flashcard_sequence_index + 1)
      if next_flashcard
        ActiveRecord::Base.transaction do
          @flashcard.update(sequence_index: TEMP_SEQUENCE_INDEX)
          next_flashcard.update(sequence_index: this_flashcard_sequence_index)
          @flashcard.update(sequence_index: this_flashcard_sequence_index + 1)
        end
      else
        flash[:alert] = "No next flashcard found."
      end
    end

    redirect_back(fallback_location: topic_flashcards_url)
  end

  private

    def set_topic
      @topic = current_user.topics.find(params[:topic_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_flashcard
      @flashcard = @topic.flashcards.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flashcard_params
      params.require(:flashcard).permit(:question, :answer, :hint, :topic_id)
    end
end
