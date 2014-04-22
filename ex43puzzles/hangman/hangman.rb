class HangmanRound

	@@used_words = []
	@@wins_total = 0
	
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
		@letter_state = [ "_", "_", "_", "_", "_", "_" ]
		@failed_letters = []
		@gallows_state = 0
		if @@used_words.size == WORD_ARRAY.size
			puts
			puts "OK, you've worn this game out and it gives up."
			puts "Nice job playing all the words."
			puts "Though it would have been nice if you got more than 2 of them right."
			puts "Anyway, you \"Win!\" this one.  Congratulations!??!?"
			exit
		else
		end
		@winning_word = WORD_ARRAY.sample
		while @@used_words.include? @winning_word
			@winning_word = WORD_ARRAY.sample
		end
	end
	
	def play

		@@used_words.push(@winning_word)
		while @gallows_state != 6
			show_current_state
			current_guess = prompt_and_check_legit
			compare_letters_and_update(current_guess)
			if all_matched?
				you_see_descrip				
				puts "YOU WIN! Nice job!"
				puts
				@@wins_total += 1
				if @@wins_total == 1
					puts "You've now won #{@@wins_total} round! Getting closer!"
				else
					puts "You've now won #{@@wins_total} rounds! Getting closer!"
				end
				return @@wins_total
			end
		end
		puts
		puts "The gallows " + GALLOWS_ARRAY[@gallows_state]
		puts
		puts "It collapses. YOU LOSE. Sorry, dude."
		puts
	end
	
	def show_current_state
#		puts @winning_word
#		print @@used_words
		you_see_descrip
		if !@failed_letters.empty?
			puts "The following letters are floating to the left of the image:"
			puts
			puts @failed_letters.join(" ")
			puts
			puts
		end
		puts "To the right of the image is a gallows.  The gallows " + GALLOWS_ARRAY[@gallows_state]
		puts
	end
	
	def you_see_descrip
		puts
		puts "You see the following image: " + @letter_state.join(" ")
		puts
	end

	def prompt_and_check_legit
		prompt
		current_guess = gets.chomp.downcase
		while current_guess.length != 1 or @failed_letters.include? current_guess or @letter_state.include? current_guess
			if current_guess.length != 1
				puts
				puts "One at a time, please!"
			else
				puts
				puts "Try something new!"
			end
			prompt
			current_guess = gets.chomp.downcase
		end
		return current_guess
	end

	def prompt
		puts "Go ahead - have a guess!"
		print "> "
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
		winning_word_array.any? { | letter |		
			current_guess == letter }
	end

	def all_matched?
		@letter_state == winning_word_array
	end	

	def update_correct_letters(current_guess)
		winning_word_array.each_with_index do | letter, i |
			if current_guess == letter
				@letter_state[i] = letter
			else
			end 
		end
	end	
		
	def add_to_fails(letter)
		if !@failed_letters.include? letter
			@failed_letters.push(letter)
		end
	end
	
end

puts "Do you want to play? (y/n)"
print "> "
response = gets.chomp.downcase
while response == "y"	
	new_game = HangmanRound.new
	round = new_game.play
	if round == 3
		puts
		puts "You've won three rounds!  Nice One!"
		puts "That deserves a YURP from the Hangman!"
		puts
		puts "YURP"
		puts
		exit
	end
	puts
	puts "Do you want to play again?"
	print "> "
	response = gets.chomp
end
puts "Ok, see you later."
exit