class PartyTypesController < ApplicationController
before_filter :login_required
  def index
    @party_types = PartyType.all
  end

  def show
    @party_type = PartyType.find(params[:id])
  end

  def new
    @party_type = PartyType.new
  end

  def create
    @party_type = PartyType.new(params[:party_type])
    if @party_type.save
      flash[:notice] = "Successfully created party type."
      redirect_to @party_type
    else
      render :action => 'new'
    end
  end

  def edit
    @party_type = PartyType.find(params[:id])
  end

  def update
    @party_type = PartyType.find(params[:id])
    if @party_type.update_attributes(params[:party_type])
      flash[:notice] = "Successfully updated party type."
      redirect_to party_type_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @party_type = PartyType.find(params[:id])
    @party_type.destroy
    flash[:notice] = "Successfully destroyed party type."
    redirect_to party_types_url
  end
end
