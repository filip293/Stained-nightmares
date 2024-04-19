extends Node2D

@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var Cutscene := $/root/Node3D/Cutscene
@onready var Crosshair = $/root/Node3D/TextureRect
@onready var Task = $/root/Node3D/Player/Task2
@onready var OBJ_ID = $/root/Node3D/CarCutscene/OBJ_ID

signal resume_after_disclaimer
var in_menu: bool = false
var disc_shown: bool = false
var disc_showing: bool = false
var disc: Node2D
var note: Node2D
var note1: Sprite2D
var note2: Sprite2D
# Called when the node enters the scene tree for the first time.

func _ready():
	disc = $Disclaimer
	note = $Notes
	note1 = $Note1
	note2 = $Note2
	disc.visible = false
	note.visible = false
	note1.visible = false
	note2.visible = false

func exit_notes() -> void:
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
	in_menu = true
	note.visible = true
	if global.route == "BOB":
		note1.visible = true
	elif global.route == "Motel":
		note2.visible = true
	Crosshair.visible = false
	Task.visible = false
	prompt.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func enter_notes_first() -> void:
	in_menu = true
	disc.visible = true
	Crosshair.visible = false
	Task.visible = false
	disc_showing = true
	prompt.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await resume_after_disclaimer
	note.visible = true
	disc_shown = true

func _process(delta) -> void:
	if "Read note" in prompt.text and OBJ_ID.text == "note1":
		if Input.is_action_just_pressed("interact") and !disc_shown and !in_menu and !disc_showing:
			enter_notes_first()
		if Input.is_action_just_pressed("interact") and disc_shown and !in_menu and !disc_showing:
			enter_notes()
		if Input.is_action_just_pressed("esc") and in_menu:
			exit_notes()
		

func _physics_process(delta) -> void:
	if disc_showing:
		if Input.is_action_just_pressed("left_click"):
			disc.visible = false
			resume_after_disclaimer.emit()
			
