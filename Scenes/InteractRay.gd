extends RayCast3D

# Reference to the prompt label
@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var Cutscene = $/root/Node3D/Cutscene
@onready var player = $/root/Node3D/Player
var dialogue_started1: bool = false
var dialogue_started2: bool = false
var dialogue_started3: bool = false
var dialogue_done1: bool = false
var dialogue_done2: bool = false
var dialogue_done3: bool = false


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
		if detected.has_method("get_prompt"):
			prompt.text = detected.get_prompt()
		
func _physics_process(delta) -> void:
	if is_colliding():
		var detected = get_collider()
		if "Talk" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				if dialogue_started1 == false and player.task.text == player.task2:
					player.can_move = false
					dialogue_started1 = true
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
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
				else:
					pass
					
	if is_colliding():
		if "Door" in prompt.text:
			print("door")
