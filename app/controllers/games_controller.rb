require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << Array('A'..'Z').sample(1)[0] }
  end

  def score
    good = true
    @word = params[:word].upcase.chars
    @letters = params[:letters].split("")
    @word.each do |letter|
      good = false if @word.count(letter) > @letters.count(letter)
    end
    if good == true && JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)['found'] == true
      @answer = 'good'
    elsif good == true && JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)['found'] == false
      @answer = 'not english'
    elsif good == false
      @answer = 'not on the grid'
    end
  end
end
