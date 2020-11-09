require 'json'
require 'open-uri'
require 'date'

class GamesController < ApplicationController

  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    web_page = open(url).read
    @result = JSON.parse(web_page)
    word = params[:word].upcase.split("")
    letters = params[:letters].split
    grid_check = word.all? { |char| word.count { |el| el == char } <= letters.count { |el| el == char.upcase }  }
    if params[:word].upcase.split("") - letters == [] && grid_check
      if @result["found"]
        @result[:score] = 2 * params[:word].length
        @result[:message] = "Well done"
      else

        @result[:score] = 0
        @result[:message] = "That's not an english word"
      end
  else
    @result[:score] = 0
    @result[:message] = "That's not in the grid"
  end
  return @result
end
end
  

