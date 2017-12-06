class UsersController < ApplicationController
    before_action :save_login_state, :only => [:new, :create]
    def new
        #signup form_tag
        @user=User.new
    end

   def create
       	@user = User.new(user_params)
        if @user.save
    		flash[:notice] = "You Signed up successfully"
        flash[:color]= "valid"
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
      end

      render "new"
    end
    def add_participant
        @current_user = User.find session[:user_id]
        @user = User.new
        if @current_user.admin
            render "new_participant"
        else
            flash[:notice] = "Access denied"
        end

    end
    def create_participant
        @user = User.new(user_params)
        @current_user = User.find session[:user_id]
        if(@current_user.admin && @user.save)
            flash[:notice] = "Participant has been created succesfully"
            flash[:ccolor] = "valid"

        else
            flash[:notice] = "Not created"
            flash[:color] = "invalid"
        end
        render "new_participant"
    end
    private



 def user_params
   params.require(:user).permit(:username, :email, :password, :password_confirmation)
 end
end
