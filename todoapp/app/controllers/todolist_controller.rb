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

  def filter
    listitemscouch = Listitemcouch.by_prioriteit
    @list = []
    listitemscouch.each do |listitem|
      if listitem.prioriteit.to_i == params[:id].to_i
        @list.push(listitem)
      end
    end
  end

  private

    def listitem_params
      params.fetch(:listitem, {}).permit(:ingavedatum, :einddatum, :prioriteit, :beschrijving, :status)
    end

end
