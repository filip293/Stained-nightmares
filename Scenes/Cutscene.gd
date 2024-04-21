extends Node3D

@onready var Player = $/root/Node3D/Player
@onready var ContinueButton = $Button
@onready var QuitButton = $Quit
@onready var BAS = $/root/Node3D/BrightnessAdjustScreen

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

func _ready():
	Player.can_move = false
	intro = $Scary
	Car1 = $/root/Node3D/CarCutscene/CarGo
	Car2 = $/root/Node3D/CarCutscene/Beep
	Car3 = $/root/Node3D/CarCutscene/CarNoGo
	Car = $/root/Node3D/CarCutscene/Car
	Crosshair = $/root/Node3D/TextureRect
	Title = $Title
	secondary_camera = $SceneCam
	Crosshair.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Title.visible = false
	ContinueButton.visible = false
	ContinueButton.disabled = true
	QuitButton.visible = false
	QuitButton.disabled = true

func _process(delta):
	pass

func startgame():
	Title.visible = true
	ContinueButton.visible = true
	ContinueButton.disabled = false
	QuitButton.visible = true
	QuitButton.disabled = false
	intro.play()
	$AnimationPlayer.play("Scene")
	
func _on_button_pressed():
	Player.can_move = true
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
	Car1.play()
	if $/root/Node3D/CarCutscene/BeepTimer:
		$/root/Node3D/CarCutscene/BeepTimer.start()

	if $/root/Node3D/CarCutscene/CarNoGo2:
		$/root/Node3D/CarCutscene/CarNoGo2.start()
	


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
		
func _on_continue_pressed():
	startgame()
