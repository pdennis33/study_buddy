require 'csv'

class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic,
    only: %i[ show edit update destroy start_quiz quiz import_flashcards ]

  # GET /topics or /topics.json
  def index
    @topics = current_user.topics.all
  end

  # GET /topics/1 or /topics/1.json
  def show
    @flashcards = @topic.flashcards.where.not(id: nil)
    @flashcard = @topic.flashcards.build
  end

  # GET /topics/new
  def new
    @topic = current_user.topics.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics or /topics.json
  def create
    @topic = current_user.topics.build(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topic_url(@topic), notice: "Topic was successfully created." }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: "Topic was successfully updated." }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url, notice: "Topic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def start_quiz
    redirect_to quiz_flashcard_topic_path(@topic, @topic.flashcards.first)
  end

  def quiz
    @flashcard = @topic.flashcards.find(params[:flashcard_id])
    @previous_flashcard = @topic.flashcards.where('id < ?', @flashcard.id).last
    @next_flashcard = @topic.flashcards.where('id > ?', @flashcard.id).first
  end

  def import_flashcards
    uploaded_file = params[:csv_file]

    unless uploaded_file && uploaded_file.size > 0 && uploaded_file.content_type == "text/csv"
      flash[:alert] = "Please select a valid CSV file."
      redirect_to @topic and return
    end

    # Check for the correct headers
    headers = CSV.open(uploaded_file.path, &:readline)
    unless headers.map(&:downcase).map(&:strip).include?("question") &&
      headers.map(&:downcase).map(&:strip).include?("answer")
      flash[:alert] = "Please ensure your CSV file has Question and Answer columns and an optional Hint."
      redirect_to @topic and return
    end

    if uploaded_file
      begin
        ActiveRecord::Base.transaction do
          CSV.foreach(uploaded_file.path, headers: true,
            header_converters: [:downcase, :symbol]) do |row|
            @topic.flashcards.create!(
              question: row[:question],
              answer: row[:answer],
              hint: row[:hint] || nil
            )
          end
        end
        flash[:notice] = "Flashcards imported successfully!"
      rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = "Error importing flashcards: #{e.message}"
      end
    else
      flash[:alert] = "Please select a valid CSV file."
    end

    redirect_to @topic
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = current_user.topics.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:title, :description)
    end
end
