class FriendlyDragon

  @@levels_completed = 0
  
  TRAPS = [ "As you start down the tunnel, you hear a whooshing noise behind you.",
                "You continue on.  Suddenly you turn a corner and come to a 10-foot tall brick wall.\nIt is blocking the width of the tunnel.",
                "You carry on, undaunted.  But then around another corner you find yourself at the edge of a cliff.\nThere is a raggedy-looking rope ladder stretching across it.", 
                "trap_4", "trap_5", "trap_6",
                "trap_7", "trap_8", "trap_9"
              ]
  
  CHOICES = [ ["choice_1_1", "choice_1_2", "choice_1_3"],                
              ["choice_2_1", "choice_2_2", "choice_2_3"],
              ["choice_3_1", "choice_3_2", "choice_3_3"], 
              ["choice_4_1", "choice_4_2", "choice_4_3"],
              ["choice_5_1", "choice_5_2", "choice_5_3"],
              ["choice_6_1", "choice_6_2", "choice_6_3"],
              ["choice_7_1", "choice_7_2", "choice_7_3"],
              ["choice_8_1", "choice_8_2", "choice_8_3"],
              ["choice_9_1", "choice_9_2", "choice_9_3"]
            ]
            
  RAMIFICATIONS = [ ["ramification_1_1", "ramification_1_2", "ramification_1_3"],                
                    ["ramification_2_1", "ramification_2_2", "ramification_2_3"],
                    ["ramification_3_1", "ramification_3_2", "ramification_3_3"], 
                    ["ramification_4_1", "ramification_4_2", "ramification_4_3"],
                    ["ramification_5_1", "ramification_5_2", "ramification_5_3"],
                    ["ramification_6_1", "ramification_6_2", "ramification_6_3"],
                    ["ramification_7_1", "ramification_7_2", "ramification_7_3"],
                    ["ramification_8_1", "ramification_8_2", "ramification_8_3"],
                    ["ramification_9_1", "ramification_9_2", "ramification_9_3"]
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
        if !access_trap(i+(3*j))
          return
        end
      end
    end
    end_of_tunnel
  end
  
  def access_trap(i)
    if offer_choices(TRAPS[i], CHOICES[i])
      puts "Well done! You move on."
      true
    else
      puts "Oh too bad. You get sent back to the beginning."
      false
    end
  end
 
  def offer_choices(question, choices)
    letters = ["a", "b", "c"]
    choices_shuffled = choices.shuffle    
    puts question
    puts "Do you:"
    (0..2).each { |i| puts letters[i] + ": " + choices_shuffled[i] + "?" }
    response = nil
    while !response
      response = letters.index(prompt)
    end
    choices_shuffled[response] == choices[0]
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
    else
      dragon_faceoff
    end
  end
  
  def dragon_faceoff
    puts "It's that dragon that's been breathing fire on you and driving you nuts."
    puts "This time he doesn't breathe fire.  He sits down and says \"Let's talk.\""
    right_answers = 0    
    (0..2).each do |i| 
      if offer_choices(DRAGON_QUESTIONS[i], DRAGON_ANSWERS[i])
        puts "Interesting."
        right_answers += 1
      end
    end
    if right_answers == 3
      puts "The dragon looks pensive."
      puts "Then he says \"Hmm....\""
      puts "\"You know what... You're right!\""
      puts "\"Thank you so much for your help!\""
      puts "He turns and walks away slowly.  You can just make out a little spring in his step."
      puts "Nice job!  You've helped the Friendly Dragon!"
      puts "YOU WIN!"
      puts "You turn and walk back to the beginning of the tunnel, head held high."
      "win"
    else
      puts "The dragon thinks for a moment."
      puts "Then he says \"No, I don't like those answers.\""
      puts "\"Come back and try again.\""
      puts "He takes a deep breath, and blows a current of warm air gently of out his nostrils."
      puts "You float back to the beginning of the tunnel as he shouts \"Come back soon....\""
    end
  end
  
end

puts "Do you want to go down the tunnel? (y/n)"
print "> "
response = gets.chomp.downcase
while response == "y"	
	new_round = FriendlyDragon.new
	round = new_round.play
	if round == "win"
		puts
		puts "You've bested the Dragon!  Nice One!"
		puts "That deserves a YURP from the Dragon!"
		puts
		puts "YURP"
		puts
		exit
  else
    puts
	  puts "Do you want to go down the tunnel again?"
	  print "> "
	  response = gets.chomp
  end
end
puts "Ok, see you later."
exit