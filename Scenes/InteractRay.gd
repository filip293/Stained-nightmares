extends RayCast3D

# Reference to the prompt label
@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var Cutscene = $/root/Node3D/Cutscene
@onready var player = $/root/Node3D/Player
@onready var metlacam = $/root/Node3D/Player/Metla
@onready var metlabob = $/root/Node3D/Metla/Metla
@onready var metlapromp = $/root/Node3D/Metla
@onready var coinbasket = $/root/Node3D/Root_Scene/RootNode/CoinBasket
@onready var coinbasketbob = $/root/Node3D/Root_Scene/RootNode/CoinBasket/CoinBasket
@onready var coinbasketcam = $/root/Node3D/Player/CoinBasket
@onready var coinbasketpromp = $/root/Node3D/Root_Scene/RootNode/CoinBasket
@onready var coinbasketcoll = $/root/Node3D/Root_Scene/RootNode/CoinBasket/CollisionShape3D
@onready var doorprompt = $/root/Node3D/Motel2/Door_02/Door
@onready var KEY = $/root/Node3D/Key

var optim = {
	"dialogue_started": [false, false, false],
	"dialogue_done": [false, false, false],
	"DustPatchClean": [false, false, false, false],
	"Ending": [false, false, false]
}

var DustPatch1Timer = 10 
var DustPatch2Timer = 20
var DustPatch3Timer = 12
var DustPatch1: StaticBody3D
var DustPatch2: StaticBody3D
var DustPatch3: StaticBody3D
var DP1C: CollisionShape3D
var DP2C: CollisionShape3D
var DP3C: CollisionShape3D
var MC: CollisionShape3D
var CoinKey: StaticBody3D
var CBGV1: StaticBody3D
var CBGV1_1: StaticBody3D
var CBGV1_2: StaticBody3D
var CBGV1_3: StaticBody3D
var CBGV1_4: StaticBody3D
var CBGV2: StaticBody3D
var CBGV2_1: StaticBody3D
var CBGV2_2: StaticBody3D
var CBGV2_3: StaticBody3D
var CBGV2_4: StaticBody3D
var CBGV3: StaticBody3D
var CBGV3_1: StaticBody3D
var CBGV3_2: StaticBody3D
var CBGV3_3: StaticBody3D
var CBGV3_4: StaticBody3D
var CBGV4: StaticBody3D
var CBGV4_1: StaticBody3D
var CBGV4_2: StaticBody3D
var CBGV4_3: StaticBody3D
var CBGV4_4: StaticBody3D
var GuyBob: StaticBody3D
var havekey := false
var metla_inhand := false
var coinbasket_inhand := false
var coinkey := false
var coinbasketfull := false
var donewithroomcheck := false
var route1 := false
var freed := false
var hasPlayedSound := false
var sweepfinish := false
var first_short := false
var first := true
var lighttimer := false
var short_lighttimer := false
var bobhelpplayed := false
var dip := false
var Bob_help := false
var first_time := true
var SoundSweepPlaying := false
var light_done := false
var alreadyplayerd := false
var WaitCar := false
var GoingEnding3 := false
var HasTruckKey := false
var animedone1 := false
var animedone2 := false
var JupscareTimeDone := false
var JumscareDone := false
var DoneDone := false
var ShedCutscene := false
var EndingDone := false

