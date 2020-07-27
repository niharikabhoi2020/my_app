module User::Operation
  class SessionTwoHw < Trailblazer::Operation
    step :get_records
    step :is_request_from_web_app?, Output(:failure) => Id(:order_desc_on_create_at)
    step :filter_with_status, Output(:success) => Track(:web_path)
    step :set_response_for_web, pass_fast: true, magnetic_to: :web_path 
    step :order_desc_on_create_at, Output(:success) => Track(:mobile_path)
    step :set_response_for_mobile, magnetic_to: :mobile_path

    def get_records(ctx, **)
      ctx[:users] = User.all
    end

    def is_request_from_web_app?(ctx, params:, **)
      params[:is_web_app_request]
    end

    def filter_with_status(ctx, users:, **)
      ctx[:active_users] = users.where(is_active: true)
    end

    def set_response_for_web(ctx, active_users:, **)
      active_users
    end

    def order_desc_on_create_at(ctx, users:, **)
      ctx[:sorted_users] = users.order(created_at: :desc)
    end

    def set_response_for_mobile(ctx, sorted_users, **)
      sorted_users
    end
  end
end