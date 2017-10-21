class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions

  get '/' do

    erb :'home'

  end

  def current_user
    @user = User.find_by_id(session[:user_id])
  end
  def is_logged_in?
    !!session[:user_id]
  end

  
end
