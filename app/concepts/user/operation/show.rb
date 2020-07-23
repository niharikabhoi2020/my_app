module User::Operation
  class Show < Trailblazer::Operation
    step :user_exist?
    step :show_user
    fail :set_error_msg

    def show_user(ctx, params:, **)
      ctx[:user] = User.find(params[:id])
    end

    def user_exist?(ctx, params: , **)
      User.where(id: params[:id]).exists?
    end

    def set_error_msg(ctx, params:, **)
      ctx[:error] = "User with id '#{params[:id]}' does not exists"
    end
  end
end