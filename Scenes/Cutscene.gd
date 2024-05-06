extends Node3D

@onready var Player = $/root/Node3D/Player
@onready var ContinueButton = $Button
@onready var QuitButton = $Quit

var intro: AudioStreamPlayer
var Car1: AudioStreamPlayer
var Car2: AudioStreamPlayer
var Car3: AudioStreamPlayer
var Car: Camera3D
var secondary_camera: Camera3D
var button_pressed: bool = false
var is_done : bool = true
var is_done2 : bool = true
var MenuStatus: bool = true
var Crosshair: TextureRect
var Title: Label
var Credits: Label


func _ready():
	Player.can_move = false
	intro = $Scary
	Car1 = $/root/Node3D/CarCutscene/CarGo
	Car2 = $/root/Node3D/CarCutscene/Beep
	Car3 = $/root/Node3D/CarCutscene/CarNoGo
	Car = $/root/Node3D/CarCutscene/Car
	Crosshair = $/root/Node3D/TextureRect
	Credits = $Label
	Title = $Title
	secondary_camera = $SceneCam
	Crosshair.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$/root/Node3D/Cutscene/Scary.play()
	$AnimationPlayer.play("Scene")
	$/root/Node3D/PauseScreen.visible = false

func _process(delta):
	pass

	
func _on_button_pressed():
	MenuStatus = false
	Title.visible = false
	Car.make_current()
	intro.stop()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	button_pressed = true
	$Button.visible = false
	$Quit.visible = false
	$/root/Node3D/Player/Metla.visible = false
	$/root/Node3D/CarCutscene/Smoke.visible = false
	$/root/Node3D/CarCutscene/AnimationPlayer.play("Car")
	is_done = false
	is_done2 = false
	Credits.visible = false
	Car1.play()

	if $/root/Node3D/CarCutscene/BeepTimer:
		$/root/Node3D/CarCutscene/BeepTimer.start()

	if $/root/Node3D/CarCutscene/CarNoGo2:
		$/root/Node3D/CarCutscene/CarNoGo2.start()
		
		
	await get_tree().create_timer(1).timeout
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "bob_in_car")
	await get_tree().create_timer(10).timeout
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "bob_cargobrr")
	await get_tree().create_timer(12).timeout
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "bob_see_laun")



func _on_quit_pressed():
	get_tree().quit()


func _on_timer_timeout():
	if !is_done:
		Car2.play()
		is_done = true


func _on_car_no_go_timeout():
	if !is_done2:
		Car3.play()
		$/root/Node3D/CarCutscene/Smoke.visible = true
		is_done2 = true
