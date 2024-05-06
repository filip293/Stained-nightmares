extends Node3D

@onready var Cutscene = $/root/Node3D/Cutscene
var Player: Camera3D
var Player2: CharacterBody3D
var prompt: Label
var in_car: bool = true
var task: Label
var creature = Node3D
var Crosshair: TextureRect
var canexit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Crosshair = $/root/Node3D/TextureRect
	Player2 = $/root/Node3D/Player
	Player = $/root/Node3D/Player/Neck/SpringArm/Camera
	creature = $/root/Node3D/creature2
	prompt = $Label
	prompt.text = ""
	Player2.visible = false
	Player2.can_move = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Player2.can_move)
	if in_car and Input.is_action_pressed("interact") and Cutscene.MenuStatus == false and canexit == true:
		print(1)
		Player.make_current()
		in_car = false
		Crosshair.visible = true
		prompt.text = ""
		Player2.tasks = "Task 1:" + "\n Go to the laundromat"
		Player2.can_move = true
		Player2.visible = true

func _on_animation_player_animation_finished(Car):
	canexit = true
	prompt.text = "Press E to exit"
	creature.visible = false
	$/root/Node3D/Player/AmbientNoise.play()
