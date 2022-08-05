module InstaPost
    class CommentAPI < Grape::API
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

        resource :insta_post do
            route_param :id do
                desc "Post a comment"
                post "/comment" do
                    @comment = Comment.new({user_id:current_user.id,post_id:params[:id],body:params[:body]})
                    @comment.save!
                end

                desc "Get all comments on a post"
                get "/comment" do
                    comments = Comment.where(post_id:params[:id])
                end
            end
        end

    end
end