extends HSlider
@onready var Player := $/root/Node3D/Player
@onready var call = $/root/Node3D/Player/Neck/InteractRay
var savestateval

func _ready() -> void:
	value = Player.mouse_sensitivity
	call.load_data()
	
func _on_value_changed(value):
	Player.mouse_sensitivity = value
	call.save()

func _on_mouse_exited():
	pass # Replace with function body.
