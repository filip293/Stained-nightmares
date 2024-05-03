class_name Interactable
extends StaticBody3D


@export var prompt_message = "Interactable"
@export var prompt_action = "interact"
@export var prompt_object = "obj"

@onready var labelidentifier := $/root/Node3D/CarCutscene/OBJ_ID
var in_range: bool = false

func get_prompt():
	var key_name = ""
	var input_list = InputMap.get_actions()
	for input in input_list:
		if input is InputEventKey:
			key_name = input.scancode_string
	return prompt_message + "\n[" + prompt_action + "]"
	
func get_object():
	return prompt_object
