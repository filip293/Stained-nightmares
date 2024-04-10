class_name Interactable
extends StaticBody3D


@export var prompt_message = "Interactable"
@export var prompt_action = "interact"

var in_range: bool = false



func get_prompt():
	var key_name = ""
	var input_list = InputMap.get_actions()
	for input in input_list:
		if input is InputEventKey:
			key_name = input.scancode_string
	return prompt_message + "\n[" + prompt_action + "]"
