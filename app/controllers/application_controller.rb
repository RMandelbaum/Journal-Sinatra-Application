class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions


  get '/' do

    erb :'home'

  end

  helpers do
    def current_user #=> User Instance || nil
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def is_logged_in?
      !!current_user
    end
  end

end
