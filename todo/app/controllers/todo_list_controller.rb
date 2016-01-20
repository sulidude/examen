class TodoListController < ApplicationController
  def show
    @listitems = ListItem.where(todolist_id: params[:id]).order("prioriteit ASC")
    @todolist =  TodoList.find(params[:id])
  end

  def index
    @todolists = TodoList.order("id ASC")
  end

  def edit
    @todolist = TodoList.find(params[:id])
  end
  def update
    # Find an existing object using form parameters
    @todolist = TodoList.find(params[:id])
    # Update the object
    if  @todolist.update_attributes(todolist_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "todolist updated successfully."
      redirect_to(:action => 'show', :id =>  @todolist.id)
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end
  def new
    @todolist = TodoList.new({:name => "todolistname"})
  end
  def create
    # Instantiate a new object using form parameters
    @todolist = TodoList.new(todolist_params)
    # Save the object
    if @todolist.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "TodoList created successfully."
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def delete
      @todolist = TodoList.find(params[:id])
  end
  def destroy
    todolist = TodoList.find(params[:id]).destroy
    flash[:notice] = "TodoList'#{todolist.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  private

    def todolist_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:todolist).permit(:name)
    end

end
