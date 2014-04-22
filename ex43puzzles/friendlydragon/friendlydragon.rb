class FriendlyDragon

  @@levels_completed = 2
  
  QUESTIONS = [ "question_1", "question_2", "question_3", 
                "question_4", "question_5", "question_6",
                "question_7", "question_8", "question_9"
              ]
  
  ANSWERS = [ ["answer_1_1", "answer_1_2", "answer_1_3"],                
              ["answer_2_1", "answer_2_2", "answer_2_3"],
              ["answer_3_1", "answer_3_2", "answer_3_3"], 
              ["answer_4_1", "answer_4_2", "answer_4_3"],
              ["answer_5_1", "answer_5_2", "answer_5_3"],
              ["answer_6_1", "answer_6_2", "answer_6_3"],
              ["answer_7_1", "answer_7_2", "answer_7_3"],
              ["answer_8_1", "answer_8_2", "answer_8_3"],
              ["answer_9_1", "answer_9_2", "answer_9_3"]
            ]
              
  DRAGON_QUESTIONS = ["question_1", "question_2", "question_3"]
  
  DRAGON_ANSWERS =  [ ["answer_1_1", "answer_1_2", "answer_1_3"],
                      ["answer_2_1", "answer_2_2", "answer_2_3"],
                      ["answer_3_1", "answer_3_2", "answer_3_3"]
                    ]
  
  def prompt
    puts "Please choose a, b, or c."
    print "> "
    response = gets.chomp.downcase
  end
  
  def play
    (0..2).each do |i|
      (0..@@levels_completed).each do |j|
        if !access_question(i+(3*j))
          return
        end
      end
    end
  end
  
  def access_question(i)
    if ask_question(QUESTIONS[i], ANSWERS[i])
      puts "Well done! You move on."
      return true
    else
      puts "Oh too bad. You get sent back to the beginning."
      return false
    end
  end
 
  def ask_question(question, answers)
    letters = ["a", "b", "c"]
    answers_shuffled = answers.shuffle    
    puts question
    puts "Do you:"
    (0..2).each {|i| puts letters[i] + ": " + answers_shuffled[i]}
    response = nil
    while !response
      response = letters.index(prompt)
    end
    return answers_shuffled[response] == answers[0]
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