class FriendlyDragon

  @@levels_completed = 0
  
  TRAPS = [ "As you start down the tunnel, you hear a whispering noise behind you.",
            "You continue on.  Suddenly you turn a corner and come to a 10-foot tall brick wall.\nIt is blocking the width of the tunnel.",
            "You carry on.  Around another bend you find yourself at the top of a cliff.\nThere is an old, raggedy rope bridge stretching from the edge into darkness.",
            "Further on down the tunnel, you hear a whooshing noise come out of nowhere.",
            "You feel pretty good about how you dealt with that wall, and press on.\nAnd almost miss the 20-foot iron wall that drops from the ceiling.",
            "The tunnel starts to slope upwards.  Suddenly you hear a rumbling in the distance.\nYou look ahead and see a massive boulder rolling right towards you.",
            "A little further on, you suddenly feel a cold wind blowing in your face.\nYou hear a ghostly voice murmuring in your ear.",
            "Determined not to be caught off-guard again, you look ahead for more walls.\nAnd promptly fall into the 30-foot deep pit that opens up at your feet.",
            "Up ahead is something you appear to have missed in your earlier travels through this tunnel: a small alter with three cups of some liquid on it."
          ]
  
  CHOICES_AND_RESULTS = [ [ [ "tilt your head to the side and bang your temple with the heel of your hand",
                              "Some water finally comes out.  That's what that whispering sound was all of those years!" ],
                            [ "turn around and shout \"Who whispers there?  I can hear you!  Show yourself!\"",
                              "You wake up a whole mess of possums who have been lightly snoring.\nThey start coming for you.  They are snarling." ],
                            [ "keep walking, as quietly as you possibly can, hoping the scary noise will go away",
                              "It doesn't go away, but gets louder.  Suddenly you realize you are surrounded by lightly snoring sleeping possums.\nYou hate possums!" ]
                          ],
                          [ [ "shout \"Oh come on, Montresor!\"",
                              "A brick slides out, and then another, until there's a big enough hole to fit through.\nYou can now see a creepy guy with a trowel." ],
                            [ "look for a nearby pole and vault over the wall",
                              "You're in luck!  There's a long stick right next to the wall.\nOnly one problem.  Ypu can't pole vault.  You smack into the wall." ],
                            [ "look for a foothold and start using those rock climbing skills?",
                              "You give it a try.  Wait a minute, what rock climbing skills?  You fall down over and over until you can't stand it anymore." ]
                          ],
                          [ [ "carefully and slowly make your way across the bridge, making sure to disturb it as little as possible",
                              "Of course you do!  It's the only sensible choice.\nYou make it across to the other side just fine."],
                            [ "take a deep breath and sprint across the bridge as fast as you can",
                              "Nice try, genius.  You break one of the slats in the bridge almost instantly.\nAnd turn around and run right back where you came from." ],
                            [ "step to the side of the ladder, take out a bunch of gold and throw it into the abyss",
                              "Who do you think you are, Indiana Jones?  Way to lose a bunch of gold into an abyss.\nYou think the bridge could have been your move?" ]
                          ],
                          [ [ "press yourself to the side of the left wall of the tunnel",
                              "This sort of wimpy response seems to work!  Something whooshy comes whooshing past.\nBest not to worry about what it was." ],
                            [ "duck and roll forward as quickly as possible",
                              "Seems like a good strategy.  But isn't.  \n You roll right into a pile of nasty slime.  Time to go clean up." ],
                            [ "press yourself to the side of the right wall of the tunnel",
                              "Oh man you picked the wrong pressing side.\nYou get severely slimed by a ghostie-type thing.  Time to go clean up." ]
                          ],
                          [ [ "examine this wall very carefully",
                              "You follow the wall all the way to the edge and notice that it doesn't quite reach the tunnel wall!\nYou can squeeze right through!" ],
                            [ "try to climb this one; after all, you have climbed iron before",
                              "No dice, dude.  Why do you keep thinking you can climb walls?\nYou have climbed an iron fire escape, not a sheer wall!" ],
                            [ "dig your way underneath the wall with the handy shovel you see nearby",
                              "Good effort for sure, and you dig a sizeable hole.\nOut of which crawls a giant possum.  You turn and run as fast as you can." ]
                          ],
                          [ [ "choice_1_1",
                              "result 1_1" ],
                            [ "turn and run from the boulder, just outracing it to the mouth of the tunnel",
                              "Right." ],
                            [ "choice_1_3",
                              "result 1_3" ]
                          ],
                          [ [ "choice_1_1",
                              "result 1_1" ],
                            [ "choice_1_2",
                              "result 1_2" ],
                            [ "choice_1_3",
                              "result 1_3" ]
                          ],
                          [ [ "choice_1_1",
                              "result 1_1" ],
                            [ "choice_1_2",
                              "result 1_2" ],
                            [ "choice_1_3",
                              "result 1_3" ]
                          ],
                          [ [ "choice_1_1",
                              "result 1_1" ],
                            [ "choice_1_2",
                              "result 1_2" ],
                            [ "choice_1_3",
                              "result 1_3" ]
                          ]
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
    if choices_and_result(TRAPS[i], CHOICES_AND_RESULTS[i])
      puts "Well done! You move on."
      true
    else
      puts "Oh, too bad. You have chosen poorly.\nA mysterious force whisks you back to the beginning of the tunnel before you can say \"Corn-doggit\"."
      false
    end
  end
 
  def choices_and_result(question, choices_and_results)
    letters = ["a", "b", "c"]
    choices_and_results_shuffled = choices_and_results.shuffle    
    puts; puts question
    puts; puts "Do you:"
    (0..2).each { |i| puts letters[i] + ": " + choices_and_results_shuffled[i][0] + "?" }
    response = nil
    while !response
      response = letters.index(prompt)
    end
    puts choices_and_results_shuffled[response][1]
    choices_and_results_shuffled[response] == choices_and_results[0]
  end
    
  def prompt
    puts; puts "Please choose a, b, or c."
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
    puts
    puts "It's that dragon that's been breathing fire on you and driving you nuts."
    puts "This time he doesn't breathe fire.  He sits down and says \"Let's talk.\""
    right_answers = 0    
    (0..2).each do |i| 
      if choices_and_result(DRAGON_QUESTIONS[i], DRAGON_ANSWERS[i])
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