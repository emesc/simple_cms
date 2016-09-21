class SubjectsController < ApplicationController

  layout false

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({name: "Default"})
  end

  def create
    # instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # save the object
    if @subject.save
      # if save succeeds, redirect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to(action: 'show')
    else
      # if save fails, redisplay the form so the user can fix the problems
      render 'new'
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # find an existing object using form parameters
    @subject = Subject.find(params[:id])
    # update the object; update_attributes returns true
    if @subject.update_attributes(subject_params)
      # if update succeeds,
      flash[:notice] = "Subject updated successfully."
      redirect_to(action: 'show', id: @subject.id)
    else
      render 'edit'
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    # the action will never display a template so normal variable can be used; tho at this stage, it's unnecessary
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to(action:'index')
  end

  private

    def subject_params
      params.require(:subject).permit(:name, :position, :visible)
    end
end
