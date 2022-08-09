module InstaUser
    class SessionsAPI < Grape::API
        helpers HelperMethods::Helpers
        use ActionDispatch::Session::CookieStore
        version 'v1',using: :path
        format :json
        prefix 'api'

        # params do
        #     requires :session, type: JSON
        # end
        desc 'Create a session'
        post :session do
            user = User.find_by(email:params[:session][:email].downcase)
            if user && user.authenticate(params[:session][:password])
                login_in user
                {result:{'login_message':"Successful Login"}}
            else
                {result:{'error':"Invalid email and password combination."}}
            end
        end

        desc 'End a session'
        delete :session do
            log_out
            {result:{'LogOut':"Successful"}}
        end

    end
end