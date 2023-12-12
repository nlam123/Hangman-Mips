# Authors: Omar Cruz, Nathan Lam, Henry Tat, Emily Tran, Sanat Vankayalapati
# hangman.asm -- A hangman game program.
# $s0 - player lives

.data
# Game Title
title: .asciiz "\ _                                             \n| |                                            \n| |__   __ _ _ __   __ _ _ __ ___   __ _ _ __  \n|  _ \\ / _  |  _ \\ / _  |  _   _ \\ / _  |  _ \\ \n| | | | (_| | | | | (_| | | | | | | (_| | | | |\n|_| |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|\n                    __/ |                      \n                   |___/    \n"

# Stages
stage1: .asciiz "\n +---+\n |    |\n      |\n      |\n      |\n      |\n=========\n"
stage2: .asciiz "\n  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n========="
stage3: .asciiz"\n  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========\n"
stage4: .asciiz"\n  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n=========\n"
stage5: .asciiz"\n  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========\n"
stage6: .asciiz"\n  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n=========\n"
stage7: .asciiz"\n  +---+\n  |   |\n  O   |\n /|\\  |\n / \\  |\n      |\n=========\n"

# Word bank
theme: .asciiz "\nThe theme of the word is food. \n"
word0: .asciiz "pizza"
word1: .asciiz "cheeseburger"
word2: .asciiz "sushi"
word3: .asciiz "taco"
word4: .asciiz "pasta"
word5: .asciiz "barbecue"
word6: .asciiz "crepes"
word7: .asciiz "salad"
word8: .asciiz "eggs"
word9: .asciiz "steak"
word10: .asciiz "potato"
word11: .asciiz "sandwich"
word12: .asciiz "noodle"
word13: .asciiz "spaghetti"
word14: .asciiz "lasagna"
word15: .asciiz "rice"
word16: .asciiz "bacon"
word17: .asciiz "porkchop"
word18: .asciiz "bean"
word19: .asciiz "fish"
word20: .asciiz "popcorn"
word21: .asciiz "pancake"
wordList: .word word0, word1, word2, word3, word4, word5, word6, word7, word8, word9, word10, word11, word12, word13, word14, word15, word16, word17, word18, word19, word20, word21
wordCount: .word 22

# Win/Lose message
jarfix: .asciiz "\n                    %%%                          \n                    @%##%                        \n                   @@%%###%                      \n                   @%%%####%%                    \n                  @@%%%%####%%%                  \n                 @@%%%%######%%%                 \n                 @%%%*++++++*%%%%                \n               @@%%%#*+++++++*%%%%               \n       **+++**%@@%%%%#********#%%%@              \n      ++++++**+=--=@%%%#######+...-#%   %#%      \n   %#*:===+++=-=--=#@@@%%%%%%@:. ..*%%  @@@      \n @%%=:---:::.::::=+#%@@@@@@@#-..  .:@%% @%%      \n @%%##+-:....:.:.=+*#%%%%%%*-..   ..*@%@%%#%     \n@@%#:=#*-:::::::.===+****+=:...   ..=@@@@%%%     \n @@#-:---:::-:::.----==---:..     ..=*@@@@@@     \n @@@%+---:::::::.------:::...     ..=*  @@@      \n  @@+-::::::-:::.-----:::.......  ..=*%          \n  @%-:------=-:::+==-----::::.......-+#          \n @@@@@@%####*****+++++=====---:::...-+*          \n @@@@@@@@@@@#***########****++=--:::-+#          \n @@@@@@@@@@@@#**##%%%%@@@%%%##*+=---=*@          \n    @@@@@@@@@@@%%%@@@@@@@@@@@%%#*+=+#@@@@        \n              @@@@@@@@@@@@@@@@@@@@@@@            \n                                                  \n"
nooo: .asciiz "\n====                                                    =====   \n===+==                                                  ===++++ \n==+====     ===                                          ++===== \n=+===++== =======                #                        ++==== \n +=++=====+=====         :::+*:::-*=-::::-        =====  =++++++ \n ==+====++====        :::--++::::::-++-:::::      =======++===== \n  ++==++======       ::::====+::::=**+=:::::::     =======+===== \n   ===+=======     ::::-+*===-:::::-=--+*+-:::::   ========+==== \n    ======+===    ::::=*-:--:=+****+--:::::::::::  ===+========= \n    =======++    :::::::::=*##########*-:::::::::: ==+=========  \n     =======    :::::::::+##############=::::::::::  +=======   \n       ===      ::::::::*###%%%###%%%####+:::::::::    ===      \n               ::::::::+###%%%%%%%%%%#####=:::::::::            \n               :::::::=####%%%%%%%%%%%####*-::::::::            \n               ::::::-*####%%%%%%%%%%%#####+::::::::            \n                :::::=#####%#*-::::-*#######-::::::             \n                :::::+#####+-::::::::-*#####=::::::             \n                 ::=-####*-::::::::::::=#####:::::              \n                  ---###+:::::::::::::::-*###:--:               \n                   -::--=:::::::::::::::::-=-:--                \n                    ::-=:::::::::::::::::-=-::::                \n                       ::::::::::::::::::::-                    \n                          :::::::::::::::                       "
youwin: .asciiz "\nYou win!"
youlose: .asciiz "\nYou lost. "


