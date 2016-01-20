class ListItemController < ApplicationController
  def index
    redirect_to(:controller => 'todo_list', :action => 'index')
  end

  def show
    @listitem = ListItem.find(params[:id])
  end

  def edit
    @listitem = ListItem.find(params[:id])
  end
  def update
    # Find an existing object using form parameters
    @listitem = ListItem.find(params[:id])
    # Update the object
    if  @listitem.update_attributes(listitem_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "todolist updated successfully."
      redirect_to(:action => 'show', :id =>  @listitem.id)
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def new
     @todolist = TodoList.find(params[:id])
     @listitem = ListItem.new({:todolist_id => params[:id]})
  end

  def create
    # Instantiate a new object using form parameters
    @listitem = ListItem.new(listitem_params)
    # Save the object
    if @listitem.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "List Item created successfully."
      redirect_to(:controller => 'todo_list' ,:action => 'show', :id => @listitem.todolist_id)
    else
      # If save fails, redisplay the form so user can fix problems
      redirect_to(:action => 'index')
    end
  end

  def delete
      @listitem = ListItem.find(params[:id])
  end
  def destroy
    listitem = ListItem.find(params[:id]).destroy
    flash[:notice] = "listitem'#{listitem.id}' destroyed successfully."
    redirect_to(:controller => 'todo_list' ,:action => 'show' , :id => listitem.todolist_id)
  end
  private

    def listitem_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:listitem).permit(:ingaveDatum, :eindDatum, :prioriteit, :beschrijving, :todolist_id)
    end

end
