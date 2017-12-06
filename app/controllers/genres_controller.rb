class GenresController < ApplicationController
    def index
        @genres=Genre.all
        @current_user = User.find session[:user_id]
    end
    def new
        @genre=Genre.new
        @current_user = User.find session[:user_id]
    end
    def create
        @genre = Genre.new(genre: genre_params[:genre],description: genre_params[:description])
        if @genre.save
            create_subgenres(genre_params,@genre)
            flash[:notice] = "You created a new genre successfully"
            flash[:color]= "valid"
        else
            flash[:notice] = "Form is invalid"
            flash[:color]= "invalid"
        end
        redirect_to genres_path
    end
    def create_subgenres(names,genre)
        if @s1=Subgenre.create!(genre:genre,name:names[:subgenre1]) && @s2=Subgenre.create!(genre:genre,name:names[:subgenre2]) && @s3=Subgenre.create!(genre:genre,name:names[:subgenre3])
            return
        else
            flash[:notice] = "Subgenres not created"
            flash[:color] = "invalid"
        end
    end

    def destroy
        @current_user = User.find session[:user_id]
        if @current_user.admin
            @genre.destroy
            Subgenre.where(:genre_id => @genre_id).each do |x|
                x.destroy
            end
            respond_to do |format|
                format.html { redirect_to genres_url, notice: 'Question was successfully destroyed.' }
                format.json { head :no_content }
            end
        else
            flash[:notice] = "Acces Denied"
            flash[:color] = "invalid"
        end
    end
    private
    def genre_params
        params.require(:genre).permit(:genre,:subgenre1,:subgenre2,:subgenre3, :description)
    end
end
