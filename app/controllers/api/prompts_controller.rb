class Api::PromptsController < ApplicationController

  def show

    if params[:id] == "custom"
      random_id = Prompt.where(topic: current_user.generate_topic ).pluck(:id).sample
      @prompt = Prompt.find(random_id)
    elsif params[:id] == "random"
      random_id = Prompt.pluck(:id).sample
      @prompt = Prompt.find(random_id)
    else
      @prompt = Prompt.find(params[:id])
    end

    render 'show.json.jb'
  end

end
