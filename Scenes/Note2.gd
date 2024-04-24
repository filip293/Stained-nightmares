extends Area2D

@onready var NRS = $/root/Node3D/NoteReadScreen
signal release
var lifted = false
var zoom_possible = false
var zoom_step: Vector2
var offset = Vector2(0, 0)

func _ready():
	zoom_step = Vector2(0.01, 0.01)

func _physics_process(delta):
	if NRS.in_menu and lifted:
		position = get_global_mouse_position() - offset
	if NRS.in_menu and zoom_possible:
		if Input.is_action_just_pressed("cam_zoom_in"):
			if scale >= Vector2(0.2, 0.2):
				scale = Vector2(0.2, 0.2)
			else:
				scale += zoom_step
		if Input.is_action_just_pressed("cam_zoom_out"):
			if scale <= Vector2(0.05, 0.05):
				scale = Vector2(0.05, 0.05)
			else:
				scale -= zoom_step

func _on_mouse_entered():
	zoom_possible = true

func _on_mouse_exited():
	zoom_possible = false

func _on_button_button_down():
	lifted = true
	offset = get_global_mouse_position() - global_position

func _on_button_button_up():
	lifted = false
