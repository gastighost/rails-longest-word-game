require 'open-uri'
require 'json'

class GamesController < ApplicationController
  LETTERS = ('a'..'z').to_a.sample(10)

  def new
    @letters = LETTERS
  end

  def score
    @letters = LETTERS
    @answer = params[:score]
    @is_letters = check_letters(@letters, @answer)
    @is_english = check_english(@answer)
  end

  private

  def check_letters(rand, word)
    word.chars.all? { |letter| word.count(letter) <= rand.count(letter) }
  end

  def check_english(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
