class UrlsController < ApplicationController

  def index
    @urls = Url.all
  end

  def show
    url = Url.where(random_id: params[:id]).first

    if url
      redirect_to url.original
    else
      render 'new'
    end
  end

  def new
    @url = Url.new

    letters = [('a'..'z'), ('A'..'Z')].map { |l| l.to_a }.flatten
    @url.random_id = (0...8).map { letters[rand(letters.length)] }.join
  end

  def url_params

    params.require(:url).permit(:original, :random_id)
  end

  def create
    @url = Url.new(url_params)
   
    if @url.save
      redirect_to urls_path
    else
      render 'new'
    end
  end

end