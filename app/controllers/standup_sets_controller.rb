class StandupSetsController < ApplicationController
    require 'net/http'
    require 'json'
  
    def index
        @standup_sets = StandupSet.all
        
        respond_to do |format|
            format.json { render json: { standup_sets: @standup_sets }, status: :ok }
        end
    end

    def create
        @standup_set = StandupSet.new(standup_set_params)
        if @standup_set.save
            respond_to do |format|
                format.json { render json: { standup_set: @standup_set }, status: :created }
            end
        else
            respond_to do |format|
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
        @standup_set.jokes << @joke
        respond_to do |format|
          format.json { render json: { standup_set: @standup_set, debug: { standup_set: @standup_set.inspect, joke: @joke.inspect, jokes_in_standup_set: @standup_set.jokes.inspect } }, status: :ok }
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