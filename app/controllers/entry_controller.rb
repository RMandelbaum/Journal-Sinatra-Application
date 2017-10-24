require 'rack-flash'

class EntryController <ApplicationController
  use Rack::Flash


    get '/entries' do
        @user = User.find(session[:user_id])
  

        if is_logged_in? && current_user.id == @user.id
          erb :"entries/index"
        else
          flash[:message] = "You can't access this page!"
          redirect '/login'
        end
    end

    get '/entries/new' do

        if is_logged_in? && current_user
          @user = User.find_by(username: params[:username])

          erb :"entries/new"
        else
          flash[:message] = "You can't access this page!"
          redirect "/login"
        end
    end

    post '/entries' do

      @user = current_user
      @entry = current_user.entries.new(date: params[:entry][:date], content: params[:entry][:content], user_id: @user.id)
        if @entry.save

          redirect "/entries"
        else
          flash[:message] = "You must fill in all fields!"

          redirect '/entries/new'
        end

      # @user.entries << @entry
    end

    get '/entries/:id' do

      @entry = Entry.find_by_id(params[:id])
        if is_logged_in? && @entry.user == current_user

            erb :"entries/show"
        else
          flash[:message] = "You can't access this page!"
          redirect "/login"
        end

    end

    get '/entries/:id/edit' do

      @entry = Entry.find(params[:id])
        if is_logged_in? && @entry.user == current_user
          erb :"entries/edit"
        else
          flash[:message] = "You can't access this page!"
          redirect "/login"
        end
    end

    patch '/entries/:id' do

      @entry = Entry.find_by_id(params[:id])

        if params[:entry][:content].empty? || params[:entry][:date].empty?
          redirect to "/entries/#{@entry.id}/edit"

        elsif is_logged_in? && @entry.user_id == current_user.id
          @entry.update(params[:entry])

          redirect to "/entries"

        else
          flash[:message] = "You must fill in all fields!"
          redirect to "/login"
        end
    end

    delete '/entries/:id' do

      @entry = Entry.find(params[:id])
        if is_logged_in? && @entry.user_id == current_user.id
          @entry.delete
        end

      redirect to "/entries"

    end



  end
