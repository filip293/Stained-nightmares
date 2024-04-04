extends Label

# Reference to the script where the string changes
var tasks_script = null

# Previous sentence to track changes
var previous_sentence = ""

# Index to keep track of current word
var current_word_index = 0

# Index to keep track of current letter in the current word
var current_letter_index = 0

# Variable to store the displayed sentence
var displayed_sentence = ""

func _ready():
	# Get reference to the script where the string changes
	tasks_script = $"/root/Node3D/Player"
	
	# Start displaying words
	display_word()

func display_word():
	# Get the current sentence from the tasks_script
	var sentence = tasks_script.tasks

	# Check if the sentence has changed
	if sentence != previous_sentence:
		# Reset indices and displayed sentence
		current_word_index = 0
		current_letter_index = 0
		displayed_sentence = ""
		previous_sentence = sentence
	
	# Split the sentence into individual words
	var words = sentence.split(" ")

	# Check if there are more words to display
	if current_word_index < words.size():
		# Get the current word
		var current_word = words[current_word_index]
		
		# Add the current word to the displayed sentence
		displayed_sentence += current_word.substr(current_letter_index, 1)
		
		# Update the label with the displayed sentence
		text = displayed_sentence
		
		# Increment the index for the next letter
		current_letter_index += 1
		
		# If all letters of the current word have been displayed, move to the next word
		if current_letter_index > current_word.length():
			current_word_index += 1
			current_letter_index = 0
			
			# Add a space to separate words
			displayed_sentence += " "
		
		# Schedule the next word/letter to be displayed after a delay
		$Timer.start()
	else:
		# All words have been displayed
		text = displayed_sentence



func _on_timer_timeout():
	display_word()
