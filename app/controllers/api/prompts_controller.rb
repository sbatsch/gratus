class Api::PromptsController < ApplicationController

  def show
    if params[:id] == "random"
      random_id = Prompt.pluck(:id).sample
      @prompt = Prompt.find(random_id)
    else
      @prompt = Prompt.find(params[:id])
    end

    render 'show.json.jb'
  end

end
