class JokesController < ApplicationController
    def create
      @joke = Joke.new(joke_params)
    
      if @joke.save
        respond_to do |format|
          format.html do
            redirect_to root_path
          end
          format.json { render json: { joke: @joke }, status: :created }
        end
      else
        respond_to do |format|
          format.html do
            render 'random_jokes/index', status: :unprocessable_entity
          end
          format.json { render json: { errors: @joke.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
    
    def destroy
      @joke = Joke.find_by(id: params[:id])
      if @joke
        @joke.destroy
        head :no_content
      else
        head :not_found
      end
    end    

    def destroy_all
      Joke.delete_all
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    
  
    def index
      @jokes = Joke.all
    end
  
    private
  
    def joke_params
      params.require(:joke).permit(:content, :source)
    end
  end
  