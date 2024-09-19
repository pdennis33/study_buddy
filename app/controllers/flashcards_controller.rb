class FlashcardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic
  before_action :set_flashcard, only: %i[ edit update destroy ]

  # GET /flashcards or /flashcards.json
  def index
    @flashcards = @topic.flashcards.where.not(id: nil)
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