# User input
prompt: .asciiz "\nEnter your guess: "
input: .space 2

# Guessed Letters
guessedLetters: .space 27
allGuessedLetters: .space 27
lettersUsedMsg: .asciiz "\nLetters used: "
yourWord: .asciiz "\nYour word: "

# Guess messages
incorrect: .asciiz "Sorry your guess is not correct. \n"
correct: .asciiz"Your guess is correct! \n"
invalid: .asciiz"Your guess is invalid. Try again. \n"

# Life messages 
youhave: .asciiz "You have "
livesmsg: .asciiz " lives left."
wordis: .asciiz "The word is: "
correctword: .asciiz "The correct word is: "
wordguessed: .asciiz "The guessed word is: "
dead: .asciiz "\nYou are out of lives. "

# New line
newLine: .asciiz "\n"

# break
break: .asciiz"\n-----------------------------------------------------------------\n"


.text 
main: 
# Initialize guessedLetters with a null terminator
    	la $a0, guessedLetters
    	sb $zero, 0($a0)
	
	# print title
	la $a0, title
	li $v0, 4
	syscall
	
	# print theme
	la $a0, theme
	li $v0, 4
	syscall
	
	li $s0, 6 				# initialize $s0 = lives = 6
	lw $a1, wordCount 			# $a1 = wordCount = 22 (size of wordList)
	
	beqz $s0, endGame			# if lives = 0 go to endGame
		
	blt $s0, 6, skipGetRandomWord		# if lives is less than 6 skipGetRandomWord
		
	jal getRandomWord			# call getRandomWord
		
		
	move $t7, $v0				# move random word result to $a0		
	move $a0, $t7				# move random word into $a0

	
	skipGetRandomWord: 			# if lives is less than 6 playGame
		jal playGame			# call playGame
			
		la $a0, newLine			# print newLine
		li $v0, 4
		syscall 
			
		la $a0, correctword		# print correctword
		li $v0, 4
		syscall
			
		move $a0, $t7	 		# print the random word
		li $v0, 4 
		syscall
			
endGame:
exit: 	li $v0, 10
	syscall

# --------------------------------------------------------------------------------------------------------------

# checkStage function:
# jumps to appropiate label dependent on the amount of lives that the player has left
# and prints the corresponding stage 
# $a0 = player lives 
checkStage:
	
	# checks which statement to go to depending on the amount of lives the player has left
	beq $a0, 6, equal_6	
	beq $a0, 5, equal_5
	beq $a0, 4, equal_4
	beq $a0, 3, equal_3
	beq $a0, 2, equal_2
	beq $a0, 1, equal_1
	beq $a0, 0, equal_0

	equal_6:
		la $a0, stage1	# prints the hangman art at the certain stage
		li $v0, 4 
		syscall
		jr $ra
	equal_5:
		la $a0, stage2
		li $v0, 4 
		syscall
		jr $ra
	equal_4:
		la $a0, stage3
		li $v0, 4 
		syscall
		jr $ra
	equal_3:
		la $a0, stage4
		li $v0, 4 
		syscall
		jr $ra
	equal_2:
		la $a0, stage5
		li $v0, 4 
		syscall
		jr $ra
	equal_1:
		la $a0, stage6
		li $v0, 4 
		syscall
		jr $ra
	equal_0:
		la $a0, stage7
		li $v0, 4 
		syscall
		jr $ra	


# --------------------------------------------------------------------------------------------------------------

# getRandomWord function:
# generates a random number, calculates address offset in the wordList, and retuns the address of the word at the offset from wordList
# $a0 = stores random number
# $a1 = wordCount
getRandomWord:
    	li $v0, 42		# 42 = syscall for random number generation
    	lw $a1, wordCount	# load wordCount into $a1
    	syscall			# generate a random number and store into $a0

    	mul $a0, $a0, 4		# multiply the random number by 4 to calculate address offset
    	
    	lw $v0, wordList($a0)   # load the address of selected word into $v0
    	jr $ra  
