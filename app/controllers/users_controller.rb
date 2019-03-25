class UsersController < ApplicationController
  
  def home
  end

  def create
    @users = User.new(user_params)
    @users.save
    session[:params] = @users
    @errors = @users.errors
    

    if @errors.messages == {}
      flash[:success] = "You have Successfully Created a new account"
      redirect_to '/user'
    end

    if @errors.messages != {}
      if @errors['first_name']
        flash[:first_name] = @errors['first_name']
      end
      if @errors['last_name']
        flash[:last_name] = @errors['last_name']
      end
      if @errors['username']
        flash[:username] = @errors['username']
      end
      if @errors['email']
        flash[:email] = @errors['email']
      end
      if @errors['password']
        flash[:password] = @errors['password']
      end
      if params[:user]['password'] != params[:user]['confirm_password']
        flash[:confirm] = "password does not match confirmation"
      end
      redirect_to '/register'
    end
    
  end

  def truelogin
    @users = User.find_by_username(user_params['username'])
    session[:params] = @users
    if @users.try(:authenticate, user_params[:password])
      flash[:success] = "You have Successfully Logged in"
      # puts "@@@@@@@@@@@@@@@@"
      # p @users
    redirect_to '/user'
    else
      flash[:fail] = "Username or Password invalid"
      redirect_to '/login'
    end
  end

  def register
  end

  def login
  end

  def account
    if session[:params] == nil
      redirect_to '/login'
    else
    @users = User.where(id: session[:params]['id'])
    @tThreads = Subthread.where(user_id: @users[0]['id']).count
    @tComments = Comment.where(user_id: @users[0]['id']).count
    end
  end

  def edit_account
    if session[:params] == nil
      redirect_to '/login'
    else
    @edit = User.find(params[:id])
    end
  end

  def update_account
    user = User.find(params[:id])
    user.first_name = user_params['first_name']
    user.last_name = user_params['last_name']
    user.username = user_params['username']
    user.password = user_params['password']
    user.save
    @errors = user.errors

    if @errors.messages == {}
      flash[:success] = "You have Successfully Edited your account"
      redirect_to '/user/account'
    end

    if @errors.messages != {}
      if @errors['first_name']
        flash[:first_name] = @errors['first_name']
      end
      if @errors['last_name']
        flash[:last_name] = @errors['last_name']
      end
      if @errors['username']
        flash[:username] = @errors['username']
      end
      if @errors['email']
        flash[:email] = @errors['email']
      end
      if @errors['password']
        flash[:password] = @errors['password']
      end
      if params[:user]['password'] != params[:user]['confirm_password']
        flash[:confirm] = "password does not match confirmation"
      end
      redirect_to '/user/account/edit/'+ user.id.to_s
    end

  end

  def destroy_account
    user = User.find(params[:id])
    user.delete
    redirect_to '/home'
  end

  def edit_comment
    @edit = Comment.find(params[:id])
    if session[:params] == nil
      redirect_to '/login'
    end
  end

  def update_comment
    comment = Comment.find(params[:id])
    comment.content = comment_params['content']
    comment.save
    @errors = comment.errors
    # puts '@@@@@@@@@@@@'
    # p comment
    if @errors.messages == {}
      flash[:success] = "You have Successfully Edited your Comment"
      redirect_to '/user/thread/'+ comment.subthread_id.to_s
    end

    if @errors.messages != {}
      if @errors['content']
        flash[:content] = @errors['content']
        redirect_to '/edit/comment/'+ comment.id.to_s
      end
    end
  end

  def destroy_comment
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to '/user/thread/'+ comment.subthread_id.to_s
  end

  def edit_thread
    if session[:params] == nil
      redirect_to '/login'
    else
    @edit = Subthread.find(params[:id])
    end
  end

  def update_thread
    thread = Subthread.find(params[:id])
    thread.subthread_name = thread_params['subthread_name']
    thread.content = thread_params['content']
    thread.save
    @errors = thread.errors
    if @errors.messages == {}
      flash[:success] = "You have Successfully Edited your Thread"
      redirect_to '/user'
    end

    if @errors.messages != {}
      if @errors['subthread_name']
        flash[:subthread_name] = @errors['subthread_name']
      end
      if @errors['content']
        flash[:content] = @errors['content']
      end
      redirect_to '/edit/thread/'+ thread.id.to_s
    end
  end

  def destroy_thread
    Subthread.find(params[:id]).delete
    redirect_to '/user'
  end


  def index

    if session[:params] == nil
      redirect_to '/login'
    
    else
      
    @user = User.all

    @creater = User.where(id: session[:params]['id'])

    @forum1 = Forum.first
    @thread1 = Subthread.all.where(forum_id: @forum1.id)
    # @creater1 =

    @forum2 = Forum.second
    @thread2 = Subthread.all.where(forum_id: @forum2.id)
    # @creater2 =

    @forum3 = Forum.third
    @thread3 = Subthread.all.where(forum_id: @forum3.id)
    # @creater3 =
    end
  end

  def thread
    if session[:params] == nil
      redirect_to '/login'
    else
    @show = Subthread.where(id:params[:id])
    @comments= Comment.all.where(subthread_id:params[:id])
    @id = User.where(id: session[:params]['id'])
    @user = User.all
    end
  end

  def create_comment
    
    # redirect_to '/user'
    comment = Comment.new(comment_params)
    puts '@@@@@@@@@@@@@@'
    p comment
    comment.save

    # comments = Comment.create(comment_params)
    @sub = comment_params['subthread_id']
    redirect_to '/user/thread/'+@sub.to_s
  end

  def create_thread
    @threadMain = Subthread.create(thread_params)
    
    redirect_to '/user'
  end

  def delete_session
    session.clear
    redirect_to '/home'
  end



  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
    end

    def comment_params
      params.require(:com).permit(:content, :subthread_id, :user_id)
    end

    def thread_params
      params.require(:thrd).permit(:subthread_name, :content, :user_id, :forum_id)
    end

    
end