func _ready():
	coinbasketcam.visible = false
	KEY.visible = false
	GuyBob = $/root/Node3D/Guy
	$/root/Node3D/Root_Scene/Label3D.visible = false
	DustPatch1 = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP1
	DustPatch2 = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP2
	DustPatch3 = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP3
	DP1C = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP1/CollisionShape3D
	DP2C = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP2/CollisionShape3D
	DP3C = $/root/Node3D/Root_Scene/RootNode/DustPatch/DP3/CollisionShape3D
	CBGV1 = $/root/Node3D/Root_Scene/RootNode/Laundry_S/CBGV
	CBGV1_1 = $/root/Node3D/Root_Scene/RootNode/Laundry_S/CBGV/CoinBatch1
	CBGV1_2 = $/root/Node3D/Root_Scene/RootNode/Laundry_S/CBGV/CoinBatch2
	CBGV1_3 = $/root/Node3D/Root_Scene/RootNode/Laundry_S/CBGV/CoinBatch3
	CBGV1_4 = $/root/Node3D/Root_Scene/RootNode/Laundry_S/CBGV/CoinBatch4
	CBGV2 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_001/CBGV
	CBGV2_1 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_001/CBGV/CoinBatch1
	CBGV2_2 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_001/CBGV/CoinBatch2
	CBGV2_3 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_001/CBGV/CoinBatch3
	CBGV2_4 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_001/CBGV/CoinBatch4
	CBGV3 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_002/CBGV
	CBGV3_1 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_002/CBGV/CoinBatch1
	CBGV3_2 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_002/CBGV/CoinBatch2
	CBGV3_3 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_002/CBGV/CoinBatch3
	CBGV3_4 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_002/CBGV/CoinBatch4
	CBGV4 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_003/CBGV
	CBGV4_1 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_003/CBGV/CoinBatch1
	CBGV4_2 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_003/CBGV/CoinBatch2
	CBGV4_3 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_003/CBGV/CoinBatch3
	CBGV4_4 = $/root/Node3D/Root_Scene/RootNode/Laundry_S_003/CBGV/CoinBatch4
	CoinKey = $/root/Node3D/Key2
	$/root/Node3D/Motel2/TV_04_004/AnimatedSprite3D.play()
	$/root/Node3D/BOBDEAD.visible = false
	$/root/Node3D/BOBDEAD/Cube_023/StaticBody3D/CollisionShape3D.disabled = true
	$/root/Node3D/Root_Scene/RootNode/basket_002/Key.visible = false
	$/root/Node3D/Root_Scene/RootNode/basket_002/Key/CollisionShape3D.disabled = true
	$/root/Node3D/Truck/Truck/Truck.disabled = true
	
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
			
	if global.route == "BOB":
		route1 = true
		if route1 == true and freed == false:
			if $/root/Node3D/Root_Scene/RootNode/Terrain_01/StaticBody3D != null:
				$/root/Node3D/Root_Scene/RootNode/Terrain_01/StaticBody3D.free()
				freed = true
				
	if global.in_bathroom == true and first == true:
		global.in_bathroom = false
		first = false
		$/root/Node3D/BOBDEAD/BobHelp.play()
		$/root/Node3D/Motel2/Toilet_01_004/Bathroom/Light.start()
		$/root/Node3D/Motel2/Lamps_02_014/OmniLight3D.visible = false
	if lighttimer == true and light_done == false:
		$/root/Node3D/Motel2/Lamps_02_014/OmniLight3D.visible = true
		$/root/Node3D/Motel2/Toilet_01_004/Bathroom/ShorterTime.start()
		$/root/Node3D/BOBDEAD/BobHelp/HelpMeTimer.start()
		lighttimer = false
		light_done = true
		$/root/Node3D/BOBDEAD.visible = true
		$/root/Node3D/Player/Task2/Timer.set_wait_time(0.1)
		if $/root/Node3D/BOBDEAD/Cube_023/StaticBody3D/CollisionShape3D != null:
			$/root/Node3D/BOBDEAD/Cube_023/StaticBody3D/CollisionShape3D.disabled = false
			player.tasks = player.task7
	
	if player.in_store == true and player.tasks == player.task4 and donewithroomcheck == true and hasPlayedSound == false:
		$/root/Node3D/Root_Scene/RootNode/DoorsWood_01/AudioStreamPlayer.play()
		$/root/Node3D/Root_Scene/Label3D.visible = true
		hasPlayedSound = true

	if donewithroomcheck == false and "Key" in prompt.text:
		prompt.text = ""
	elif donewithroomcheck == true:
		if GuyBob != null:
			KEY.visible = true
			GuyBob.free()
	if ShedCutscene == true:
		$/root/Node3D/Player/ScaryAmb.set_volume_db(-10)
		
	if "door" in prompt.text and havekey == true:
		doorprompt.prompt_message = "Open door"
	else:
		doorprompt.prompt_message = "Locked"
		
	if "Closed" in prompt.text and player.tasks == player.task3:
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
		player.tasks = player.task4
		$/root/Node3D/Root_Scene/RootNode/Trees_03/ForestSound.play()
	
	if Input.is_action_just_released("interact") and SoundSweepPlaying:
		if DustPatch1 != null:
			$/root/Node3D/Root_Scene/RootNode/DustPatch/DP1/Sweeping.stop()
		if DustPatch2 != null:
			$/root/Node3D/Root_Scene/RootNode/DustPatch/DP2/Sweeping.stop()
		if DustPatch3 != null:
			$/root/Node3D/Root_Scene/RootNode/DustPatch/DP3/Sweeping.stop()
		SoundSweepPlaying = false
		
	if optim["Ending"][1] == true:
		$/root/Node3D/EndingScreen.visible = true
		$/root/Node3D/EndingScreen/EndingText.text = "ENDING 2/3"
		$/root/Node3D/Player/ScaryAmb.set_volume_db(-10)
		player.tasks = ""
		$/root/Node3D/TextureRect.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if optim["Ending"][2] == true:
		$/root/Node3D/EndingScreen.visible = true
		$/root/Node3D/EndingScreen/EndingText.text = "ENDING 3/3"
		$/root/Node3D/TextureRect.visible = false
		player.tasks = ""
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if optim["DustPatchClean"][0] and optim["DustPatchClean"][1] and optim["DustPatchClean"][2] and !sweepfinish:
				player.tasks = player.task4_2
				sweepfinish = true
	
	if player.tasks == player.task3_2 or player.tasks == player.task4_2:
		if DustPatch1 != null:
			DustPatch1.set_collision_layer_value(2, true)
		if DustPatch2 != null:
			DustPatch2.set_collision_layer_value(2, true)
		if DustPatch3 != null:
			DustPatch3.set_collision_layer_value(2, true)
		metlapromp.set_collision_layer_value(2, true)
	else:
		if DustPatch1 != null:
			DustPatch1.set_collision_layer_value(2, false)
		if DustPatch2 != null:
			DustPatch2.set_collision_layer_value(2, false)
		if DustPatch3 != null:
			DustPatch3.set_collision_layer_value(2, false)
		metlapromp.set_collision_layer_value(2, false)
		
	if player.tasks == player.task6_2 or player.tasks == player.task5_2:
		if CoinKey != null:
			CoinKey.visible = true
			await global.animdone
			CoinKey.set_collision_layer_value(2, true)
	else:
		if CoinKey != null:
			CoinKey.visible = false
			CoinKey.set_collision_layer_value(2, false)
	
	if player.tasks == player.task7_2:
		if coinbasketcoll != null:
			coinbasket.set_collision_layer_value(2, true)
	else:
		if coinbasketcoll != null:
			coinbasket.set_collision_layer_value(2, false)
	
	if coinkey and coinbasket_inhand:
		player.tasks = player.task8_2
		
	if player.tasks == player.task8_2:
		if CBGV1 != null:
			CBGV1.visible = true
			CBGV1_1.set_collision_layer_value(2, true)
			CBGV1_2.set_collision_layer_value(2, true)
			CBGV1_3.set_collision_layer_value(2, true)
			CBGV1_4.set_collision_layer_value(2, true)
		if CBGV2 != null:
			CBGV2.visible = true
			CBGV2_1.set_collision_layer_value(2, true)
			CBGV2_2.set_collision_layer_value(2, true)
			CBGV2_3.set_collision_layer_value(2, true)
			CBGV2_4.set_collision_layer_value(2, true)
		if CBGV3 != null:
			CBGV3.visible = true
			CBGV3_1.set_collision_layer_value(2, true)
			CBGV3_2.set_collision_layer_value(2, true)
			CBGV3_3.set_collision_layer_value(2, true)
			CBGV3_4.set_collision_layer_value(2, true)
		if CBGV4 != null:
			CBGV4.visible = true
			CBGV4_1.set_collision_layer_value(2, true)
			CBGV4_2.set_collision_layer_value(2, true)
			CBGV4_3.set_collision_layer_value(2, true)
			CBGV4_4.set_collision_layer_value(2, true)
	else:
		if CBGV1 != null:
			CBGV1.visible = false
			CBGV1_1.set_collision_layer_value(2, false)
			CBGV1_2.set_collision_layer_value(2, false)
			CBGV1_3.set_collision_layer_value(2, false)
			CBGV1_4.set_collision_layer_value(2, false)
		if CBGV2 != null:
			CBGV2.visible = false
			CBGV2_1.set_collision_layer_value(2, false)
			CBGV2_2.set_collision_layer_value(2, false)
			CBGV2_3.set_collision_layer_value(2, false)
			CBGV2_4.set_collision_layer_value(2, false)
		if CBGV3 != null:
			CBGV3.visible = false
			CBGV3_1.set_collision_layer_value(2, false)
			CBGV3_2.set_collision_layer_value(2, false)
			CBGV3_3.set_collision_layer_value(2, false)
			CBGV3_4.set_collision_layer_value(2, false)
		if CBGV4 != null:
			CBGV4.visible = false
			CBGV4_1.set_collision_layer_value(2, false)
			CBGV4_2.set_collision_layer_value(2, false)
			CBGV4_3.set_collision_layer_value(2, false)
			CBGV4_4.set_collision_layer_value(2, false)
				
