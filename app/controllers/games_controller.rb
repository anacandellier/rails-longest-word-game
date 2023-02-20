require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << Array('A'..'Z').sample(1)[0] }
  end

  def score
    @score = 0
    good = true
    @word = params[:word].upcase.chars
    @letters = params[:letters].split("")
    @word.each do |letter|
      good = false if @word.count(letter) > @letters.count(letter)
    end
    if good == true && JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)['found'] == true
      @answer = 'good'
      @score = @word.size
      session[:score] += @score
      @total_score = session[:score]
    elsif good == true && JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)['found'] == false
      @answer = 'not english'
      @total_score = session[:score]
    elsif good == false
      @answer = 'not on the grid'
      @total_score = session[:score]
    end
  end
end
