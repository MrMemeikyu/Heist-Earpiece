extends Node2D
var categories = ["animals", "mammals", "colours", "birds", "feelings", "food and drink", "places", "time and seasons", "cold or cool", "hot or warm"]
var words = {"Duck":["animals","birds", "food and drink"], 
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
var category = "none"

const NUM_CORRECT_OPTIONS = 3
const NUM_BUTTONS = 16

func _ready():
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
        butt.pressed.connect(button_click.bind(text))
        if distancex == 875:
            distancex = 50
            distancey = distancey + 150
        else:
            distancex = distancex + 275
        #LOL @ butts
        butt_collection.append(butt)

func button_click(text):
    print("Clicked: " + text)
    var selected_categories = str(words[text])
    print("Categories for this: " + selected_categories)
    if category in selected_categories:
        print("YES!")
    else:
        print("NO. OH NO. NO NO NO.")
