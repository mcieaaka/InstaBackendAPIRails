module InstaUser
    class SessionsAPI < Grape::API
    # include HelperMethods::Helpers
        helpers do
            def session
                env['rack.session']
            end

            def login_in (user)
                session[:user_id] = user.id
            end

            def current_user
                if session[:user_id]
                    @current_user ||= User.find_by(id: session[:user_id])
                end
            end

            def logged_in?
                !current_user.nil?
            end

            def log_out
                session.delete(:user_id)
                # reset_session
                @current_user = nil
            end
        end

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

        delete :session do
            log_out
            {result:{'LogOut':"Successful"}}
        end

    end
end