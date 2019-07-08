class GamesController < ApplicationController
  
  def new
    @letters= ("A".."Z").map{|letter| letter}.sample(10)
  end

  def score

    word = params[:word]
    letters = params[:letters].split(' ')
    
    english?(word) ? valid?(letters, word) : @score = "Sorry but #{word} doesn't seems to be a valid English word"
  end

  def english?(word)
    uri = URI("https://wagon-dictionary.herokuapp.com/#{word}")
    response = Net::HTTP.get(uri)
    json = JSON(response)
    json["found"]
  end

  def valid?(letters, word)
    word.split('').each do |letter|
      if !letters.include? letter.upcase
        @score = "Sorry but #{word} can't be built out of #{letters}"
      else
        @score = "CONGRATULATIONS, #{word} is a valid English word!"
      end
    end
  end

end
