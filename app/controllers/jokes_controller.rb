class JokesController < ApplicationController
    def create
      @joke = Joke.new(joke_params)
  
      if @joke.save
        flash[:notice] = 'Joke created successfully.'
        redirect_to root_path
      else
        render json: { errors: @joke.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy_all
        Joke.delete_all
        flash[:notice] = 'All jokes deleted successfully.'
        redirect_to jokes_path
      end
      

    def index
        @jokes = Joke.all
      end
  
    private
  
    def joke_params
      params.require(:joke).permit(:content, :source)
    end
  end
  