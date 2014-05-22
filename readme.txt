The Original Hexagonal Rooms

This is a puzzle game masquerading as a text adventure game.  Part of the game is figuring your way around the rooms.  Then there are puzzles to play in each of them.

This project came out of an exercise in Learn Ruby The Hard Way.  I am learning Ruby via building this project, among other things.

To run it, collect all ten .rb files from the main directory into one directory, and type "ruby engine.rb."

The most recent updates are as follows:

(5/22/14)

- Moved all initialize and brightness functions out of the color room classes and into the PuzzleRoom class to avoid repetition.
- Moved SOME of the prompt functions out of their color room classes into the PuzzleRoom class - some of them are unique to their games so did not move those.

(5/21/14)
- Cleaned up the directory, including renaming the files more clearly and getting rid of unnecessary files.
- Tested the game some more.

(5/20/14)
- Couple of fixes:
- In the orange room (memory game), I removed the requirement of typing "y" after every move which really slowed the game down.
- In the blue room (battleships game), I changed the code so that if the user has 1 turn left, it indicates that as "1 turn" not "1 turns."
- Most importantly, the game was not winnable!  After you finished all six puzzles, it didn't go to the boss battle.  This has been fixed.
- Finally, the boss battle was rewritten for (I think) better gameplay and a better "final battle" / game end experience.

(5/19/14)
- 1st draft of game completed!
- Final boss battle written and integrated into game using "exit" when player wins - will probably change that.

(5/17/14)
- Battleships refactored into a generalizeable game, added to blue room.
- TicTacToe written, running fine but will need some refactoring, added to purple room.

(4/27/14)
- Battleships minor bug fixed.  Fully playable now as a standalone.
- Added constraint on number of guesses to battleships.
- Began refactoring battleships.

(4/26/14)
- Battleships made playable with at least one minor bug.  Need to fix the bug and test a bit more, then ready for more refactoring.
- Documentation and file management.

(4/25/14)
- Further work on battleships.rb - it is not complete but mostly runs.  It needs much more testing and bug-fixing, and then will need much more refactoring.
- Began battleships.rb standalone and saved the early refactoring.

(4/24/14)
- Tested friendlydragon.rb and made the appropriate fixes
- Added shortcut functionality for choosing colors and directions - "r" now translates to "red," "f" to "forward," etc.
- Made adjustments to allow the door to the hubroom to stay open from the view of a color room if the color's puzzles solved, and to allow for entry to the hubroom.

(4/23/14)
- Extensive refactoring of ex43orangeroom.rb, which contains the memory game, to both improve the code in general and allow for a 4x4 grid instead of 6x6.
- Finished friendlydragon.rb and integrated it into the ex43greenroom.rb code.
- Sorted out the hints for anagrams.rb and integrated them into the ex43yellowroom.rb code as well.
- I also looked at the spacing of the game's text in general, which was getting pretty crowded to read as you played, and added a bunch of "puts" lines to the following files: ex43redroom.rb, ex43orangeroom.rb, ex43yellowroom.rb, ex43puzzleroom.rb, and ex43engine.rb, to give the text more "breathing room" as you play.  This is just the beginning of this particular aspect of the game design, but I wanted to get started on it and I think it makes play a lot less frustrating.

The current next set of tasks for the overall game remains the same as yesterday:

1) Clean up the indenting in all files.
2) Deal with the giant stacktrace problem that happens when you quit out of the game.
3) Look the code over for more errors / refactoring possibilities.

That's it for now....