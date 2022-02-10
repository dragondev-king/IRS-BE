class FilersController < ApplicationController

    #GET /filers
    def index
        @filers = Filer.all
        render json: @filers
    end

    #GET /filers/:id
    def show
        @filer = Filer.find(params[:id])
        render json: @filer
    end
end
