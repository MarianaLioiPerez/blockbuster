class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  #SE AGREGA BEFORE ACTION, PARA QUE SE INTEGRE EL METODO CONSULTAR QUE CREAMOS PERO SOLO PARA EDIT O HACIA DONDE QUERAMOS
  before_action :consultar_clientes, only: %i[new edit]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    consultar_clientes
  end

  # GET /movies/1/edit
  def edit
    consultar_clientes
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:name, :client_id)
    end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end
    
    #SE AGREGA UN METODO PARA PERMITIR LA CONSULTA
    def consultar_clientes
      @clients = Client.all
    end
end