# --------------------------------------------------------------------------------------------------------------
	
# getRandomWordLength function:
# iterates through the random word by character and increases the length counter $v0 while character is not null (0)
# returns the length of the random word
# $a0 = random word 
# $t8 = temporary hold of each character in $a0
# $v0 = length of random word

getRandomWordLength: 
	
	# push item to stack
	addi $sp, $sp, -4		# allocate space in stack
	sw $a0, 0($sp)			# save word 
	
	li $v0, 0  			# set length of the word = 0
    	
	getRandomWordLengthLoop: 
    		lb $t8, 0($a0)          		# load a character from the string
   		beqz $t8, getRandomWordLengthLoopEnd  	# if the character is null exit the loop
    		addi $a0, $a0, 1          		# move to the next character
    		addi $v0, $v0, 1          		# increase length count
    		j getRandomWordLengthLoop         	
    		
    	getRandomWordLengthLoopEnd:	
    	lw $a0, 0($sp) 		# load word
	addi $sp, $sp, 4	# deallocate stack space
	jr $ra	
# --------------------------------------------------------------------------------------------------------------

# function writeUnderscores:
# moves pointer to end of the string, iterates backwards, while storing an underscore at each position 
# until the pointer reaches to the beginning of the string (length counter = 0 )
# $a0 = address of guessedLetters / pointer 
# $a1 = length of word
# $t1 = '_'

writeUnderscores: 
	
	# push items to stack
	addi $sp, $sp, -8	# allocate space in stack
	sw $a0, 0($sp)		# save address of guessedLetters
	sw $a1, 4($sp)		# save length of word
	
	
	add $a0, $a0, $a1			# move $a0 pointer to the end of the string
	addi $t1, $0, 95			# set $t1 = '_'
	sb $0, 0($a0)				# set null terminator at the end of the string
	
	writeUnderscoresLoop:
		
		beqz $a1, writeUnderscoresLoopEnd	# if the length counter ($a1) is 0 exit the loop
		addi $a0, $a0, -1			# go to previous character
		addi $a1, $a1, -1			# decrement length counter
		sb $t1, 0($a0)				# store underscore at current position
		j writeUnderscoresLoop			
		
	writeUnderscoresLoopEnd:
	
		lw $a0, 0($sp)				# load address of guessedLetters
		lw $a1, 4($sp)				# load length of word
		addi $sp, $sp, 8			# deallocate stackspace
		jr $ra				          


# --------------------------------------------------------------------------------------------------------------
# checkIfwordContainsChar function:
# iterates through the random word string, checking if the user inputted character matches the character at the pointer position until the end of the string (null = 0) 
# returns 0 if the inputted character is not found in the random word
# returns 1 if the inputted character is found in the random word
# $a0 = random word / pointer
# $t0 holds each character in string
# $a1 = inputted character
# $v0 = 0 | char not found
# $v0 = 1 | char found

checkIfwordContainsChar:
	
	addi	$sp, $sp, -4	# allocate stack space
	sw	$a0, 0($sp)	# save random word 
	
	li $v0, 0		# set $v0 to 0 = FALSE
	
	checkIfwordContainsCharLoop:
		lb $t0, 0($a0)					# load char from string and set to $t0
		beqz $t0, checkIfwordContainsCharLoopEnd	# if we reach end of string go to checkIfwordContainsCharLoopEnd
		beq $t0, $a1, charFound				# checks if the current character matches the inputted character |  if character matches go to charFound
		addi $a0, $a0, 1				# increment string address to iterate
		j checkIfwordContainsCharLoop			
	
	charFound:
		addi $v0, $0, 1			# set $v0 = 1
	
	checkIfwordContainsCharLoopEnd:
		
		lw $a0, 0($sp)			# load random word
		addi $sp, $sp, 4		# deallocate stack space
		jr $ra				

# --------------------------------------------------------------------------------------------------------------
# updateGuessedetters function:
# iterates through random word until at the end of the string
# compares each character of the random word with the inputted character
# if the inputted char and current char match, the inputted char is stored at the correspoding 
# position in guessedLetters
# $a0 = address of guessedLetters
# $a1 = random word address
# $a2 = inputed character
# $t0 = character being checked in string

