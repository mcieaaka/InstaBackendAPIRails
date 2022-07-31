module InstaPost
    class PostAPI < Grape::API
        version 'v1',using: :path
        format :json
        prefix ':uid/api'

        resource :insta_post do 
            desc 'Create a new Post'
            params do
                requires :caption, type:String #Text and String??
            end
             #Since no session, hence user id in route
            post do
                @post = Post.new({caption:params[:caption],user_id:params[:uid]})
                file = ActionDispatch::Http::UploadedFile.new(params[:image])
                @post.image = file
                @post.save!
            end
            

            desc 'Get Specific Post'
            route_param :id do
                get do
                    post = Post.find(params[:id])
                    present post
                end
            end

            desc 'Delete User'
            route_param :id do
                delete do
                    Post.find(params[:id]).destroy
                end
            end
        end
    end
end