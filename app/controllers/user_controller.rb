class UserController < ApplicationController


  get '/users/signup' do

    @users = User.all
      if is_logged_in? && current_user

        redirect to "/users/#{@user.slug}"
      else

        erb :"users/signup"

      end
    end

  post '/users/signup' do
    @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect "users/#{@user.slug}"
      else
        redirect to '/users/signup'
      end
   end

  get '/users/login' do
    if is_logged_in? && current_user
      redirect to "users/#{@user.slug}"
    else

    erb :"users/login"
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id]= @user.id
        redirect "users/#{@user.slug}"
      else
        redirect "/users/login"
      end
  end


  get '/users/:slug/logout' do
    @user = User.find_by_slug(params[:slug])
    if is_logged_in?
        session.clear
        redirect "/users/login"
      end
    end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
      if is_logged_in? && @user.id == session[:user_id]

        erb :"users/home"
      else

        erb :"users/error"

        redirect "/users/login"

      end
  end
end