func _physics_process(delta) -> void:
	if is_colliding():
		var detected = get_collider()
		if "Talk" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				if optim["dialogue_started"][0] == false and player.tasks == player.task2:
					player.can_move = false
					optim["dialogue_started"][0] = true
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					$/root/Node3D/Player/Neck/AnimationPlayer.stop()
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "start")
					await DialogueManager.dialogue_ended
					optim["dialogue_started"][0] = false
					optim["dialogue_done"][0] = true
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					player.can_move = true
					if global.route == "Motel":
						player.tasks = player.task3
					else:
						player.tasks = player.task3_2
				
				elif optim["dialogue_done"][0] and player.tasks == player.task3_2 and !dip:
					player.can_move = false
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					$/root/Node3D/Player/Neck/AnimationPlayer.stop()
					dip = true
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "wait")
					await DialogueManager.dialogue_ended
					dip = false
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					player.can_move = true
				
				elif optim["dialogue_done"][0] and player.tasks == player.task4_2 and !dip:
					dip = true
					player.can_move = false
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					$/root/Node3D/Player/Neck/AnimationPlayer.stop()
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "wait1")
					await DialogueManager.dialogue_ended
					dip = false
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					player.can_move = true
				
				elif optim["dialogue_done"][0] == true and optim["dialogue_started"][1] == false and player.tasks == player.task5_2:
					player.can_move = false
					optim["dialogue_started"][1] = true
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					$/root/Node3D/Player/Neck/AnimationPlayer.stop()
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "finished_sweeping")
					await DialogueManager.dialogue_ended
					optim["dialogue_started"][1] = false
					optim["dialogue_done"][1] = true
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					player.can_move = true
					player.tasks = player.task6_2
				
				elif optim["dialogue_done"][1] and player.tasks == player.task6_2 and !dip:
					dip = true
					player.can_move = false
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					$/root/Node3D/Player/Neck/AnimationPlayer.stop()
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Bob.dialogue"), "wait2")
					await DialogueManager.dialogue_ended
					dip = false
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					player.can_move = true
				
				else:
					pass
		
		if Input.is_action_just_pressed("interact"):
				if "Key" in prompt.text and havekey == false:
					$/root/Node3D/Key.free()
					havekey = true
					player.tasks = player.task5
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
				if sweepfinish:
					player.tasks = player.task5_2
		
		if "Grab coin basket" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				coinbasketbob.visible = false
				coinbasketcam.visible = true
				coinbasket_inhand = true
				coinbasketpromp.prompt_message = "Leave coin basket"
		
		if "Leave coin basket" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				coinbasketbob.visible = true
				coinbasketcam.visible = false
				coinbasket_inhand = false
				if coinbasketfull:
					if coinbasketcoll != null:
						coinbasketcoll.free()
				elif !coinbasketfull:
					coinbasketpromp.prompt_message = "Grab coin basket"
		
		if "Grab kеy" in prompt.text:
			if Input.is_action_just_pressed("interact"):
				CoinKey.free()
				coinkey = true
				
		if Input.is_action_pressed("interact") and metla_inhand == true:
			if "Clean up dust" in prompt.text:
				$/root/Node3D/Player/MetlaSweep.play("Sweep")
				if !SoundSweepPlaying:
					$/root/Node3D/Root_Scene/RootNode/DustPatch/DP1/Sweeping.play()
					SoundSweepPlaying = true
				DustPatch1Timer -= 0.05
				if DustPatch1Timer < 0.1:
					if DustPatch1 != null and optim["DustPatchClean"][0] == false:
						optim["DustPatchClean"][0] = true
						$/root/Node3D/Root_Scene/RootNode/DustPatch/DP1/Sweeping.stop()
						$/root/Node3D/Player/MetlaSweep.stop()
						DustPatch1.free()
						
				else:
					pass
			
			elif "Clеan up dust" in prompt.text:
				$/root/Node3D/Player/MetlaSweep.play("Sweep")
				if !SoundSweepPlaying:
					$/root/Node3D/Root_Scene/RootNode/DustPatch/DP2/Sweeping.play()
					SoundSweepPlaying = true
				DustPatch2Timer -= 0.05
				if DustPatch2Timer < 0.1:
					if DustPatch2 != null and optim["DustPatchClean"][1] == false:
						$/root/Node3D/Root_Scene/RootNode/DustPatch/DP2/Sweeping.stop()
						$/root/Node3D/Player/MetlaSweep.stop()
						DustPatch2.free()
						optim["DustPatchClean"][1] = true
				else:
					pass
			
			elif "Clеаn up dust" in prompt.text:
				$/root/Node3D/Player/MetlaSweep.play("Sweep")
				if !SoundSweepPlaying:
					$/root/Node3D/Root_Scene/RootNode/DustPatch/DP3/Sweeping.play()
					SoundSweepPlaying = true
				DustPatch3Timer -= 0.05
				if DustPatch3Timer < 0.1:
					if DustPatch3 != null and optim["DustPatchClean"][2] == false:
						$/root/Node3D/Root_Scene/RootNode/DustPatch/DP3/Sweeping.stop()
						$/root/Node3D/Player/MetlaSweep.stop()
						DustPatch3.free()
						optim["DustPatchClean"][2] = true
				else:
					pass
		
		else:
			$/root/Node3D/Player/MetlaSweep.pause()
			
	if Input.is_action_just_pressed("interact"):
		if "note" in prompt.text:
			$/root/Node3D/BOBDEAD/Cube_023/StaticBody3D.visible = false
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/HotelRoom.dialogue"), "note")
			player.tasks = player.task8
			$/root/Node3D/Player/ScaryAmb.play()
			var red = Color(0.7, 0.0, 0.0, 1.0)
			global.otherambient = true
			$/root/Node3D/Player/Task2.set("modulate", red)
			$/root/Node3D/BOBDEAD/Cube_023/StaticBody3D/CollisionShape3D.free()
			$/root/Node3D/Root_Scene/RootNode/basket_002/Key.visible = true
			$/root/Node3D/Root_Scene/RootNode/basket_002/Key/CollisionShape3D.disabled = false
			$/root/Node3D/Root_Scene/RootNode/basket_002/StaticBody3D/CollisionShape3D.disabled = true
			
	if Input.is_action_just_pressed("interact"):
		if "Car" in prompt.text:
			HasTruckKey = true
			$/root/Node3D/Root_Scene/RootNode/basket_002/Key.visible = false
			$/root/Node3D/Root_Scene/RootNode/basket_002/Key/CollisionShape3D.disabled = true
			player.tasks = player.task9
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/HotelRoom.dialogue"), "run")
			$/root/Node3D/Truck/Truck/Truck.disabled = false
			$/root/Node3D/Truck/StaticBody3D/CollisionShape3D.disabled = true
			
	if Input.is_action_just_pressed("interact"):
		if "Bell" in prompt.text:
			$/root/Node3D/Root_Scene/RootNode/counter_bell/AudioStreamPlayer3D.play()
			
	if Input.is_action_just_pressed("interact"):
		if "Truck" in prompt.text:
			$/root/Node3D/Truck/GetIntoCar.play()
			$/root/Node3D/Truck/Truck/Truck.disabled = true
			$/root/Node3D/Player.visible = false
			$/root/Node3D/Truck/TruckCamera.make_current()
			$/root/Node3D/Truck/Waitfordrive.start()
	if WaitCar == true and alreadyplayerd == false:
		$/root/Node3D/Truck/Drive.play()
		$/root/Node3D/Truck/Ending.start()
		alreadyplayerd = true
		
	if EndingDone == true:
		optim["Ending"][1] = true

	if GoingEnding3 == true:
		ShedCutscene = true
		player.can_move = false
		$/root/Node3D/Shed/Ca/Camera3D.make_current()
		$/root/Node3D/Shed/Ca/OutOfBreath.play()
		$/root/Node3D/Shed/Ca/AnimationPlayer.play("ShedEnding")
		GoingEnding3 = false
	if animedone1 == true and DoneDone == false:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/HotelRoom.dialogue"), "end3")
		DoneDone = true
		await DialogueManager.dialogue_ended
		$/root/Node3D/Shed/Ca/AnimationPlayer.play("TurnToMonster")
		$/root/Node3D/Shed/Ca/Jumpscare/Timer.start()
	if JupscareTimeDone == true and JumscareDone == false:
		JumscareDone = true
		$/root/Node3D/Shed/Ca/Jumpscare.play()

