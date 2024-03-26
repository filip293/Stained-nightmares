extends Node2D

@onready var Cutscene := $/root/Node3D/Cutscene
@onready var Crosshair = $/root/Node3D/TextureRect
@onready var task = $/root/Node3D/Player/Tasks
var in_menu: bool = false
var pause_scr: Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pause_scr = $/root/Node3D/PauseScreen


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("esc") and Cutscene.MenuStatus == false:
			if pause_scr.visible == false:
				in_menu = true
				pause_scr.visible = true
				Crosshair.visible = false
				task.visible = false
				get_tree().paused = true
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			elif pause_scr.visible == true:
				in_menu = false
				pause_scr.visible = false
				Crosshair.visible = true
				task.visible = true
				get_tree().paused = false
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				
		if event.is_action_pressed("esc") and in_menu == true:
			pause_scr.visible == true


func _on_button_esc_pressed():
	get_tree().quit()


func _on_button_Continue_pressed():
	in_menu = false
	pause_scr.visible = false
	Crosshair.visible = true
	task.visible = true
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
