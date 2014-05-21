class GreenRoom < PuzzleRoom

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
                              "You're in luck!  There's a long stick right next to the wall.\nOnly one problem.  You can't pole vault.  You smack into the wall." ],
                            [ "look for a foothold and start using those rock climbing skills?",
                              "You give it a try.  Wait a minute, what rock climbing skills?\nYou fall down over and over until you can't stand it anymore." ]
                          ],
                          [ [ "carefully and slowly make your way across the bridge, making sure to disturb it as little as possible",
                              "Of course you do!  It's the only sensible choice.\nYou make it across to the other side just fine."],
                            [ "take a deep breath and sprint across the bridge as fast as you can",
                              "Nice try, genius.  You break one of the slats in the bridge almost instantly.\nAnd turn around and run right back where you came from." ],
                            [ "step to the side of the ladder, take out a bunch of gold and throw it into the abyss",
                              "Who do you think you are, Indiana Jones?  Way to lose a bunch of gold into an abyss.\nMaybe, um, using the bridge would have worked!" ]
                          ],
                          [ [ "press yourself to the side of the left wall of the tunnel",
                              "This sort of wimpy response seems to work!  Something whooshy comes whooshing past.\nBest not to worry about what it was." ],
                            [ "duck and roll forward as quickly as possible",
                              "Seems like a good strategy.  But isn't.\nYou roll right into a pile of nasty slime.  Time to go clean up." ],
                            [ "press yourself to the side of the right wall of the tunnel",
                              "Oh man you picked the wrong pressing side.\nYou get severely slimed by a ghostie-type thing.  Time to go clean up." ]
                          ],
                          [ [ "examine this wall very carefully",
                              "You follow the wall all the way to the edge and notice that it doesn't quite reach the tunnel wall!\nYou can squeeze right through!" ],
                            [ "try to climb this one; after all, you have climbed iron before",
                              "No dice, dude.  Why do you keep thinking you can climb walls?\nYou have climbed an iron fire escape before, not a sheer wall!" ],
                            [ "dig your way underneath the wall with the handy shovel you see nearby",
                              "Good effort for sure, and you dig a sizeable hole.\nOut of which crawls a giant possum.  You turn and run as fast as you can." ]
                          ],
                          [ [ "dig a hole really quickly with the handy shovel that you've just found, and crawl into the hole just before the boulder gets to you",
                              "Wow, that actually worked!\nYou emerge a little battered and bruised and dirty, but you've survived a boulder attack." ],
                            [ "turn and run from the boulder, just outracing it to the mouth of the tunnel",
                              "Well done, Indiana Jones.  Only problem: you just ended up back where you started!\nYou turn around and start back into the tunnel." ],
                            [ "press against either side of the wall and hope you'll fit",
                              "Nope, you don't fit.  You get the wind knocked out of you and then some." ]
                          ],
                          [ [ "shout \"OK, what is it with all of these weird noises in my ears anyway!!?!\"",
                              "\"Fine, I'll leave you alone\" says the ghostly voice sheepishly.\n\"I just get so bored in this tunnel is all.\"  Then it vanishes." ],
                            [ "quietly ask the ghostly voice to please go away",
                              "\"Don't try and be all polite with me!\" says the ghostly voice.\n\"I am a scary ghostly voice!\"  You suddenly get pretty scared." ],
                            [ "quietly ask the ghostly voice to tell you what it wants",
                              "\"Don't try and ask me what I want!\" says the ghostly voice.\n\"I am a scary ghostly voice!\"  You suddenly get pretty scared." ]
                          ],
                          [ [ "pace in circles",
                              "You start pacing just to think, but then you accidentally step on a button.\nSlowly the pit's floor rises back up to ground level." ],
                            [ "climb the vines that you see conveniently hanging down into the pit",
                              "The vines are strong.  Unfortunately, you get a bit carried away.\nYou climb to the ceiling, bump your head, and fall to the floor." ],
                            [ "jump up and down on the convenient trampoline you see in the pit",
                              "It works pretty well!  Unfortunately, you get a bit carried away.\nYou bounce to the ceiling, bump your head, and fall to the floor." ]
                          ],
                          [ [ "look at the altar for a bit, then keep moving",
                              "Good call!  As you're about to find out, the dragon doesn't have much loot left these days. \nDon't touch his stuff." ],
                            [ "drink the liquid in the plainest cup",
                              "What?  Why are you drinking random liquid in a creepy tunnel?\nYou feel really sick, and pass out almost immediately." ],
                            [ "dump out the liquid in the fanciest cup, then put the cup in your satchel",
                              "You hear a booming voice shout \"Don't touch my STUFF!!!\"\nYeah, you really should be careful about taking shiny stuff near a dragon." ]
                          ]
                        ]
  
  DRAGON_QUESTIONS =  [ "\"First, I have no idea how to make friends.\"\n\"I'm really lonely in this cave but everyone is scared of me.\"\n\"What do you think?\"",
                        "\"Secondly, I keep losing my treasure.\"\n\"I don't know who can possibly be taking it from me.\"\n\"Any thoughts?\"",
                        "\"Finally, do you think it's possible for a dragon to find love in this crazy world?\""
                      ]
  
  DRAGON_ANSWERS =  [ [ [ "answer \"Honestly, you could just lessen the number of booby traps in this place\"", nil ],
                        [ "answer \"I don't know how dragons make friends.  Maybe you could look online\"", nil ],
                        [ "answer \"Why wouldn't they be scared of you?  You're a scary dragon\"", nil ]
                      ],
                      [ [ "answer \"I think this one's easy.  You keep leaving it out on altars.  Hide it away somewhere!\"", nil ],
                        [ "answer \"I don't know about any lost treasure, but I can sell you this cool cup I have in my satchel\"", nil ],
                        [ "answer \"Hmm. Maybe you just need to look in the Dragon Want Ads to see if someone is selling your stuff\"", nil ]
                      ],
                      [ [ "answer \"Of course it is!  But probably only with another dragon\"", nil ],
                        [ "answer \"Man, that's a tough one.  Probably, but maybe not\"", nil ],
                        [ "answer \"Not with all these booby traps you're packing\"", nil ]
                      ]
                    ]

	def initialize
		@brightness = 0
	end

  def brightness
    @brightness
  end

	def color
		"green"
	end
  
  def puzzle_intro_description
    puts
    puts "The vacuum tubes, cables and old CRT monitors, among other things, form the shape of a dragon."
    puts "The dragon is glowing a #{BRIGHTNESS_MAPPING[brightness]} #{color}."
    puts "Suddenly they shift and move again, and part to form a hole."
    puts "You peer in the hole and it looks like you can see the beginning of a tunnel."
    puts "The tunnel is also glowing a #{BRIGHTNESS_MAPPING[brightness]} #{color}."
    puts
    puts "So do you go down the tunnel?"
  end
  
  def play_a_round?(response)
     if response == "yes"	
       result = play
  	   if result == "win"
         if brightness == 2
           puts
  		     puts "You've bested the Dragon!  Nice One!"
  		     puts "That deserves a ROAR from the Dragon!"
  		     puts
  	       puts "ROAR"
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
  
  def prompt
    puts
    puts "Please choose a, b, or c."
    print "> "
    response = gets.chomp.downcase
  end
  
  def play
    (0..2).each do |i|
      (0..brightness).each do |j|
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
    puts
    puts question
    puts
    puts "Do you:"
    (0..2).each { |i| puts letters[i] + ": " + choices_and_results_shuffled[i][0] + "?" }
    response = nil
    while !response
      response = letters.index(prompt)
    end
    puts
    puts choices_and_results_shuffled[response][1]
    choices_and_results_shuffled[response] == choices_and_results[0]
  end
    
  def prompt
    puts
    puts "Please choose a, b, or c."
    puts
    print "> "
    response = gets.chomp.downcase
  end
  
  def end_of_tunnel
    puts
    puts "You reach the end of the tunnel and see a DRAGON."
    if brightness < 2
      puts "He goes ROAR and breathes fire and blows you back to the beginning."
      "win"
    else
      dragon_faceoff
    end
  end
  
  def dragon_faceoff
    puts
    puts "It's that dragon that's been breathing fire on you and driving you nuts."
    puts "This time he doesn't breathe fire.  He sits down and says \"Let's talk.\""
    puts "\"You've come through the tunnel three times and beat all of my challenges.\""
    puts "\"I'm betting you're a pretty smart guy.\""
    puts "\"I have three questions that have been vexing me for the longest time.\""
    puts "\"Any chance you could help me with them?\""
    puts "You nod yes.  Not being in a position to do much else."
    puts "This is a giant fire-breathing dragon after all."
    puts "\"OK\" says the dragon.  \"So here are my questions.\""
    right_answers = 0    
    (0..2).each do |i| 
      if choices_and_result(DRAGON_QUESTIONS[i], DRAGON_ANSWERS[i])
        puts "The dragon pauses, tilts his head, then says \"Interesting.\""
        right_answers += 1
      end
    end
    if right_answers == 3
      puts
      puts "The dragon looks pensive."
      puts "Then he says \"Hmm....\""
      puts "\"You know what... You're right!\""
      puts "\"Thank you so much for your help!\""
      puts "He turns and walks away slowly.  You can just make out a little spring in his step."
      puts "Nice job!  You've helped the Friendly Dragon!"
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