class SessionsController < ApplicationController
    def create 
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
        end
        session[:user_id] = @user.id 
        render 'welcome/home'
    end

    def destroy
        session.delete :user_id 
        redirect_to root_path 
    end

    # def facebook 
    #     @user = User.find_or_create_by(name: auth["info"]["name"]) do |user| 
    #         user.password =  SecureRandom.hex(10)
    #     end 
    #     if @user && @user.id
    #         session[:user_id] = @user.id
    #         redirect_to welcome_home_path 
    #     else 
    #         redirect_to root_path 
    #     end 
    # end 
    private 

    def auth 
        request.env['omniauth.auth']
    end
end
