extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text('Select items that fit the category: ' + str(Groups.chosen_group))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
