extends Area2D

signal release
var lifted = false
var zoom_possible = false
var zoom_step: Vector2

func _ready():
	zoom_step = Vector2(0.05, 0.05)
	
func _on_input_event(viewport, event, shape_idx):
	if !lifted and Input.is_action_pressed("cam_drag"):
		lifted = true
		
func _physics_process(delta):
	if lifted:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	if zoom_possible:
		if Input.is_action_just_pressed("cam_zoom_in"):
			if scale >= Vector2(0.550, 0.550):
				scale = Vector2(0.550, 0.550)
			else:
				scale += zoom_step
		if Input.is_action_just_pressed("cam_zoom_out"):
			if scale <= Vector2(0.255, 0.255):
				scale = Vector2(0.255, 0.255)
			else:
				scale -= zoom_step

func _on_mouse_entered():
	zoom_possible = true

func _on_mouse_exited():
	zoom_possible = false
