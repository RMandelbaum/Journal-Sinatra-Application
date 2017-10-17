class EntryController <ApplicationController


  get '/entries' do

    erb :"entries/index"
  end

  get '/entries/new' do

    erb :"entries/new"
  end

  post '/entries' do

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
