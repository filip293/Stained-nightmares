extends HSlider
@onready var GWEnvironment := $/root/Node3D/WorldEnvironment
@onready var DirLight := $/root/Node3D/Root_Scene/RootNode/Terrain/DirectionalLight3D
var save_file_path = "user://save/"


func save():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(value)
	
func load_data():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		value = file.get_var(value)

func _ready():
	value = GWEnvironment.environment.adjustment_brightness
	DirLight.light_energy = 0.008
	load_data()
	
func _on_value_changed(value):
	GWEnvironment.environment.adjustment_brightness = value
	save()

func _on_mouse_exited():
	pass # Replace with function body.
