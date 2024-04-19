extends Node2D

@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var Cutscene := $/root/Node3D/Cutscene
@onready var Crosshair = $/root/Node3D/TextureRect
@onready var Task = $/root/Node3D/Player/Task2
@onready var OBJ_ID = $/root/Node3D/CarCutscene/OBJ_ID

signal resume_after_disclaimer
var in_menu := false
var disc_shown := false
var disc_showing := false
var disc: Node2D
var note: Node2D
# Called when the node enters the scene tree for the first time.

func _ready():
	disc = $Disclaimer
	note = $Notes
	disc.visible = false
	note.visible = false

func exit_notes() -> void:
	in_menu = false
	note.visible = false
	Crosshair.visible = true
	Task.visible = true
	disc_showing = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func enter_notes() -> void:
	in_menu = true
	note.visible = true
	Crosshair.visible = false
	Task.visible = false
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func enter_notes_first() -> void:
	in_menu = true
	disc.visible = true
	Crosshair.visible = false
	Task.visible = false
	get_tree().paused = true
	disc_showing = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await resume_after_disclaimer
	note.visible = true

func _process(delta) -> void:
	if "Read note" in prompt.text and OBJ_ID.text == "note1":
		if Input.is_action_just_pressed("interact") and !disc_shown and !in_menu:
			enter_notes_first()
		if Input.is_action_just_pressed("interact") and disc_shown and !in_menu:
			enter_notes()
		if Input.is_action_just_pressed("interact") and in_menu:
			exit_notes()

func _physics_process(delta) -> void:
	if disc_showing:
		if Input.is_action_just_pressed("left_click"):
			disc.visible = false
			resume_after_disclaimer.emit()
			
