extends HSlider
@onready var Player := $/root/Node3D/Player
var save_file_path = "user://save_sens.dat"

func save():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(value)
	
func load_data():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		Player.mouse_sensitivity = file.get_var(value)

func _ready() -> void:
	load_data()
	value = Player.mouse_sensitivity
	
func _on_value_changed(value):
	Player.mouse_sensitivity = value
	save()

func _on_mouse_exited():
	pass # Replace with function body.
