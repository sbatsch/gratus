class Api::UsersController < ApplicationController
  def create
      user = User.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
      if user.save
        render json: { message: "User created successfully" }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :bad_request
      end
   end

  def show
    if current_user && params[:id] == "current"
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    
    render 'show.json.jb'
  end 

  # def report
  #   if current_user && params[:id] == "current"
  #     @user = current_user
  #   else
  #     @user = User.find(params[:id])
  #   end
    
  #   render 'report.json.jb'
  # end
  
end
