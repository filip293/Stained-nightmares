extends Node2D

@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var Cutscene := $/root/Node3D/Cutscene
@onready var Crosshair = $/root/Node3D/TextureRect
@onready var Task = $/root/Node3D/Player/Task2
@onready var OBJ_ID = $/root/Node3D/CarCutscene/OBJ_ID
@onready var player = $/root/Node3D/Player

signal resume_after_disclaimer
var in_menu: bool = false
var disc_shown: bool = false
var disc_showing: bool = false
var disc: Node2D
var note: Node2D
var note1: Node2D
var note2: Node2D
var text: Label
# Called when the node enters the scene tree for the first time.

func _ready():
	disc = $Disclaimer
	note = $Notes
	note1 = $Note1/Note
	note2 = $Note2/Note
	disc.visible = false
	note.visible = false
	note1.visible = false
	note2.visible = false

func exit_notes() -> void:
	player.can_move = true
	in_menu = false
	note.visible = false
	if note1.visible == true:
		note1.visible = false
	if note2.visible == true:
		note2.visible = false
	Crosshair.visible = true
	Task.visible = true
	disc_showing = false
	prompt.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func enter_notes() -> void:
	player.can_move = false
	in_menu = true
	note.visible = true
	if OBJ_ID.text == "note1":
		note1.visible = true
	elif OBJ_ID.text == "note2":
		note2.visible = true
	Crosshair.visible = false
	Task.visible = false
	prompt.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func enter_notes_first() -> void:
	player.can_move = false
	in_menu = true
	disc.visible = true
	Crosshair.visible = false
	Task.visible = false
	disc_showing = true
	prompt.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await resume_after_disclaimer
	note.visible = true
	if OBJ_ID.text == "note1":
		note1.visible = true
	elif OBJ_ID.text == "note2":
		note2.visible = true
	disc_shown = true

func _process(delta) -> void:
	if "Read note" in prompt.text and OBJ_ID.text == "note1":
		if Input.is_action_just_pressed("interact") and !disc_shown and !in_menu and !disc_showing:
			enter_notes_first()
		if Input.is_action_just_pressed("interact") and disc_shown and !in_menu and !disc_showing:
			enter_notes()
		if Input.is_action_just_pressed("esc") and in_menu:
			if player.tasks == player.task9_2:
				player.tasks = player.task10_2
			exit_notes()
			
	if "note" in prompt.text and OBJ_ID.text == "note2":
		if Input.is_action_just_pressed("interact") and !disc_shown and !in_menu and !disc_showing:
			$/root/Node3D/Root_Scene/RootNode/basket_002/Key.visible = true
			$/root/Node3D/Root_Scene/RootNode/basket_002/Key/CollisionShape3D.disabled = false
			$/root/Node3D/Root_Scene/RootNode/basket_002/StaticBody3D/CollisionShape3D.disabled = true
			enter_notes_first()
		if Input.is_action_just_pressed("interact") and disc_shown and !in_menu and !disc_showing:
			enter_notes()
		if Input.is_action_just_pressed("esc") and in_menu:
			if $/root/Node3D/BOBDEAD/Cube_023/StaticBody3D/CollisionShape3D != null:
				$/root/Node3D/BOBDEAD/Cube_023/StaticBody3D/CollisionShape3D.free()
			$/root/Node3D/BOBDEAD/Cube_023/StaticBody3D.visible = false
			$/root/Node3D/Player/ScaryAmb.play()
			var red = Color(0.7, 0.0, 0.0, 1.0)
			global.otherambient = true
			$/root/Node3D/Player/Task2.set("modulate", red)
			if player.tasks == player.task7:
				player.tasks = player.task8
			exit_notes()
		

func _physics_process(delta) -> void:
	if disc_showing:
		if Input.is_action_just_pressed("cam_drag"):
			disc.visible = false
			resume_after_disclaimer.emit()
			
