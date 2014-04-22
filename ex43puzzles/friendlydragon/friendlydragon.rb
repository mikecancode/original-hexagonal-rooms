class FriendlyDragon

  @@levels_completed = 0
  
  QUESTIONS = [ "question_1", "question_2", "question_3", 
                "question_4", "question_5", "question_6",
                "question_7", "question_8", "question_9"
              ]
  
  ANSWERS_1 = ["answer_1_1", "answer_1_2", "answer_1_3"]                
  ANSWERS_2 = ["answer_2_1", "answer_2_2", "answer_2_3"]                
  ANSWERS_3 = ["answer_3_1", "answer_3_2", "answer_3_3"]                
  ANSWERS_4 = ["answer_4_1", "answer_4_2", "answer_4_3"]                
  ANSWERS_5 = ["answer_5_1", "answer_5_2", "answer_5_3"]                
  ANSWERS_6 = ["answer_6_1", "answer_6_2", "answer_6_3"]                
  ANSWERS_7 = ["answer_7_1", "answer_7_2", "answer_7_3"]                
  ANSWERS_8 = ["answer_8_1", "answer_8_2", "answer_8_3"]                
  ANSWERS_9 = ["answer_9_1", "answer_9_2", "answer_9_3"]
  
  ANSWERS = [ ANSWERS_1, ANSWERS_2, ANSWERS_3,
              ANSWERS_4, ANSWERS_5, ANSWERS_6,
              ANSWERS_9, ANSWERS_8, ANSWERS_9
            ] 
  
  DRAGON_QUESTIONS = ["question_1", "question_2", "question_3"]
  
  DRAGON_ANSWERS_1 = ["answer_1_1", "answer_1_2", "answer_1_3"] 
  DRAGON_ANSWERS_2 = ["answer_2_1", "answer_2_2", "answer_2_3"]
  DRAGON_ANSWERS_3 = ["answer_3_1", "answer_3_2", "answer_3_3"]
  
  def prompt
    puts "Please choose a, b, or c."
    print "> "
    response = gets.chomp.downcase
  end
  
  def play
    response = true
    (0..2).each do |i|
      (0..@@levels_completed).each do |j|                  
        unless access_question(i)
          break
        end
        if j == 1 
          unless access_question(i+3)
            break
          end
        end
        if j == 2
          unless access_question(i+6)
            break
          end
        end
      end
    end
    puts "Oh too bad. You get sent back to the beginning."
  end
  
  def access_question(i)
    response = ask_question(QUESTIONS[i], ANSWERS[i])
    if response
      puts "Well done! You move on."
      return true
    end
  end
 
  def ask_question(question, answers)
    letters = ["a", "b", "c"]
    answers_shuffled = answers.shuffle    
    puts question
    puts "Do you:"
    (0..2).each {|i| puts letters[i] + ": " + answers_shuffled[i]}
    response = letters.index(prompt)
    while response == nil
      response = letters.index(prompt)
    end
    if answers_shuffled[response] == answers[0]
      return true
    end
  end
  
  def prompt
    puts "Please choose a, b, or c."
    print "> "
    response = gets.chomp.downcase
  end
  
  def end_of_tunnel
    puts "You reach the end of the tunnel and see a DRAGON."
    if @@levels_completed < 2
      puts "He goes ROAR and breathes fire and blows you back to the beginning."
      @@levels_completed += 1
      win_round_but_not_game
    else
      dragon_faceoff
    end
  end
  
  def lose_round
    puts "Please try again some other time."
  end

  def dragon_faceoff
    puts "You see that dragon that's been driving you nuts again."
    puts "This time he doesn't breathe fire.  He sits down and says \"Let's talk.\""
    right_answers = 0    
    (0.2).each do |i| 
      (0.2).each do |j|
        dragon_answers_ = DRAGON[i][j].delete_at(0)
        response = answer_question(DRAGON[i][0], dragon_answers)
        if DRAGON[i][j][response] + 1 == j
          puts "Interesting."
          right_answers += 1
        end
      end
    end
    if right_answers == 3
      puts "you win!"
    else
      lose_round
    end
  end
  
end

puts "Do you want to go down the tunnel? (y/n)"
print "> "
response = gets.chomp.downcase
while response == "y"	
	new_round = FriendlyDragon.new
	round = new_round.play
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