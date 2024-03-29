extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed = 4.0							#used for speed
var mouse_sensitivity = 1
var sprint_multip = 1.6					#used for making faster than walking
var footstep_timer = 0.0				#used for honestly no idea (footstep timing)
var footstep_interval = 0.5				#used for footstep interval while walking
var footstep_running_interval = 0.26	#used for footstep interval while sprinting
var sprintcooldown = 2
var sprint_cooldown = 5				#used for cooldown of sprinting
var times_in_store = 0				#used for times entered in area 3D

var footstep_left_sound: AudioStreamPlayer3D
var footstep_right_sound: AudioStreamPlayer3D
var sprint_cooldown_bar = ProgressBar
var task: Label

var is_right_foot = true
var current_task = 1				#used for task state
var error_time: bool = false		#used for start of game area error
var is_sprinting: bool = false		#used for state of sprinting
var can_move: bool = true
var monster_on_screen: bool = false

var Crosshair: TextureRect


var task2 = "Task 2: \n Talk to Bob"
var task3 = "Task 3: \n Go to the motel"
var task3_2 = "Task 3: \n Help Bob"
var task5 = "Talk to Bob"
var task6 = "Talk to Bob"



func _ready():
	sprint_cooldown_bar = $/root/Node3D/Player/sprint_cooldown_bar
	task = $Tasks
	footstep_left_sound = $FootstepLeftSound
	footstep_right_sound = $FootstepRightSound
	Crosshair = $/root/Node3D/TextureRect
	task.text = ""

func _process(delta):
	if monster_on_screen == true:
		print("onscreen")
	
	if !Input.is_action_pressed("sprint") and sprintcooldown < 2:
		sprintcooldown += 0.2

	if !Input.is_action_pressed("sprint"):
		is_sprinting = false
	sprint_cooldown_bar.value = sprint_cooldown
	if sprint_cooldown > 4.5:
		sprint_cooldown_bar.visible = false
	else:
		sprint_cooldown_bar.visible = true

	if is_sprinting == true and sprint_cooldown > 0:
		sprint_cooldown -= 0.02
		sprintcooldown -= 0.3
	elif is_sprinting == false and sprint_cooldown < 5 and sprintcooldown > 0.5:
		sprint_cooldown += 0.007

func get_input():
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	if can_move == true:
		velocity.x = movement_dir.x * speed
		velocity.z = movement_dir.z * speed
		if Input.is_action_pressed("sprint") and sprint_cooldown > 0.3:
			velocity.z *= sprint_multip
			velocity.x *= sprint_multip
		if Input.is_action_pressed("sprint") and sprint_cooldown > 0.3:
			if input.y>0 or input.x>0:
				is_sprinting = true
				$Neck/AnimationPlayer.play("intense head bob")
			elif input.y<0 or input.x<0:
				is_sprinting = true
				$Neck/AnimationPlayer.play("intense head bob")
			else:
				$Neck/AnimationPlayer.stop()
	
		elif !Input.is_action_pressed("sprint"):
			if input.y>0 or input.x>0:
				$Neck/AnimationPlayer.play("head bob")
			elif input.y<0 or input.x<0:
				$Neck/AnimationPlayer.play("head bob")
			else:
				$Neck/AnimationPlayer.stop()
	elif can_move == false: 
		pass

func _physics_process(delta):
	velocity.y += -gravity * delta
	get_input()
	move_and_slide()
	
	var sprint = Input.is_action_pressed("sprint")
	var moving_forward = Input.get_action_strength("move_forward") > 0
	var moving_right = Input.get_action_strength("move_right") > 0
	var moving_backward = Input.get_action_strength("move_backward") > 0
	var moving_left = Input.get_action_strength("move_left") > 0
	var moving = moving_forward or moving_right or moving_left or moving_backward
	var sprinting = sprint and (moving_forward or moving_right or moving_left or moving_backward) and sprint_cooldown > 1
	if can_move == true:
		if sprinting:
			footstep_timer += delta
			if footstep_timer >= footstep_running_interval:
				footstep_timer = 0.0
				if is_right_foot:
					footstep_right_sound.play()
				else:
					footstep_left_sound.play()
				is_right_foot = !is_right_foot
		elif moving:
			footstep_timer += delta
			if footstep_timer >= footstep_interval:
				footstep_timer = 0.0
				if is_right_foot:
					footstep_right_sound.play()
				else:
					footstep_left_sound.play()
				is_right_foot = !is_right_foot
	if can_move == false:
		pass
		
@onready var neck := $Neck
@onready var camera := $Neck/SpringArm/Camera

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity * -1))
		
		var camera_rot = neck.rotation_degrees
		
		var rotation_to_apply_on_x_axis = (-event.relative.y * mouse_sensitivity);
		
		if (camera_rot.x + rotation_to_apply_on_x_axis < -70):
			camera_rot.x = -70
		elif (camera_rot.x + rotation_to_apply_on_x_axis > 70):
			camera_rot.x = 70
		else:
			camera_rot.x += rotation_to_apply_on_x_axis;
		
		neck.rotation_degrees = camera_rot
			
func _on_store_body_entered(body):
	print("instore")
	if times_in_store == 0 and error_time == true:
		task.text = task2
		times_in_store += 1
		current_task += 1
		print(times_in_store)

func _on_store_body_exited(body):
	print("exit")


func _on_timer_timeout():
	error_time = true
	
func get_prompt() -> String:			#Add prompt player for monster detect
	return "Player"
