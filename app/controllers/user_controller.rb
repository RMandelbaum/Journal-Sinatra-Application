require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do

    @users = User.all
      if is_logged_in?

        redirect to "/users/#{@user.slug}"
      else

        erb :"users/signup"

      end
    end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.slug}"
      else
        flash[:message] = "Fill in all fields. Refresh to Signup."

        redirect to '/signup'
      end
   end

  get '/login' do
    if current_user #&& is_logged_in?
      redirect to "/users/#{@user.slug}"
    else
    erb :"users/login"
    end
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id]= @user.id
        redirect "/users/#{@user.slug}"
      else
        flash[:message] = "You must fill in all fields. Refresh to Login."

        redirect "/login"
      end
  end


  get '/logout' do
      if is_logged_in?
         session.destroy
         redirect to '/login'
       else
         redirect to '/'
       end
     end

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      if is_logged_in? && @user.id == session[:user_id]

        erb :"users/home"
      else

        flash[:message] = "You can't access this page!"
        redirect '/entries'
      end
  end
end
