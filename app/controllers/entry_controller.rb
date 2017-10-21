class EntryController <ApplicationController


  get '/entries' do

    @entries = Entry.all

    erb :"entries/index"
  end

  get '/entries/new' do

    erb :"entries/new"
  end

  post '/entries' do
    # @user = User.find_by_slug(params[:slug])
    @entry = Entry.create(params[:entry])
    # @user.entries << @entry

    redirect '/entries'

  end

  get '/entry/:id' do
    @entry = Entry.find(params[:id])

    erb :"entries/show"
  end

  get '/entry/:id/edit' do

    erb :"entries/edit"
  end

  patch '/entry/:id/edit' do

  end

  delete '/entry/:id' do

  end



end