updateGuessedLetters:
	
	# push items to stack
	addi $sp, $sp, -8	# allocate stack space
	sw $a0, 0($sp)		# store address of guessedLetters
	sw $a1, 4($sp)		# store word address
	
	updateGuessedLetterLoop:
		lb $t0, 0($a1)					# load the current char from the random word and set to $t0
		beqz $t0, updateGuessedLetterLoopEnd		# if the current character is 0/null go to updateGuessedLetterLoopEnd
		bne $t0, $a2, charNotFound			# if current char doesn't match the inputted char go to charNotFound
		sb $a2, 0($a0)					# store inputted char in the guessedLetter string at the corresponding position
	charNotFound:
		addi $a0, $a0, 1				# move to next char in guessedLetters
		addi $a1, $a1, 1				# move to next char in the random word
		j updateGuessedLetterLoop
	
	updateGuessedLetterLoopEnd:	
		lw $a1, 4($sp)			# load word address
		lw $a0, 0($sp)			# load address of guessedLetters
		addi $sp, $sp, 8		# deallocate stack space
		jr $ra				

# --------------------------------------------------------------------------------------------------------------

# addGuessedLetter function: 
# adds the guessed letter to guessedLetters and allGuessedLetters arrays
# $a0 = guessed letter
addGuessedLetter:
   
    	la $t1, guessedLetters		# loads address of guessedLetters to $t1
    	move $t3, $a0  			# move the guessed letter to $t3

    	addToAllGuessed:
    	la $t1, allGuessedLetters  	# load address of allGuessedLetters to $t1

    	checkAllGuessedDuplicate:
       		lb $t2, 0($t1)			# load byte at current position of allGuessedLetters into $t2
        	beqz $t2, addHereAllGuessed	# if at end of array ($t2 = 0/null) go to addHereAllGuessed
        	addi $t1, $t1, 1		# increment array index 
        	j checkAllGuessedDuplicate

    	addHereAllGuessed:
        	sb $t3, 0($t1)		# store guessed Letter at current position
        	addi $t1, $t1, 1	# move to next position
        	sb $zero, 0($t1)	# store 0 to mark end of string 
        	li $v0, 1		# set $v0 to 1 to indicate a new letter was added

    		jr $ra
    		
    	addHere:
        	sb $t3, 0($t1)		# store guessed letter at current position
        	addi $t1, $t1, 1	# move to next position
        	sb $zero, 0($t1)	# store 0 to mark end of string 
        	li $v0, 0 		# Set $v0 to 0 to indicate the letter was already guessed
        	jr $ra
# --------------------------------------------------------------------------------------------------------------

# printGuessedLetters function:
# prints each letter in guessedLetters array
# $a0 = holds each char from guessedLetters
# $t1 = address of guessedLetters array
printGuessedLetters:
    	la $t1, guessedLetters		# load adress of guessedLetters array into $t1
    	printLoop:
        	lb $a0, 0($t1)		# load byte at current position of the array into $a0
        	beqz $a0, endPrint  	# if null/0 go to end print
        	li $v0, 11           	# print character syscall
        	# syscall
        	addi $t1, $t1, 1     	# move pointer to the next letter
        	j printLoop

    	endPrint:
    		la $a0, newLine      	# print new line
        	li $v0, 4
        	syscall
        	
        	jr $ra
# --------------------------------------------------------------------------------------------------------------

# printAllGuessedLetters function:
# prints all letters that have been guessed so far 
printAllGuessedLetters:
    
    	la $a0, lettersUsedMsg  # print lettersUsedMsg
    	li $v0, 4
    	syscall

    
    	la $t1, allGuessedLetters		# load address of allGuessedletters into $t1
    
    	printAllGuessedLoop:
        	lb $a0, 0($t1)			# load byte at the current position into $a0
        	beqz $a0, endPrintAllGuessed	# if null/0 go to endPrintAllGuessed
        	li $v0, 11			# print character
        	syscall
        	addi $t1, $t1, 1		# move to next character
        	j printAllGuessedLoop

    	endPrintAllGuessed:	
    		la $a0, newLine			# print newLine
    		li $v0, 4
    		syscall
    		jr $ra
# --------------------------------------------------------------------------------------------------------------



