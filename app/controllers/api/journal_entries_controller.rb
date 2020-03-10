class Api::JournalEntriesController < ApplicationController
  before_action :authenticate_user

  def index
    @journal_entries = JournalEntry.all
    render 'index.json.jb'
  end

  def create
    @journal_entry = JournalEntry.new(
                                      prompt_id: params[:prompt_id],
                                      user_id: params[:user_id], 
                                      date: params[:date],  
                                      body: params[:body],
                                      gratitude_level: params[:gratitude_level],
                                      gratitude_change: params[:gratitude_change] 
                                     )
    if @journal_entry.save
      render 'show.json.jb'
    else
      render json: {errors: @journal_entry.errors.full_messages}, status: :unprocessable_entity   
    end
  end 

  def show
    @journal_entry = JournalEntry.find(params[:id])
    render 'show.json.jb'
  end

  def update
    @journal_entry = JournalEntry.find(params[:id])

    @journal_entry.prompt_id = params[:prompt_id] || @journal_entry.prompt_id
    @journal_entry.user_id = params[:user_id] || @journal_entry.user_id
    @journal_entry.date = params[:date] || @journal_entry.date
    @journal_entry.body = params[:body] || @journal_entry.body
    @journal_entry.gratitude_level = params[:gratitude_level] || @journal_entry.gratitude_level
    @journal_entry.gratitude_change = params[:gratitude_change] || @journal_entry.gratitude_change

    if @journal_entry.save
      render 'show.json.jb'
    else
      render json: {errors: @journal_entry.errors.full_messages}, status: :unprocessable_entity   
    end
  end

  def destroy
    @journal_entry = JournalEntry.find(params[:id])
    @journal_entry.destroy
    render json: {message: "With every beginning there is an end...vale, mei jounral"}
  end
end




