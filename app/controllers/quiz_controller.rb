class QuizController < ApplicationController
    before_action :authenticate_user

    def index
        @subgenre = params[:subgenre]
        @current_user=User.find session[:user_id]
        id=Subgenre.where(:name => session[:subgenre])[0]
        x=Subgenre.find(id.id).genre_id
        l=Leaderboard.where(genre: x,user: session[:user_id], subgenre: id.id)
        if !l.empty?
            @continue = true
        else
            @continue = false
        end
    end
    def start
        if session[:subgenre]
            id=Subgenre.where(:name => session[:subgenre])[0]
            all = Question.where(:subgenre_id => id).map {|x| x.id}
            total = all.length
            session[:questions] = all.sort_by{rand}[0..(total-1)]
            id=Subgenre.where(:name => session[:subgenre])[0]
            x=Subgenre.find(id.id).genre_id
            l=Leaderboard.where(genre: x,user: session[:user_id], subgenre: id.id)
            if !l.empty?
                session[:total]   = l[0].total_qns
                session[:current] = l[0].question
                session[:correct] = l[0].score / 100
                session[:not_attempted] = l[0].total_qns - l[0].attempted
            else
                session[:total]   = total
                session[:current] = 0
                session[:correct] = 0
                session[:not_attempted] = 0
                new_l = Leaderboard.create!(genre: x,user: session[:user_id],subgenre:id.id,question: session[:current],total_qns:total,attempted:total - session[:not_attempted],score:0)

            end
            x=Subgenre.find(id.id).genre_id
            redirect_to :action => "question"
        else
            flash[:notice] = "Please select the subgenre"
            flash[:color] ="valid"
            redirect_to "/questions_genres"
        end

    end
    def destroy
        id=Subgenre.where(:name => session[:subgenre])[0]
        x=Subgenre.find(id.id).genre_id
        l=Leaderboard.where(genre: x,user: session[:user_id], subgenre: id.id)
        l.destroy_all
        redirect_to '/questions_genres'
    end

    def question
        @current = session[:current]
        @total   = session[:total]
        @current_user=User.find session[:user_id]
        if @current >= @total
            redirect_to :action => "end"
            return
        end

        @question = Question.find(session[:questions][@current])
        @choices = @question.choices.sort_by{rand}
        if @question.correct_ans.length == 1
            @multiple = false
        else
            @multiple = true
        end
        session[:question] = @question
        session[:choices] = @choices
    end

    def answer
        @current = session[:current]
        @total   = session[:total]
        choiceid = params[:choice]
        if choiceid == nil
            session[:not_attempted] = session[:not_attempted] + 1
            @current+=1
            session[:current]=@current
            if @current >= @total
                redirect_to :action => "end"
            else
                redirect_to "/quiz/question"
            end
        else
            @question = session[:question]
            @choices  = session[:choices]
            Choice.where(question_id: @question["id"] ).each do |choice|
                @choice = choiceid.include?(choice.id.to_s)
                if !(@choice ^ choice.correct)
                    @correct = true
                else
                    @correct = false
                    break
                end
            end
            if @correct
                session[:correct] += 1
            end

            session[:current] += 1
        end
        id=Subgenre.where(:name => session[:subgenre])[0]
        x=Subgenre.find(id.id).genre_id
        u=Leaderboard.update(genre: x,user: session[:user_id],subgenre:id.id,question: session[:current],total_qns:session[:total],attempted:session[:current],score:session[:correct]*100)
    end

    def end
        @correct = session[:correct]
        @total   = session[:total]
        @current_user=User.find session[:user_id]
        @score = @correct * 100

        session[:subgenre] = nil
    end
    private
    def set_subgenre
        if session[:subgenre]
            redirect_to "index"
        else
            redirect_to "/questions_genres"
        end
    end
end
