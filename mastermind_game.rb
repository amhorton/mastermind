class Fixnum
    def invalid? #this is a method for generating the set of all possible guesses: we want all four-digit numbers that include only the digits 1-6
    	selfstring = self.to_s
        if selfstring.include?('0')
            return true
        elsif selfstring.include?('7')
            return true
        elsif selfstring.include?('8')
            return true 
        elsif selfstring.include?('9')
            return true   
        else
            return false
        end
    end
    def eliminated?(last_guess, user_response) #this method flags a potential guess as invalid based on user input.
	if compare(self, last_guess) != user_response
	    return true
	else
	    return false
	end
    end
    def translate #translates four-digit integers into an array of color-word strings, so that the user can compare them easily
        guess_split = self.to_s.split(//)
	guess_split.collect {|n|
	    if n == "1"
		n = "Red"
	    elsif n == "2"
		n = "Orange"
	    elsif n == "3"
		n = "Yellow"
	    elsif n == "4"
		n = "Green"
	    elsif n == "5"
		n = "Blue"
	    elsif n == "6"
		n = "Purple"
	    end
	}
    end
end

def compare(guess, solution) #takes two codes generates the appropriate peg awards in the form of an array
    guess_split = guess.to_s.split(//)
    solution_split = solution.to_s.split(//)
    black_peg = 0
    white_peg = 0
	
    for i in 0..3
        if guess_split[i] == solution_split[i]
	    black_peg += 1
	    solution_split[i] = "ALSO COUNTED"
	    guess_split[i] = "COUNTED"
	end
    end
    for i in 0..3
        if guess_split.include?(solution_split[i]) == true
	    white_peg += 1
	    guess_split.delete_at(guess_split.find_index(solution_split[i])) 
	end
    end
    return[black_peg, white_peg]
end

set = Array.new # building the set, using our .invalid? function

for i in 1111..6666 do
    if i.invalid? != true
		set << i
    end
end

def make_a_guess(guess) #this is the method that pulls user feedback on each guess. This is where we use .translate
    puts "Computer's guess: #{guess.translate}"
    puts "How many black pegs? This should be a number between 0 and 4"
    black_peg = gets.chomp.to_i
    if black_peg > 4 or black_peg < 0
	puts "error! That's not a number between 0 and 4."
    end
    puts "How many white pegs? This should be a number between 0 and 4"
    white_peg = gets.chomp.to_i
    if white_peg > 4 or white_peg < 0
	puts "error! That's not a number between 0 and 4."
    end
    return [black_peg, white_peg]
end

puts "Hello! Welcome to Mastermind."
puts "Possible colors: Red, Orange, Yellow, Green, Blue, Purple"
puts "Sequence length: 4"
puts "Ready? Y/N"

ready_or_not = gets.chomp.upcase #have to give them time to think of a code before we start to guess!

#this is where everything is pulled together. We start with 1122 (a generally strong guess) and grab user inputs with "make_a_guess", then goes through our set and uses "compare" (from within ".eliminated?") to figure out which codes are no longer possible answers given that input. We then cut those sets out of the array, and we loop until our response is [4, 0], i.e, four black pegs. 

if ready_or_not == "Y" 
    user_response = []
    last_guess = 1122
    tries = 0
    while user_response != [4, 0] do
        user_response = make_a_guess(last_guess)
	set.reject! {|n| n.eliminated?(last_guess, user_response) == true}
	last_guess = set.shuffle.first
	tries += 1
    end
    puts "Computer Wins! number of tries: #{tries}"
else puts "Wake me when you've got a code in mind."
end
