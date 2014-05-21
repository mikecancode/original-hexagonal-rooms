class RedRoom < PuzzleRoom
	
	@@used_words = []
	
	WORD_ARRAY = [ "abacus", "abated", "abbeys", "abbots", "abduct", "abhors",
		"abides", "abject", "ablaze", "ablest", "abloom", "aboard",
	 	"abodes", "abound", "abroad", "abrupt", "abseil", "absent",
	 	"absorb", "absurd", "accent", "accept", "access", "accord",
	 	"accrue", "accuse", "aching", "acidic", "acorns", "acquit", 
	 	"actors", "adapts", "addled", "adhere", "adrift", "adults",
		"ageism" ]	
	
	GALLOWS_ARRAY = ["is empty.", 
		"has a head swinging on it.",
		"has a head and a torso hanging from it.",
		"has a head, a torso, and an arm viewable on it.",
		"is decorated with a head, a torso, and two arms.",
		"is weighed down with a head, a torso, two arms, and a leg.",
		"can barely hold the combined weight of the head, torso, two arms, and two legs that it is now supporting."
		]
	
  def initialize
  	@brightness = 0
  end
  
  def brightness
    @brightness
  end
  
	def color
		"red"
	end
  
  def start_fresh_game
  	@letter_state = [ "_", "_", "_", "_", "_", "_" ]
  	@failed_letters = []
  	@gallows_state = 0
  	@winning_word = WORD_ARRAY.sample
  	while @@used_words.include? @winning_word
  		@winning_word = WORD_ARRAY.sample
  	end
  end
  		
  def puzzle_intro_description
    puts
    puts "You now see six huge CRT monitors floating in front of you, arranged horizontally."
    puts "They are glowing a #{BRIGHTNESS_MAPPING[brightness]} #{color}."
    puts "They each have a single, blinking \"_\" on them."
    puts "To the right appears another, even huger monitor.  There is an image of a gallows on it."
    puts "To the left of the huge monitors appears a smaller monitor.  It is blank."
    puts "This is what you see on the monitors:"
    puts
    puts "Do you want to play?"    
  end

  def play_a_round?(response)
    if @@used_words.size == WORD_ARRAY.size
      win_by_default
    elsif response == "yes"      
  	  result = play
      if result == "win"
        if brightness == 2
  	      puts "..."
          puts "You've won three rounds!  Nice One!"
          puts "That deserves a YURP from the Hangman!"
          puts
          puts "YURP"
  	      puts
  	      return "win", "complete"
        else
          return "win", "incomplete"
        end
      else
        return "lose", "incomplete"
      end
    else
      puts
      puts "OK, see you later."
      puts
      return "no_play"
    end
  end
     
  def win_by_default
		puts
		puts "OK, you've worn this game out and it gives up."
		puts "Nice job playing all the words."
		puts "Though it would have been cool if you got more than 2 of them right."
		puts "Anyway, you \"Win!\" this one.  Congratulations!??!?"
    brightness == 3
    return "win", "complete"
  end  
  
  def play
    start_fresh_game
    @@used_words.push(@winning_word)
  	while @gallows_state < 6
  		show_current_state
  		current_guess = prompt_and_check_legit
  		compare_letters_and_update(current_guess)
  		if all_matched?
  			you_see_description				
  			puts "YOU WIN! Nice job!"; puts
        return "win"
  		end
  	end
  	puts "The gallows " + GALLOWS_ARRAY[@gallows_state]
  	puts "It collapses. YOU LOSE. Sorry, dude."
  end
	
  def show_current_state
  	you_see_description
  	if !@failed_letters.empty?
  		puts "The following letters are floating to the left of the image:"; puts
  		puts @failed_letters.join(" "); puts
  	end
  	puts "To the right of the image is a gallows.  The gallows " + GALLOWS_ARRAY[@gallows_state]
  	puts
  end
		
	def you_see_description
		puts
		puts "You see the following image: " + @letter_state.join(" ")
		puts
	end
    
  def prompt
    puts "Go ahead - have a guess!"
    puts
	  print "> "
    current_guess = gets.chomp.downcase
  end

	def prompt_and_check_legit
		current_guess = prompt
		while current_guess.length != 1 or @failed_letters.include? current_guess or @letter_state.include? current_guess
			if current_guess.length != 1
				puts; puts "One at a time, please!"
			else
				puts; puts "Try something new!"
			end
			current_guess = prompt
		end
		return current_guess
	end

	def winning_word_array
		winning_word_array = @winning_word.split(//)
		return winning_word_array
	end

	def compare_letters_and_update(current_guess)
		winning_word_array
		if !any_matches?(current_guess)
			@gallows_state += 1
			add_to_fails(current_guess)
		else
			update_correct_letters(current_guess)
		end
	end

	def any_matches?(current_guess)
		winning_word_array.any? { | letter | current_guess == letter }
	end

	def all_matched?
		@letter_state == winning_word_array
	end	

	def update_correct_letters(current_guess)
		winning_word_array.each_with_index do | letter, i |
			if current_guess == letter
				@letter_state[i] = letter
			end 
		end
	end	
		
  def add_to_fails(letter)
		if !@failed_letters.include? letter
			@failed_letters.push(letter)
		end
	end
  	  	
end


