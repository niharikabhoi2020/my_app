module User::Operation
  class Index < Trailblazer::Operation
    step :is_request_valid?
    step :fetch_users
    fail :set_error_msg, fail_fast: true 
    step :sample_step
    fail :set_second_error_msg

    def fetch_users(ctx, **)
      ctx[:users] = User.all
    end

    def is_request_valid?(ctx, params: , **)
      params[:is_valid]
    end

    def set_error_msg(ctx, **)
      ctx[:error] = "Invalid request"
    end

    def sample_step(ctx, **)
      false
    end

    def set_second_error_msg(ctx, **)
      ctx[:error] = "Second invalid msg"
    end
  end
end