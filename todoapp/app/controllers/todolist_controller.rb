class TodolistController < ApplicationController

  def new
    @listitem = Listitem.new
    @listitem.ingavedatum = params[:ingavedatum]
    @listitem.einddatum = params[:einddatum]
    @listitem.prioriteit = params[:prioriteit]
    @listitem.beschrijving = params[:beschrijving]
    @listitem.status = params[:status]
    @listitem.save
    @listitemcouch = Listitemcouch.new
    @listitemcouch.ingavedatum = params[:ingavedatum]
    @listitemcouch.einddatum = params[:einddatum]
    @listitemcouch.prioriteit = params[:prioriteit]
    @listitemcouch.beschrijving = params[:beschrijving]
    @listitemcouch.status = params[:status]
    @listitemcouch.save
  end

  private

    def listitem_params
      params.fetch(:listitem, {}).permit(:ingavedatum, :einddatum, :prioriteit, :beschrijving, :status)
    end

end
