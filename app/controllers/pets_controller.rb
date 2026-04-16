class PetsController < ApplicationController
  def index
    # Usamos includes(:owner) para que la base de datos cargue los dueños más rápido
    @pets = Pet.includes(:owner).all
  end

  def show
    @pet = Pet.find(params[:id])
  end
end