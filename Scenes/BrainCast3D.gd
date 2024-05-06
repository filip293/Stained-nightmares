extends RayCast3D

# Reference to the prompt label
@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var player = $/root/Node3D/Player
@onready var animplayer = $AnimationPlayer
@onready var monster = $/root/Node3D/Root_Scene/RootNode/CreatureForEnding
@onready var playerinteract = $/root/Node3D/Player/Neck/SpringArm/Camera/InteractRay
@onready var camera1 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_003/Camera3D
@onready var camera2 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_003/Camera3D2
@onready var camera3 = $/root/Node3D/House
var hasnotrun: bool = false
var on_screen: bool = false
var itsgotime: bool = false

func _ready():
	monster.visible = false

func _physics_process(delta) -> void:
	pass
		
func _process(delta):
	if is_colliding() and itsgotime:
		var detected = get_collider()
		if detected.has_method("get_prompt"):
			var detected_word = detected.get_prompt()
			if detected_word == "Player" and on_screen == true and !hasnotrun:
				hasnotrun = true
				player.can_move = false
				player.visible = false
				playerinteract.dip = true
				camera1.make_current()
				await get_tree().create_timer(1.7).timeout
				DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "ohifuckedup")
				camera2.make_current()
				animplayer.play("youdonefuckeduo")
				monster.visible = true
				await get_tree().create_timer(0.8).timeout
				$AudioStreamPlayer.play()
				await get_tree().create_timer(4.3).timeout
				$AudioStreamPlayer2.play()
				

func _on_visible_on_screen_notifier_3d_screen_entered():
	on_screen = true

func _on_visible_on_screen_notifier_3d_screen_exited():
	on_screen = false

func _on_detect_player_body_entered(body):
	animplayer.play("open_thing")
	await get_tree().create_timer(1.1).timeout
	itsgotime = true
	
