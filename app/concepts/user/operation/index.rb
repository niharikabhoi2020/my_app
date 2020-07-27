module User::Operation
  class Index < Trailblazer::Operation
    fail :set_minus_one_error_msg
    step :is_request_valid?
    step :fetch_users,  Output(:success) => Track(:niharika),
                        Output(:failure) => Track(:failure),
                        magnetic_to: :success 
    pass :first_pass_task,  Output(:success) => Track(:success),
                            Output(:failure) => Track(:success),
                            magnetic_to: :success
    step :fetch_users_2,  Output(:success) => Track(:success),
                          Output(:failure) => Id(:skip_sample_step),
                          magnetic_to: :niharika               
    fail :set_error_msg, fail_fast: true 
    step :sample_step, pass_fast: true
    fail :set_second_error_msg, Output(:success) => Track(:failure),
                                Output(:failure) => Track(:failure),
                                magnetic_to: :failure
    step :skip_sample_step
    
                                
    
    
    def fetch_users(ctx, **)
      p "in second step"
      ctx[:users] = User.all
    end

    def fetch_users_2(ctx, **)
      p "in fetch users 2"
      false
    end

    def is_request_valid?(ctx, params: , **)
      p "in first step"
      params[:is_valid] == "true"
    end

    def set_error_msg(ctx, **)
      p "in first fail"
      ctx[:error] = "Invalid request"
    end

    def sample_step(ctx, **)
      p "in third(sample) step"
      true
    end

    def set_second_error_msg(ctx, **)
      p "in scond fail"
      ctx[:error] = "Second invalid msg"
    end

    def first_pass_task(ctx, **)
      p "first pass task"
      # success or failure of pass will not be checked. it continues to exicute next step
    end

    def set_minus_one_error_msg
      p "in minus one task"
    end

    def skip_sample_step(ctx, **)
      p "if fetching users failed skipped sample step"
    end
  end
end