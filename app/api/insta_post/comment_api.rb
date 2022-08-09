module InstaPost
    class CommentAPI < Grape::API
        helpers HelperMethods::Helpers

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