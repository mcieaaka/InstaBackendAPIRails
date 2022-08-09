module InstaPost
    class PostAPI < Grape::API
        helpers HelperMethods::Helpers
        
        use ActionDispatch::Session::CookieStore
        version 'v1',using: :path
        format :json
        prefix 'api'

        resource :insta_post do 
            desc 'Create a new Post'
            params do
                requires :caption, type:String #Text and String??
                # byebug
                requires :images,  type:Array do
                    requires :image, :type => Rack::Multipart::UploadedFile
                end
            end
             #Since no session, hence user id in route
            post do
                # byebug
                @post = Post.new({user_id:current_user.id,caption:params[:caption]})
                # file = ActionDispatch::Http::UploadedFile.new(params[:image])
                # @post.image = file
                # puts params[:images]
                @post.images.attach(filename:params[:images],io:params[:images])# = params[:images]
                @post.save!
            end
            
            desc 'Get all posts'
            get  do
                post = Post.all
                present post
            end

            desc 'Get all posts of a user'
            get '/user/:uid' do
                posts = Post.where(user_id: params[:uid])
                present posts
            end

            desc 'Get Specific Post'
            route_param :id do
                get do
                    post = Post.find(params[:id])
                    # present post
                    {result:{'post':post,'pic':post.image.blob}}
                end
            end

            desc 'Delete Post'
            route_param :id do
                delete do
                    Post.find(params[:id]).destroy
                end
            end
        end
    end
end