module InstaUser
    class API < Grape::API
        version 'v1', using: :path
        format :json
        prefix 'api'
        
        resource :insta_user do
            desc 'Create a new user'
            params do
                requires :email,type:String
                requires :name, type:String
                requires :bio, type:String
            end
            post do
                User.create!({email:params[:email], name:params[:name], bio:params[:bio]})
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
                    present user
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