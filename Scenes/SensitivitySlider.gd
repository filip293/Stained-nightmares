extends HSlider
@onready var Player := $/root/Node3D/Player

func _ready() -> void:
	value = Player.mouse_sensitivity
	
func _on_value_changed(value):
	Player.mouse_sensitivity = value

func _on_mouse_exited():
	pass # Replace with function body.
