module User::Operation
  class Index < Trailblazer::Operation
    step :fetch_users

    def fetch_users(ctx, **)
      ctx[:users] = User.all
    end

  end
end