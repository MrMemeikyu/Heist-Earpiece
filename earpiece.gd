extends Node2D
#variables for server connection
var api_version = "1.02"
var client_type = "godot"
var role = "earpiece"
var socket := WebSocketPeer.new()
var connected := false

func log_message(message: String) -> void:
	var time := "[color=#aaaaaa] %s |[/color] " % Time.get_time_string_from_system()
	print(time + message)

func _process(_delta: float) -> void:
	socket.poll()

	if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			log_message(socket.get_packet().get_string_from_ascii())
	#moving here might have to change !!
	if connected == true:
		if Input.is_action_just_pressed('Up') == true:
			var instruction = {"action":"move", "direction":"up"}
			send(instruction)
		if Input.is_action_just_pressed('Left') == true:
			var instruction = {"action":"move", "direction":"left"}
			send(instruction)
		if Input.is_action_just_pressed('Down') == true:
			var instruction = {"action":"move", "direction":"down"}
			send(instruction)
		if Input.is_action_just_pressed('Right') == true:
			var instruction = {"action":"move", "direction":"right"}
			send(instruction)

func _exit_tree() -> void:
	socket.close()

func send(message: Dictionary):
	#socket.put_packet(message.to_utf8_buffer())
	message["role"] = "earpiece"
	message["version"] = api_version
	socket.send_text(JSON.stringify(message))

func _connection_button_pressed() -> void:
	var websocket_url := "ws://" + str($Connection_Panel/LineEdit.get_text()) + ":9876"
	print(websocket_url)
	if socket.connect_to_url(websocket_url) != OK:
		log_message("Unable to connect.")
		set_process(false)
		$Connection_Panel/RichTextLabel.set_text('Unable to connect.')
	else:
		var state = socket.get_ready_state()

		while state == WebSocketPeer.STATE_CONNECTING:
			state = socket.get_ready_state() 
			socket.poll()
		if state == WebSocketPeer.STATE_OPEN:
			connected = true
			#initial connection string - sub "lockpick" for selected role
			var instruction = {"action":"join"}
			send(instruction)
			print("Connected!")
			$Connection_Panel/RichTextLabel.set_text('Connected!')
			$Panel2.set_visible(true)
			$Connection_Panel.set_visible(false)

#moving is more of a next lesson activity

#variables for minigame
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
var wins = 0
var loop_closure = false #im sorry mr ihlein
var victory = null

const NUM_CORRECT_OPTIONS = 3
const NUM_BUTTONS = 16

func _ready():
	pass

func generate():
	button_list = []
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
	print(button_list)

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
		$Panel/CorrectSOUND.play()
		success = success + 1
		butt.disabled = true
	else:
		butt.get_theme_stylebox("disabled").bg_color = Color.RED
		butt.get_theme_stylebox("normal").bg_color = Color.RED
		butt.get_theme_stylebox("hover").bg_color = Color.RED
		#im done with this its not a bug its a feature now
		print("NO. OH NO. NO NO NO.")
		for butts in butt_collection:
			butts.disabled = true
		$Panel/beegINCORRECT.visible = true
		$Panel/IncorrectSOUND.play()
		await get_tree().create_timer(1.0).timeout #WAIT!!!!
		failure = failure + 1

func begin_minigame():
	button_list = []
	correct_list = []
	other_list = []
	butt_collection = []
	category = "none"
	failure = 0
	success = 0
	chances = 3
	loop_closure = false #im sorry mr ihlein
	victory = null
	$Panel/Incorrect1.visible = false
	$Panel/Incorrect2.visible = false
	$Panel/Incorrect3.visible = false
	generate()
	while loop_closure == false:
		await get_tree().create_timer(0.01).timeout #godot cannot handle while loops alone
		if success == 3:
			#winner winner chicken dinner
			print('congrat!!')
			success = 0
			wins = wins + 1
			for butt in butt_collection:
				butt.queue_free()
			butt_collection = []
			if wins == 3:
				#winner, return dsomsrhting
				victory = true
				loop_closure = true
			else:
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
				victory = false
				loop_closure = true
	print("what the godot")


func _on_button_pressed() -> void:
	$Panel.set_visible(true)
	$Panel2.set_visible(false)
	await begin_minigame()
	if victory == true:
		$Panel2/RichTextLabel.text = 'Minigame: Success'
	elif victory == false:
		$Panel2/RichTextLabel.text = 'Minigame: YOU SUCK!!!!!!'
	else:
		$Panel2/RichTextLabel.text = 'uh oh'
	$Panel.set_visible(false)
	$Panel2.visible = true
