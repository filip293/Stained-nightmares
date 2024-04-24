extends HSlider


@export var audio_bus_name := "Master"
var savestateval

@onready var _bus := AudioServer.get_bus_index(audio_bus_name)
@onready var call = $/root/Node3D/Player/Neck/InteractRay


func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))
	call.load_data()


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))
	savestateval = value
	call.save()


func _on_mouse_exited():
	pass # Replace with function body.
