class GroupsController < ApplicationController

    def index
      @user = User.find(session[:user_id])
      @user_groups = @user.groups
      @groups = Group.where.not(user_id:@user.id)
    end
      
    def new
      return redirect_to "/groups"
    end

    def show
        @group = Group.find(params[:id])
        @member_count = @group.joins.count('DISTINCT user_id')
        @members = @group.users
    end

    def create
        @user = User.find(session[:user_id])
        @group = Group.new group_params
        if @group.valid?
            @group.user_id = @user.id
            @group.save
            redirect_to "/groups/#{@group.id}"
        else
            flash[:errors] = @group.errors.full_messages
            redirect_to :back
        end
    end

    def edit
        @event = Event.find(params[:id])
    end

    def destroy
        @group = Group.find(params[:id])
        if @group.destroy
            reset_session
            flash[:notice]=["Group eradicated."]
            redirect_to "/groups"
        else
            flash[:errors] = @group.errors.full_messages
            redirect_to "/groups/#{@group.id}/edit"
        end
    end

    private
        def group_params
            params.require(:group).permit(:name, :description)
        end
        
end