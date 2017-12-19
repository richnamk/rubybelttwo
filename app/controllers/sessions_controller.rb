class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
    end

    def index
        return redirect_to "/groups"
    end
    
    def create
        user = User.find_by_email(params[:user][:email])
        if user
          if user.try(:authenticate, params[:user][:password])
              session[:user_id] = user.id

              return redirect_to groups_path
          end
            flash[:errors] = ['Password is incorrect']
        else
            flash[:errors] = ['Invalid account. Register first.']
        end
        return redirect_to :back
    end

    def destroy
        session.delete(:user_id) if session[:user_id]
        return redirect_to new_login_path
    end
end
