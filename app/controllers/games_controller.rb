require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = generate_random_letters(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = URI.open(url).read
    result = JSON.parse(response)
    valid_word = result['found']

    if valid_word && check_word(@word, @letters)
      @score = @word.length
    else
      @score = 0
    end
  end

  def generate_random_letters(number)
    letters = []
    number.times do
      letters << ('A'..'Z').to_a.sample
    end
    letters
  end

  def check_word(word, letters)
    word_array = word.upcase.split('')
    word_array.all? { |letter| word_array.count(letter) <= letters.count(letter) }
  end
end
