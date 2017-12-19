class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    
    def new
    end

    def create
        user = User.create(user_params)

        if user.valid?
            session[:user_id] = user.id
            # puts 'error'
            return redirect_to user_path user.id 
        end
        flash[:errors] = user.errors.full_messages
        # puts 'contin'
        return redirect_to :back
    end

    def show
        @user = User.find(params[:id])
    end

    def index
        redirect_to "/groups"
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
        end
end