func _on_forest_sound_finished():
		player.can_move = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$/root/Node3D/Player/Neck/AnimationPlayer.stop()
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/HotelRoom.dialogue"), "forest")
		await DialogueManager.dialogue_ended
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		player.can_move = true

func _on_bathroom_body_entered(body):
	if player.error_time == true:
		global.in_bathroom = true

func _on_bathroom_body_exited(body):
	if player.error_time == true:
		global.in_bathroom = false

func _on_main_room_body_entered(body):
	if player.tasks == player.task5 and first_time == true:
		player.tasks = player.task6
		first_time = false


func _on_animated_sprite_3d_animation_finished():
	$/root/Node3D/Motel2/TV_04_004/AnimatedSprite3D.play()


func _on_light_timeout():
	if light_done == false:
		lighttimer = true


func _on_scary_amb_finished():
	if global.otherambient == true:
		$/root/Node3D/Player/ScaryAmb.play()


func _on_waitfordrive_timeout():
	WaitCar = true


func _on_area_3d_body_entered(body):
	if HasTruckKey == true:
		GoingEnding3 = true


func _on_animation_player_animation_finished(ShedEnding):
	animedone1 = true


func _on_animation_player_animation2_finished(TurnToMonster):
	animedone2 = true


func _on_timerJumpscare_timeout():
	JupscareTimeDone = true


func _on_jumpscare_finished():
	optim["Ending"][2] = true


func _on_buttonQuit_pressed():
	get_tree().quit()


func _on_ending_timeout():
	EndingDone = true
