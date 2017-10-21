class EntryController <ApplicationController


  get '/entries' do

    @entries = Entry.all

    erb :"entries/index"
  end

  get '/entries/new' do

    erb :"entries/new"
  end

  post '/entries' do
    @user = User.find_by_slug(params[:slug])
    @entry = Entry.create(params[:entry])
    @user.entries << @entry

    redirect '/entries'

  end

  get '/entries/:id' do

    erb :"entries/show"
  end

  get '/entries/:id/edit' do

    erb :"entries/edit"
  end

  patch '/entries/:id/edit' do

  end

  delete '/entries/:id' do

  end



end
