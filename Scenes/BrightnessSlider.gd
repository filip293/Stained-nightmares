extends HSlider
@onready var GWEnvironment := $/root/Node3D/WorldEnvironment
@onready var DirLight := $/root/Node3D/Root_Scene/RootNode/Terrain/DirectionalLight3D

func _ready():
	value = GWEnvironment.environment.adjustment_brightness
	DirLight.light_energy = 0.008
	
func _on_value_changed(value):
	GWEnvironment.environment.adjustment_brightness = value

func _on_mouse_exited():
	pass # Replace with function body.
