extends Node2D

@onready var WelcomeScreen = $Welcome
@onready var BAScreen = $BrightnessAdjust
@onready var BAScreenSlider = $BrightnessAdjust/BrightnessSlider
@onready var BAScreenButton = $BrightnessAdjust/Continue
@onready var call = $/root/Node3D/Player/Neck/InteractRay
@onready var Intro = $/root/Node3D/Cutscene
var alreadydonedid: bool

func _ready():
	call.load_data()
	if alreadydonedid == true:
		BAScreenSlider.editable = false
		BAScreenButton.disabled = true
		BAScreen.visible = false
		WelcomeScreen.visible = false
		Intro.startgame()
	else:
		BAScreenSlider.editable = false
		BAScreenButton.disabled = true
		BAScreen.visible = false
		

func _on_kill_switch_pressed():
	BAScreenSlider.editable = true
	BAScreenButton.disabled = false
	BAScreen.visible = true
	WelcomeScreen.visible = false

func _on_continue_pressed():
	BAScreenSlider.editable = false
	BAScreenButton.disabled = true
	BAScreen.visible = false
	alreadydonedid = true
	call.save()
