extends TileMapLayer
const new_label = preload("res://mac.tscn")

const atlasLookup = {
    "computer": Vector2i(4, 8),
    "camera": Vector2i(12, 9),
    "door": Vector2i(4, 7),
    "laser": Vector2(0, 9)
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
   

func update_look(arr: Array):
    clear()
    for c in get_children():
        c.queue_free()
    for tile in arr:
        var loc = Vector2i(int(tile["location"].split(",")[0].trim_prefix("(")), int(tile["location"].split(",")[1].trim_suffix(")")))
        set_cell(loc, 0, atlasLookup[tile["type"]])
        var new_lab = new_label.instantiate()
        new_lab.text = tile["mac_address"]
        add_child(new_lab)
        new_lab.position = Vector2(loc) * Vector2(16, 16) + Vector2(-32, 16)
