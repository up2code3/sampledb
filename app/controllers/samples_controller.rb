class SamplesController < ApplicationController
    before_action :require_admin 

    def new
        @sample = Sample.new
        @tracks = Track.order(:title)
    end

    def create
        @sample = Sample.new(sample_params)
        if @sample.save
            redirect_to dashboard_path, notice: "Sample Connection created!"
        else 
            @tracks = Track.order(:title)
            render :new, status: :unprocessable_entity
        end
    end

    private

    def sample_params
        params.require(:sample).permit(:derived_track_id, :source_track_id)
    end
end