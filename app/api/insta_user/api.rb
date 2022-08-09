module InstaUser
    class API < Grape::API
        helpers HelperMethods::Helpers

        use ActionDispatch::Session::CookieStore
        version 'v1', using: :path
        format :json
        prefix 'api'
        
        resource :insta_user do
            desc 'Create a new user'
            params do
                requires :email,type:String
                requires :name, type:String
                requires :bio, type:String
                # requires :image, 
                #Grape Text
            end
            post do
                @user=User.new({email:params[:email], name:params[:name], bio:params[:bio],password:params[:password],password_confirmation:params[:password_confirmation]})
                file = ActionDispatch::Http::UploadedFile.new(params[:image])
                @user.image = file
                if @user.save
                    login_in @user
                    present @user
                else
                    present @user.errors
                end
            end

            desc 'Return all Users'
            get do
                user = User.all
                present user
            end

            desc 'Get specific user'
            route_param :id do
                get do
                    user = User.find(params[:id])
                    # present user
                    {result:{'user':user,'image':user.image,'pic':user.image.blob}}
                end
            end

            desc 'Edit User'
            route_param :id do
                patch do
                    User.find(params[:id]).update({email:params[:email], name:params[:name], bio:params[:bio]})
                end
            end

            desc 'Delete User'
            route_param :id do
                delete do
                    User.find(params[:id]).destroy
                end
            end
            
        end
    end
end