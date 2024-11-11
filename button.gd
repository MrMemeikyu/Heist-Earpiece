extends Button

var button_text = 'greg'

func _ready():
	button_text = str(Groups.button_list[0])
	set_text(button_text)


func _on_pressed() -> void:
	if Groups.chosen_group == Groups.sort[button_text]:
		#do good thing
		pass
	else:
		#do bad thing
		pass
