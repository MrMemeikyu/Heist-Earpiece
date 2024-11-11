extends Panel
var categories = ["Animals", "Nature", "Colours", "Movements", "Feelings", "Food & Drink", "Places", "Time & Seasons", "Sounds", "Objects"]
var words = ["Duck", "Dog", "Cat", "Fish", "Elephant", "Insect", "Turtle", "Zebra", "Animal", "Bird", "Tree", "Lake", "Ocean", "Mountain", "River", "Wind", "Cloud", "Leaf", "Vine", "Star", "Green", "Blue", "Yellow", "Gold", "Orange", "Red", "Bright", "White", "Purple", "Pink", "Run", "Walk", "Jump", "Dance", "Swim", "Fly", "Spin", "Bounce", "Skip", "Zigzag", "Happy", "Calm", "Joy", "Love", "Peace", "Quiet", "Fun", "Hope", "Smile", "Nice", "Apple", "Bread", "Milk", "Water", "Orange", "Juice", "Berry", "Fruit", "Sugar", "Candy", "Park", "Zoo", "Island", "Mountain", "Ocean", "Lake", "Home", "City", "Beach", "School", "Year", "Early", "Night", "Day", "Time", "Noon", "Morning", "Summer", "Winter", "Spring", "Sing", "Talk", "Echo", "Voice", "Bell", "Buzz", "Chirp", "Shout", "Music", "Xylophone", "Kite", "Ball", "Balloon", "Nest", "Gift", "Circle", "Rock", "Light", "Book", "Star"]
var button_list = []
var chosen_group = ''
var sort = {
	words[0] : categories[0] + '0',
	words[1] :  categories[0] + '1',
	words[2] :  categories[0] + '2',
	words[3] :  categories[0] + '3',
	words[4] :  categories[0] + '4',
	words[5] :  categories[0] + '5',
	words[6] :  categories[0] + '6',
	words[7] :  categories[0] + '7',
	words[8] :  categories[0] + '8',
	words[9] :  categories[0] + '9',
	words[10] :  categories[1] + '0',
	words[11] :  categories[1] + '1',
	words[12] :  categories[1] + '2',
	words[13] :  categories[1] + '3',
	words[14] :  categories[1] + '4',
	words[15] :  categories[1] + '5',
	words[16] :  categories[1] + '6',
	words[17] :  categories[1] + '7',
	words[18] :  categories[1] + '8',
	words[19] :  categories[1] + '9',
	words[20] :  categories[2] + '0',
	words[21] :  categories[2] + '1',
	words[22] :  categories[2] + '2',
	words[23] :  categories[2] + '3',
	words[24] :  categories[2] + '4',
	words[25] :  categories[2] + '5',
	words[26] :  categories[2] + '6',
	words[27] :  categories[2] + '7',
	words[28] :  categories[2] + '8',
	words[29] :  categories[2] + '9',
	words[30] :  categories[3] + '0',
	words[31] :  categories[3] + '1',
	words[32] :  categories[3] + '2',
	words[33] :  categories[3] + '3',
	words[34] :  categories[3] + '4',
	words[35] :  categories[3] + '5',
	words[36] :  categories[3] + '6',
	words[37] :  categories[3] + '7',
	words[38] :  categories[3] + '8',
	words[39] :  categories[3] + '9',
	words[40] :  categories[4] + '0',
	words[41] :  categories[4] + '1',
	words[42] :  categories[4] + '2',
	words[43] :  categories[4] + '3',
	words[44] :  categories[4] + '4',
	words[45] :  categories[4] + '5',
	words[46] :  categories[4] + '6',
	words[47] :  categories[4] + '7',
	words[48] :  categories[4] + '8',
	words[49] :  categories[4] + '9',
	words[50] :  categories[5] + '0',
	words[51] :  categories[5] + '1',
	words[52] :  categories[5] + '2',
	words[53] :  categories[5] + '3',
	words[54] :  categories[5] + '4',
	words[55] :  categories[5] + '5',
	words[56] :  categories[5] + '6',
	words[57] :  categories[5] + '7',
	words[58] :  categories[5] + '8',
	words[59] :  categories[5] + '9',
	words[60] :  categories[6] + '0',
	words[61] :  categories[6] + '1',
	words[62] :  categories[6] + '2',
	words[63] :  categories[6] + '3',
	words[64] :  categories[6] + '4',
	words[65] :  categories[6] + '5',
	words[66] :  categories[6] + '6',
	words[67] :  categories[6] + '7',
	words[68] :  categories[6] + '8',
	words[69] :  categories[6] + '9',
	words[70] :  categories[7] + '0',
	words[71] :  categories[7] + '1',
	words[72] :  categories[7] + '2',
	words[73] :  categories[7] + '3',
	words[74] :  categories[7] + '4',
	words[75] :  categories[7] + '5',
	words[76] :  categories[7] + '6',
	words[77] :  categories[7] + '7',
	words[78] :  categories[7] + '8',
	words[79] :  categories[7] + '9',
	words[80] :  categories[8] + '0',
	words[81] :  categories[8] + '1',
	words[82] :  categories[8] + '2',
	words[83] :  categories[8] + '3',
	words[84] :  categories[8] + '4',
	words[85] :  categories[8] + '5',
	words[86] :  categories[8] + '6',
	words[87] :  categories[8] + '7',
	words[88] :  categories[8] + '8',
	words[89] :  categories[8] + '9',
	words[90] :  categories[9] + '0',
	words[91] :  categories[9] + '1',
	words[92] :  categories[9] + '2',
	words[93] :  categories[9] + '3',
	words[94] :  categories[9] + '4',
	words[95] :  categories[9] + '5',
	words[96] :  categories[9] + '6',
	words[97] :  categories[9] + '7',
	words[98] :  categories[9] + '8',
	words[99] :  categories[9] + '9'
}

func select_group():
	var value_list = []
	var number = 0
	var value = ''
	var dupe_placeholder = 9
	for i in range(4):
		number = randi_range(0,5)
		value = sort[words[number*10]]
		value = value.left(value.length() - 1)
		if value in value_list or value == null:
			value = sort[words[dupe_placeholder*10]]
			dupe_placeholder = dupe_placeholder - 1
			value = value.left(value.length() - 1)
		value_list.append(value)
	for i in value_list: #debug
		print(i)
	return(value_list)

func find_group(group_name):
	var value_list = []
	var number = 0
	var value = ''
	var dupe_placeholder = 9
	for i in range(4):
		number = randi_range(0,5)
		value = sort.find_key(str(group_name) + str(number))
		if value in value_list or value == null:
			value = sort.find_key(str(group_name) + str(dupe_placeholder))
			dupe_placeholder = dupe_placeholder - 1
		value_list.append(value)
	for i in value_list: #debug
		print(i)
	return(value_list)
		
func _ready():
	var group_list = select_group()
	print(group_list)
	for i in group_list:
		var temp_list = find_group(i)
		for a in temp_list:
			button_list.append(a)
	print(button_list)
	button_list.shuffle()
	print(button_list)
	chosen_group = group_list[randi_range(0,3)]
	button()

func button():
	var butt_collection = []
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
		if distancex == 875:
			distancex = 50
			distancey = distancey + 150
		else:
			distancex = distancex + 275
		butt_collection.append(butt)
		#if sort[text] == chosen_group:
			#matching.append(i)
		print(i)
	print(matching)
	print(button_list)
		
		