playGame: 
	# $a0 = word
	# $a1= wordCount
	# $s1 = word length
	# $s2 = word location
	
	addi $sp, $sp, -24
	sw $ra, 0($sp)          # save return address
    	sw $s0, 4($sp)          # save $s0 (player lives)
    	sw $a0, 8($sp)          # save $a0 (word address)
    	sw $a1, 12($sp)		# save wordCount
    	sw $s1, 16($sp)		# save word length
    	sw $s2, 20($sp)		# save word lcoation
    	
    	jal getRandomWordLength
    	
    	move $s1, $v0	# $s1 = word length
    	move $s2, $a0	# $s2 = word location
	
	# $a0 = guessLetters address
	# $a1 = word length
	la $a0, guessedLetters	# $a0 = guessedLetters address
	move $a1, $s1	# $a1 = word length
	jal writeUnderscores
	
	playGameLoop:
		beq $s0, 0, playGameLoopEnd		# if lives = 0 go to playGameLoopEnd
		
		la $a0, wordis				# print wordis 
    		li $v0,4 			
    		syscall
    
    		la $a0, guessedLetters			# print the guessed word so far
    		li $v0, 4
    		syscall
    		
    		la $a0, newLine				# print newLine
    		li $v0, 4
    		syscall
    		
    		la $a0, youhave				# print youhave
    		li $v0, 4
    		syscall
    		
    		move $a0, $s0				# print amount of lives
    		li $v0, 1 
    		syscall
    		
    		la $a0, livesmsg			# print livesmsg
    		li $v0, 4
    		syscall
    		
    		move $a0, $s0
    		jal checkStage				# print stage
    
    		la $a0, prompt				# print prompt
    		li $v0, 4
    		syscall
    		
    		# read user char input
    		li $v0, 12		# 12 read char syscall
		syscall			
		move $s3, $v0		# move result into $s3
	
		la $a0, newLine		# print new line
		li $v0, 4
		syscall		
    		
    		
    		# Add the guessed letter and print guessed letters
    		move $a0, $s3  # Move guessed character into $a0
    		jal addGuessedLetter
    		jal printGuessedLetters
    		jal printAllGuessedLetters
    		
    		# if input not a lowercase char go to invalidChar
    		blt $s3, 97, invalidChar	
    		bgt $s3, 122, invalidChar 
    		
    		beqz $v0, other 		#if repeat letter jump to other playGameLoop
    		
    		
		move $a0, $s2			# move word location into #a0
		move $a1, $s3			# move user input char into $s3
		jal checkIfwordContainsChar 	
    		
		bnez $v0, inputCharFound	# if return value != 0 the inputted char was found
		# else
		
		addi $s0, $s0 -1		# subtract life 
		
		other:
		la $a0, incorrect		# print incorrect
		li $v0, 4
		syscall
		
		beqz $s0, endRound		# if lives = 0, end round


		la $a0, break			# print break
    		li $v0, 4
    		syscall
		
		j playGameLoop
		
		
		
    		
    		
    	inputCharFound:
    		la $a0, guessedLetters	# load address of guessedLetters
		move $a1, $s2		# load word address
		move $a2, $s3		# load the input char
		jal updateGuessedLetters	# update guessedLetters 
		
		la $a0, guessedLetters		# load guessedLetters address 
		addi $a1, $0, 95		# set $a1 to '_'
		jal checkIfwordContainsChar	# check if guessedLetters still has underscores
		beqz $v0, endRound		# if no underscores left in guessedLetters go to endRound
	
		
		la $a0, correct		# print correct	
		li $v0, 4 
		syscall				
		
		j playGameLoop
    	invalidChar:
    		la $a0, invalid		# print invalid
    		li $v0, 4
    		syscall
    		
    		j playGameLoop
    		
    	endRound:
    		beq $s0, 0, lose 	# if lives = 0 go to lose
    		
    		# else 
    		la $a0, youwin		# print youWin
    		li $v0, 4
    		syscall
    		
    		la $a0, jarfix		# print jarfix
    		li $v0, 4
    		syscall
    		
    		la $a0, wordguessed	# print wordguessed 
    		li $v0,4 			
    		syscall
    
    		la $a0, guessedLetters	# print the guessed word so far
    		li $v0, 4
    		syscall
    		
    		
    		j playGameLoopEnd
    		
    		
    		
    		lose:
    			la $a0, stage7		# print stage7
    			li $v0, 4
    			syscall
    		
    			la $a0, dead		# print dead	
    			li $v0, 4
    			syscall
    		
    			la $a0, youlose		# print you_lose
    			li $v0, 4
    			syscall
    		
    			la $a0, nooo		# print nooo
    			li $v0, 4
    			syscall	
    			
    			la $a0, newLine		# print new line
    			li $v0, 4
    			syscall
    			
    			la $a0, wordguessed	# print wordguessed 
    			li $v0,4 			
    			syscall
    
    			la $a0, guessedLetters	# print the guessed word so far
    			li $v0, 4
    			syscall
    		
    		
	playGameLoopEnd:
	
		lw $s2, 20($sp)		# load word lcoation
		lw $s1, 16($sp)		# load word length
    		lw $a1, 12($sp)		# save wordCount
    		lw $a0, 8($sp)          # save $a0 (word address)
    		lw $s0, 4($sp)          # save $s0 (player lives)
		lw $ra, 0($sp)          # save return address
		addi $sp, $sp, -12	# deallocate stack space
		jr $ra


