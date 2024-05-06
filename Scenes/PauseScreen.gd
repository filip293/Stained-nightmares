extends Node2D

@onready var Cutscene := $/root/Node3D/Cutscene
@onready var Crosshair = $/root/Node3D/TextureRect
@onready var Task = $/root/Node3D/Player/Task2
@onready var Button1 = $Button
@onready var Button2 = $Button2
@onready var SSlider = $Menu/SensitivitySlider
@onready var VoSlider = $Menu/VolumeSlider
@onready var BrSlider = $Menu/BrightnessSlider

var NRS: Node2D
var esc_pressed: Label
var in_menu: bool = false
var pause_scr: Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_scr = $/root/Node3D/PauseScreen
	esc_pressed = $/root/Node3D/CarCutscene/Label
	NRS = $/root/Node3D/NoteReadScreen
	Button1.disabled = true
	Button2.disabled = true
	SSlider.editable = false
	VoSlider.editable = false
	BrSlider.editable = false
	
	$Menu.visible = false
	
func exit_pause() -> void:
	in_menu = false
	pause_scr.visible = false
	Crosshair.visible = true
	esc_pressed.visible = true
	Task.visible = true
	get_tree().paused = false
	Button1.disabled = true
	Button2.disabled = true
	SSlider.editable = false
	VoSlider.editable = false
	BrSlider.editable = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func enter_pause() -> void:
	in_menu = true
	pause_scr.visible = true
	Crosshair.visible = false
	Task.visible = false
	esc_pressed.visible = false
	get_tree().paused = true
	Button1.disabled = false
	Button2.disabled = false
	SSlider.editable = true
	BrSlider.editable = true
	VoSlider.editable = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

func _unhandled_input(event: InputEvent) -> void:
	if $Menu.visible == true and event.is_action_pressed("esc"):
		$Menu.visible = false
		
	if event is InputEventKey:
		if event.is_action_pressed("esc") and Cutscene.MenuStatus == false and NRS.in_menu == false:
			if pause_scr.visible == false:
				enter_pause()
			elif pause_scr.visible == true:
				exit_pause()

func _on_button_esc_pressed():
	get_tree().quit()

func _on_button_Continue_pressed():
	exit_pause()

func _on_button_3_pressed():
	$/root/Node3D/PauseScreen/Menu/AnimationPlayer.play("Appear")
	$Menu.visible = true

func _on_texture_button_pressed():
	$/root/Node3D/PauseScreen/Menu/AnimationPlayer.play("Dissapear")
	await get_tree().create_timer(0.2).timeout
	$Menu.visible = false
