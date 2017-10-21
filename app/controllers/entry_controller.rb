class EntryController <ApplicationController


    get '/entries' do

        if is_logged_in? && current_user
          @user = User.find(session[:user_id])
          #new code to show only user's entries
          erb :"entries/index"
        else
          redirect '/users/login'
        end
    end

    get '/entries/new' do

        if is_logged_in? && current_user
          @user = User.find_by(params[:user])

          erb :"entries/new"
        else
          redirect "/users/login"
        end
    end

    post '/entries' do

      @user = current_user
      @entry = Entry.new(date: params[:entry][:date], content: params[:entry][:content], user_id: @user.id)
        if @entry.save
          redirect "/entries"
        else
          redirect '/entries/new'
        end

      # @user.entries << @entry
    end

    get '/entry/:id' do

      @entry = Entry.find_by_id(params[:id])
        if is_logged_in? && @entry.user == current_user

            erb :"entries/show"
        else
          redirect "users/login"
        end

    end

    get '/entry/:id/edit' do

      @entry = Entry.find(params[:id])
        if is_logged_in? && @entry.user == current_user
          erb :"entries/edit"
        else
          redirect "users/login"
        end
    end

    patch '/entry/:id' do

      @entry = Entry.find_by_id(params[:id])

        if params[:entry][:content].empty? || params[:entry][:date].empty?
          redirect to "/entry/#{@entry.id}/edit"

        elsif is_logged_in? && @entry.user_id == current_user.id
          @entry.update(params[:entry])

          redirect to "/entries"

        else

          redirect to "/users/login"
        end
    end

    delete '/entry/:id' do

      @entry = Entry.find(params[:id])
        if is_logged_in? && @entry.user_id == current_user.id
          @entry.delete
        end

      redirect to "/entries"

    end



  end
