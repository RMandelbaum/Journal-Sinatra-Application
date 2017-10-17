class UserController < ApplicationController


  get 'users/signup' do

    erb :"users/signup"

  end

  post 'users/signup' do

    redirect "users/#{@user.slug}"

  end

  get 'users/login' do

    erb :"users/login"

  end

  post 'users/login' do

    redirect "users/#{@user.slug}"
  end

  get 'users/:slug' do

    erb :"users/home"

  end

  get 'users/logout' do
    session.clear

    redirect "users/login"
  end
end
