extends Camera3D

var bobbing_amplitude = 0.009
var bobbing_frequency = 10.0

func _process(delta):
	var moving_forward = Input.get_action_strength("move_forward") > 0
	var moving_right = Input.get_action_strength("move_right") > 0
	var moving_backward = Input.get_action_strength("move_backward") > 0
	var moving_left = Input.get_action_strength("move_left") > 0

	var moving = moving_forward or moving_right or moving_left or moving_backward

	if moving:
		var bobbing_offset = sin(Time.get_ticks_msec() * 0.001 * bobbing_frequency) * bobbing_amplitude
		global_translate(Vector3(0, bobbing_offset, 0))
#21
