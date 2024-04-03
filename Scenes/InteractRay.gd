extends RayCast3D

# Reference to the prompt label
@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var Cutscene = $/root/Node3D/Cutscene
@onready var player = $/root/Node3D/Player
@onready var metlacam = $/root/Node3D/Player/Metla
@onready var metlabob = $/root/Node3D/Metla/Metla
@onready var metlapromp = $/root/Node3D/Metla
@onready var doorprompt = $/root/Node3D/Motel2/Door_02/Door
@onready var KEY = $/root/Node3D/Key
var DustPatch1: StaticBody3D
var DustPatch1Timer = 10 
var DustPatch2: StaticBody3D
var DustPatch2Timer = 20
var DustPatch3: StaticBody3D
var DustPatch3Timer = 12
var GuyBob: StaticBody3D
var havekey: bool = false
var dialogue_started1: bool = false
var dialogue_started2: bool = false
var dialogue_started3: bool = false
var dialogue_done1: bool = false
var dialogue_done2: bool = false
var dialogue_done3: bool = false
var metla_inhand: bool = false
var donewithroomcheck: bool = false
var route1: bool = false
var freed: bool = false
var hasPlayedSound: bool = false
var DustPatch1Clean: bool = false
var dp1s: bool = false
var dp2s: bool = false
var dp3s: bool = false


func _ready():
	KEY.visible = false
	GuyBob = $/root/Node3D/Guy
	$/root/Node3D/Root_Scene/Label3D.visible = false
	DustPatch1 = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP1
	DustPatch2 = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP2
	DustPatch3 = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP3
# Called every frame
func _process(delta):
	var car_cutscene = $/root/Node3D/CarCutscene
	# Check if the player is in the car
	if car_cutscene.in_car == false:
		prompt.text = ""
	else:
		return
		
	if is_colliding():
		var detected = get_collider()
		# Check if the detected object has the 'get_prompt' method
		if detected and detected.has_method("get_prompt"):
			prompt.text = detected.get_prompt()
			
	if global.route == "Get the broom":
		route1 = true
		if route1 == true and freed == false:
			if $/root/Node3D/Root_Scene/RootNode/Terrain_01/StaticBody3D != null:
				$/root/Node3D/Root_Scene/RootNode/Terrain_01/StaticBody3D.free()
				freed = true
				
	if player.in_store == true and player.task.text == player.task4 and donewithroomcheck == true and hasPlayedSound == false:
		$/root/Node3D/Root_Scene/RootNode/DoorsWood_01/AudioStreamPlayer.play()
		$/root/Node3D/Root_Scene/Label3D.visible = true
		hasPlayedSound = true

	if donewithroomcheck == false and "Key" in prompt.text:
		prompt.text = ""
	elif donewithroomcheck == true:
		if GuyBob != null:
			KEY.visible = true
			GuyBob.free()
		
	if "door" in prompt.text and havekey == true:
		doorprompt.prompt_message = "Open door"
	else:
		doorprompt.prompt_message = "Locked"
		
	if "Closed" in prompt.text and player.task.text == player.task3:
		$/root/Node3D/Root_Scene/RootNode/Terrain_01/StaticBody3D.free()
		prompt.text = ""
		donewithroomcheck = true
		player.can_move = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$/root/Node3D/Player/Neck/AnimationPlayer.stop()
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/HotelRoom.dialogue"), "start")
		await DialogueManager.dialogue_ended
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		player.can_move = true
		player.task.text = player.task4
		
func _physics_process(delta) -> void:
	if is_colliding():
		var detected = get_collider()
		if "Talk" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				if dialogue_started1 == false and player.task.text == player.task2:
					player.can_move = false
					dialogue_started1 = true
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					$/root/Node3D/Player/Neck/AnimationPlayer.stop()
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "start")
					await DialogueManager.dialogue_ended
					dialogue_started1 = false
					dialogue_done1 = true
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					player.can_move = true
					if global.route == "Motel":
						player.task.text = player.task3
					else:
						player.task.text = player.task3_2
				
				elif dialogue_done1 == true and player.task.text == player.task3_2:
					player.can_move = false
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					$/root/Node3D/Player/Neck/AnimationPlayer.stop()
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob_hold.dialogue"), "start")
					await DialogueManager.dialogue_ended
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					player.can_move = true
				
				else:
					pass
		
		if Input.is_action_just_pressed("interact"):
				if "Key" in prompt.text and havekey == false:
					$/root/Node3D/Key.free()
					havekey = true
					$/root/Node3D/Motel2/Door_02/Door/CollisionShape3D.free()
		
		if "Pick up broom" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				metlabob.visible = false
				metlacam.visible = true
				metla_inhand = true
				metlapromp.prompt_message = "Leave the broom"
		
		if "Leave the broom" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				metlabob.visible = true
				metlacam.visible = false
				metla_inhand = false
				metlapromp.prompt_message = "Pick up broom"
				
		if Input.is_action_pressed("interact") and metla_inhand == true:
			if "Clean up dust" in prompt.text:
				$/root/Node3D/Player/MetlaSweep.play("Sweep")
				DustPatch1Timer -= 0.05
				if DustPatch1Timer < 0.1:
					if DustPatch1 != null and dp1s == false:
						dp1s = true
						$/root/Node3D/Player/MetlaSweep.stop()
						DustPatch1.free()
						
				else:
					pass
			
			elif "Clеan up dust" in prompt.text:
				$/root/Node3D/Player/MetlaSweep.play("Sweep")
				DustPatch2Timer -= 0.05
				if DustPatch2Timer < 0.1:
					if DustPatch2 != null and dp2s == false:
						$/root/Node3D/Player/MetlaSweep.stop()
						DustPatch2.free()
						dp2s = true
				else:
					pass
			
			elif "Clеаn up dust" in prompt.text:
				$/root/Node3D/Player/MetlaSweep.play("Sweep")
				DustPatch3Timer -= 0.05
				if DustPatch3Timer < 0.1:
					if DustPatch3 != null and dp3s == false:
						$/root/Node3D/Player/MetlaSweep.stop()
						DustPatch3.free()
						dp3s = true
				else:
					pass
		else:
			$/root/Node3D/Player/MetlaSweep.pause()




func _on_forest_sound_finished():
	pass # Replace with function body. 		$/root/Node3D/Root_Scene/RootNode/Trees_03/ForestSound
