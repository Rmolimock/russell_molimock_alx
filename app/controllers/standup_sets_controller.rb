class StandupSetsController < ApplicationController
    require 'net/http'
    require 'json'
  
    def index
        @standup_sets = StandupSet.all
                
        respond_to do |format|
            format.json { render json: { standup_sets: @standup_sets }, status: :ok }
        end
    end

    def show
      @standup_set = StandupSet.find_by(id: params[:id])
    
      if @standup_set
        @jokes = @standup_set.jokes
        respond_to do |format|
          format.json { render json: { standup_set: @standup_set, jokes: @jokes }, status: :ok }
        end
      else
        head :not_found
      end
    end
    
    

    def create
        @standup_set = StandupSet.new(standup_set_params)
        if @standup_set.save
            respond_to do |format|
                format.html { redirect_to jokes_path }
                format.json { render json: { standup_set: @standup_set }, status: :created }
            end
        else
            respond_to do |format|
                format.html { render 'jokes/index', status: :unprocessable_entity }
                format.json { render json: { errors: @standup_set.errors.full_messages }, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @standup_set = StandupSet.find_by(id: params[:id])
        if @standup_set
            @standup_set.destroy
            head :no_content
        else
            head :not_found
        end
    end

    def add_joke
      @standup_set = StandupSet.find_by(id: params[:id])
      @joke = Joke.find_by(id: params[:joke_id])
    
      if @standup_set && @joke
        begin
          @standup_set.jokes << @joke
          respond_to do |format|
            format.json { render json: { standup_set: @standup_set }, status: :ok }
          end
        rescue ActiveRecord::RecordNotUnique
          respond_to do |format|
            format.json { render json: { error: "This joke has already been added to the standup set." }, status: :unprocessable_entity }
          end
        end
      else
        head :not_found
      end
    end
    

    def remove_joke
      @standup_set = StandupSet.find_by(id: params[:id])
      @joke = Joke.find_by(id: params[:joke_id])

      if @standup_set && @joke
        @standup_set.jokes.delete(@joke)
        respond_to do |format|
          format.json { render json: { standup_set: @standup_set }, status: :ok }
        end
      else
        head :not_found
      end
    end

    private

    def standup_set_params
        params.require(:standup_set).permit(:name)
    end

end