extends Node2D

@onready var Cutscene := $/root/Node3D/Cutscene
@onready var Crosshair = $/root/Node3D/TextureRect
@onready var task = $/root/Node3D/Player/Tasks
var esc_pressed: Label
var in_menu: bool = false
var pause_scr: Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_scr = $/root/Node3D/PauseScreen
	esc_pressed = $/root/Node3D/CarCutscene/Label

func exit_pause() -> void:
	in_menu = false
	pause_scr.visible = false
	Crosshair.visible = true
	esc_pressed.visible = true
	task.visible = true
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func enter_pause() -> void:
	in_menu = true
	pause_scr.visible = true
	Crosshair.visible = false
	task.visible = false
	esc_pressed.visible = false
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("esc") and Cutscene.MenuStatus == false:
			if pause_scr.visible == false:
				enter_pause()
			elif pause_scr.visible == true:
				exit_pause()

func _on_button_esc_pressed():
	get_tree().quit()

func _on_button_Continue_pressed():
	exit_pause()

func _on_visible_on_screen_notifier_monster():
	pass # Replace with function body.
