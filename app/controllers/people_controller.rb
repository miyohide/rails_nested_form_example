class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.create(person_params)
    if @person.save
      redirect_to @person, notice: "#{@person.last_name} #{@person.first_name}を作成しました"
    else
      render 'new'
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to @person, notice: "#{@person.last_name} #{@person.first_name}を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to people_path, notice: "#{@person.last_name} #{@person.first_name}を削除しました"
  end

  private
  def person_params
    params.require(:person).permit(:first_name, :last_name, addresses_attributes: [:id, :kind, :street, :_destroy])
  end
end
