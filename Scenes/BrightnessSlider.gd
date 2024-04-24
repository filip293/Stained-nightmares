extends HSlider
@onready var GWEnvironment := $/root/Node3D/WorldEnvironment
@onready var DirLight := $/root/Node3D/Root_Scene/RootNode/Terrain/DirectionalLight3D
@onready var call = $/root/Node3D/Player/Neck/InteractRay
var savestateval

func _ready():
	value = GWEnvironment.environment.adjustment_brightness
	DirLight.light_energy = 0.008
	call.load_data()
	
func _on_value_changed(value):
	GWEnvironment.environment.adjustment_brightness = value
	savestateval = value
	call.save()

func _on_mouse_exited():
	pass # Replace with function body.
