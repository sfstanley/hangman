class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end


  def initialize(new_word)
  	@word = new_word.downcase
  	@guesses = ''
  	@wrong_guesses = ''
  end

  def guess(new_guess)
    new_guess = new_guess.downcase
  	if new_guess == nil or not new_guess =~ /^[a-z]+$/i or new_guess.empty?
  		raise ArgumentError
  	elsif not @guesses.include? new_guess and not @wrong_guesses.include? new_guess
	  	if @word.include? new_guess
	  		@guesses = @guesses + new_guess
	  	else
	  		@wrong_guesses = @wrong_guesses + new_guess
	  	end
	  else
		  return false
	  end
  end

  def word_with_guesses
  	if guesses.empty?
  		return word.gsub(/[a-z]/, '-')
  	end
  	reg = Regexp.new '[^' + guesses + ']'
  	return word.gsub(reg, '-')
  end

  def check_win_or_lose
  	if wrong_guesses.length >= 7
  		return :lose
  	elsif word_with_guesses == word
  		return :win
  	else
  		return :play
  	end
  end


  
end
