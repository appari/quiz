    class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user
    # GET /questions
    # GET /questions.json
    def index
        @questions = Question.all
        #@questions.sort {|a,b| a.text <=> b.text}
        @user = User.find session[:user_id]
        @choices=Choice.all
    end

    # GET /questions/1
    # GET /questions/1.json
    def show
        @question = Question.find(params[:id])
    end

    # GET /questions/new
    def new
        @question = Question.new
        @genres=Genre.all
        @subgenres=Subgenre.all
        @user = User.find session[:user_id]
    end

    def quiz
        session[:subgenre]= params[:subgenre]
        redirect_to quiz_index_path(subgenre: session[:subgenre])
    end
    # GET /questions/1/edit
    def edit
        @question = Question.find(params[:id])
    end
    def genres
        @movies=Subgenre.where(:genre_id => 1)
        @sports=Subgenre.where(:genre_id => 2)
        @social=Subgenre.where(:genre_id => 3)
    end

    # POST /questions
    # POST /questions.json
    def create
        @current_user = User.find session[:user_id]
        if @current_user.admin
            pa=question_params
            s=pa[:subgenre]
            b=Subgenre.find s.to_i
            @question= Question.new(question: pa[:question],correct_ans: pa[:a]+pa[:b]+pa[:c]+pa[:d],subgenre_id: s)
            if @question.save && b.genre_id == pa[:genre].to_i
                p @choice1 = Choice.new(text: pa[:option1],correct: pa[:a],question_id: @question.id)
                p @choice2 = Choice.new(text: pa[:option2],correct: pa[:b],question_id: @question.id)
                p @choice3 = Choice.new(text: pa[:option3],correct: pa[:c],question_id: @question.id)
                p @choice4 = Choice.new(text: pa[:option4],correct: pa[:d],question_id: @question.id)
                if @choice1.save && @choice2.save && @choice3.save && @choice4.save
                    flash[:notice] = "Question created"
                    flash[:color] = "valid"
                    redirect_to questions_path
                else
                    @question.destroy
                    p @choice1.errors
                    flash[:notice] = "Options Incorrect"
                    flash[:color] = "invalid"
                    redirect_to new_question_path
                end
            else
                @question.destroy
                flash[:notice] = "Question not created"
                flash[:color] = "invalid"
                redirect_to new_question_path
            end
        else
            flash[:notice] = "Acces Denied"
            flash[:color] = "invalid"
            redirect_to home_path
        end
    end

    def movies
    end

    def sports
        @user = User.find session[:user_id]
        @sports = Genre.where(:genre => "SPORTS")
    end

    def social
        @user = User.find session[:user_id]
        @social=Question.where(:genre => "social")
    end
    # PATCH/PUT /questions/1
    # PATCH/PUT /questions/1.json
    def update
        @current_user = User.find session[:user_id]
        if @current_user.admin
            respond_to do |format|
                if @question.update(question_params)
                    format.html { redirect_to @question, notice: 'Question was successfully updated.' }
                    format.json { render :show, status: :ok, location: @question }
                else
                    format.html { render :edit }
                    format.json { render json: @question.errors, status: :unprocessable_entity }
                end
            end
        else
            flash[:notice] = "Acces Denied"
            flash[:color] = "invalid"
        end
    end

    # DELETE /questions/1
    # DELETE /questions/1.json
    def destroy
        @current_user = User.find session[:user_id]
        if @current_user.admin
            @question.destroy
            respond_to do |format|
                format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
                format.json { head :no_content }
            end
        else
            flash[:notice] = "Acces Denied"
            flash[:color] = "invalid"
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
        @question = Question.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
        params.require(:question).permit(:question,:a,:b,:c,:d,:option1,:option2,:option3,:option4,:genre,:subgenre)
    end
end
