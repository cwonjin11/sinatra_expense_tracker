class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect to('/expenses')
    end
  end

  post '/signup' do
    @user = User.new(params)
    if !@user.save
      @errors = @user.errors.full_messages
      erb :'users/create_user'
    else
      session[:user_id] = @user.id
      redirect to('/expenses')
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to('/expenses')
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to('/expenses')
    else
      @errors = "Invalid username or password."
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?
      @user = current_user
      @user = nil
      session.destroy
      redirect to('/')
    else
      rediect to('/')
    end
  end

end
