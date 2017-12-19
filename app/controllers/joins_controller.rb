class JoinsController < ApplicationController

    def index
        @group = Group.find(params[:id])
        redirect_to "/groups/#{@group.id}"
    end

    def create
        @group = Group.find(params[:id])
        @user = User.find(session[:user_id])
        @join = Join.new(user_id:@user.id,group_id:@group.id)
        if @join.valid?
            @join.save
            flash[:notice] = ["You joined this borg."]
            redirect_to "/groups/#{@group.id}"
        else
            flash[:errors] = @join.errors.full_messages
            redirect_to :back
        end
    end

    def destroy
        @group = Group.find(params[:id])
        @user = User.find(session[:user_id])
        @join = Join.find_by_group_id(@group.id)
        if @join.user_id == @user.id
            @join.destroy
            flash[:notice]=["You left this collective."]
            redirect_to "/groups/#{@group.id}"
        else
            flash[:errors] = @join.errors.full_messages
            redirect_to :back
        end
    end

end
