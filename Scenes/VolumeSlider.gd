extends HSlider

@export var audio_bus_name := "Master"
var save_file_path = "user://save/"

@onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func save():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(value)
	
func load_data():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		value = file.get_var(value)

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))
	load_data()


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))
	save()


func _on_mouse_exited():
	pass # Replace with function body.
