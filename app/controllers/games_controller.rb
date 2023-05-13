require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    # .foreach do |alphabet|
    # @letters += alphabet
  end

  def score

    # On initialise le score :
    ### Soit le joueur a dejà commencé, du coup, le score aura la valeur de la session
    ### Soit il débute la partie, le score = 0
    # @score = session[:score] || 0

    @score = session[:score] || 0
    @answer = params[:answer]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    if json['found'] == true

      @valideword = "Congratulation! #{@answer} is a valid English word"
      # 1 - On incrémente le score avec la valeur du nombre des mots que l'user à saisi
      @score += json['length'].to_i
      # 2 - On stocke dans la session le score
      session[:score] = @score
    else
      @valideword = "Sorry but #{@answer} doesn't seem to be a valid English word..."
    end

  end

end
