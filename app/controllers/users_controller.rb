class UsersController < ApplicationController
  def index
    result = User::Operation::Index.(params: params)
    render json: result
  end

  def show 
    result = User::Operation::Show.(params: params)
    render json: result
  end
end
