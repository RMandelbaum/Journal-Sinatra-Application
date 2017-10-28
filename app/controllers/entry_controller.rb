require 'rack-flash'

class EntryController <ApplicationController
  use Rack::Flash


    get '/entries' do
        if is_logged_in?
          @user = current_user
          erb :"entries/index"
        else
          flash[:message] = "You can't access this page!"
          redirect '/login'
        end
    end

    get '/entries/new' do
        if is_logged_in?
          erb :"entries/new"
        else
          flash[:message] = "You can't access this page!"
          redirect "/login"
        end
    end

    post '/entries' do
      entry = current_user.entries.build(params[:entry])
      if entry.save
        redirect "/entries"
      else
        flash[:message] = entry.errors.messages
        redirect '/entries/new'
      end
    end

    get '/entries/:id' do
      if is_logged_in?
        @entry = Entry.find_by_id(params[:id])
        if @entry && @entry.user == current_user
          erb :"entries/show"
        else
          flash[:message] = "You can't access this page!"
          redirect "/users/#{current_user.slug}"
        end
      else
        redirect '/login'
      end
    end


    get '/entries/:id/edit' do
      if is_logged_in?
        @entry = Entry.find(params[:id])
        if @entry && @entry.user == current_user
          erb :"entries/edit"
        else
          flash[:message] = "You can't access this page!"
          redirect "/users/#{current_user.slug}"
        end
      else
        redirect '/login'
      end
    end

    patch '/entries/:id' do
        entry = Entry.find_by_id(params[:id])
        if params[:entry][:content].empty? || params[:entry][:date].empty?
          flash[:message] = entry.errors.messages
          redirect to "/entries/#{entry.id}/edit"
        else
          entry.update(params[:entry])
          redirect '/entries'
        end

    end


    delete '/entries/:id' do
      if is_logged_in?
        @entry = Entry.find(params[:id])
        if @entry && @entry.user == current_user
           @entry.delete
           redirect to "/entries"
        else
          flash[:message] = "You can't access this page!"
          redirect "/users/#{current_user.slug}"
        end
      else
        redirect to "/login"
      end
    end

  end
