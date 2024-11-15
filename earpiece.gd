extends Node2D
var categories = ["animals", "mammals", "colours", "birds", "feelings", "food and drink", "places", "time and seasons", "cold or cool", "hot or warm"]
const words = {"Duck":["animals","birds", "food and drink"], 
			 "Dog":["animals","mammals", "feelings"], 
			 "Cat":["animals","mammals"],
			 "Chicken":["birds", "food and drink", "feelings", "animals"],
			 "Parrot":["birds", "animals"],
			 "Salmon":["animals", "food and drink", "colours"],
			 "Home":["places", "feelings"], 
			 "Lake":["places", "cold or cool"],
			 "Ocean":["places", "cold or cool"],
			 "Mountain":["places", "cold or cool"],
			 "River":["places", "cold or cool"],
			 "Wind":["feelings", "cold or cool", "hot or warm"],
			 "Green":["colours", "cold or cool"],
			 "Blue":["colours", "feelings", "cold or cool"],
			 "Yellow":["colours", "feelings", "hot or warm"],
			 "Gold":["colours", "hot or warm"],
			 "Orange":["colours","food and drink", "hot or warm"],
			 "Red":["colours", "hot or warm"],
			 "Bright":["feelings", "hot or warm"],
			 "Pink":["colours", "feelings", "hot or warm"],
			 "Happy":["feelings", "hot or warm"],
			 "Peace":["feelings", "cold or cool"],
			 "Angry":["feelings", "hot or warm"],
			 "Water":["food and drink", "cold or cool"],
			 "Zoo":["animals", "places"],
			 "Island":["places", "hot or warm"],
			 "Year":["time and seasons"],
			 "Night":["time and seasons", "cold or cool"],
			 "Day":["time and seasons", "hot or warm"],
			 "Noon":["time and seasons", "hot or warm"],
			 "Summer":["time and seasons", "hot or warm"],
			 "Winter":["time and seasons", "cold or cool"],}
var button_list = []
var correct_list = []
var other_list = []
var butt_collection = []
var category = "none"
var failure = 0
var success = 0
var chances = 3

const NUM_CORRECT_OPTIONS = 3
const NUM_BUTTONS = 16

func _ready():
	generate()

func generate():
	success = 0
	failure = 0
	category = categories.pick_random()
	print("Category: " + category)
	for word in words:
		if category in words[word]:
			correct_list.append(word)
		else:
			other_list.append(word)
	
	correct_list.shuffle()
	other_list.shuffle()
	for i in range(NUM_CORRECT_OPTIONS):
		button_list.append(correct_list.pop_back())
	for i in range(NUM_BUTTONS - NUM_CORRECT_OPTIONS):
		button_list.append(other_list.pop_back())

	button_list.shuffle()
	create_buttons()
	$Panel/CategoryLabel.text = category

func create_buttons():
	var matching = []
	var distancex = 50
	var distancey = 50
	var text = ''
	for i in range(16):
		var butt = Button.new()
		text = str(button_list[i]) #-1?
		add_child(butt)
		butt.set_text(text) #-1?
		butt.set_custom_minimum_size(Vector2(240, 100))
		butt.set_global_position(Vector2(distancex, distancey))
		butt.pressed.connect(button_click.bind(text, butt))
		if distancex == 875:
			distancex = 50
			distancey = distancey + 150
		else:
			distancex = distancex + 275
		#LOL @ butts
		butt_collection.append(butt)

func button_click(text, butt):
	print("Clicked: " + text)
	var selected_categories = str(words[text])
	print("Categories for this: " + selected_categories)
	if category in selected_categories:
		#butt.icon_disabled_color = Color.GREEN
		butt.get_theme_stylebox("disabled").bg_color = Color.GREEN
		#set("theme_override_colors/icon_disabled_color", butt.Color.RED)
		print("YES!")
		success = success + 1
	else:
		butt.get_theme_stylebox("disabled").bg_color = Color.RED
		butt.get_theme_stylebox("normal").bg_color = Color.RED
		butt.get_theme_stylebox("hover").bg_color = Color.RED
		#im done with this its not a bug its a feature now
		print("NO. OH NO. NO NO NO.")
		butt.disabled = true
		$Panel/beegINCORRECT.visible = true
		$Panel/IncorrectSOUND.play()
		await get_tree().create_timer(1.0).timeout #WAIT!!!!
		failure = failure + 1
	butt.disabled = true

func _process(_delta):
	if success == 3:
		#winner winner chicken dinner
		print('congrat!!')
		success = 0
		for butt in butt_collection:
			butt.queue_free()
		butt_collection = []
		generate()
	elif failure == 1 and chances > 0:
		#im gonna call you daniel cuz you suck
		print('daniel sucks')
		$Panel/beegINCORRECT.visible = false
		for butt in butt_collection:
			butt.get_theme_stylebox("disabled").bg_color = Color(0.1, 0.1, 0.1, 0.3)
			butt.get_theme_stylebox("normal").bg_color = Color(0.1, 0.1, 0.1, 0.3)
			butt.get_theme_stylebox("hover").bg_color = Color(0.1, 0.1, 0.1, 0.3)
			butt.queue_free()
		butt_collection = []
		if chances == 3: #im sorry mr ihlien 
			$Panel/Incorrect1.visible = true
			chances = chances - 1
			generate()
		elif chances == 2:
			$Panel/Incorrect2.visible = true
			chances = chances - 1
			generate()
		elif chances == 1:
			$Panel/Incorrect3.visible = true
			chances = chances - 1
			#game over, return something to server to indicate
		
