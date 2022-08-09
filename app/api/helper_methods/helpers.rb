module HelperMethods
    module Helpers
        extend Grape::API::Helpers
        
        # config.middleware.use ActionDispatch::Session::CookieStore
        # use ActionDispatch::Session::CookieStore
        # helpers do
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
    # end
end