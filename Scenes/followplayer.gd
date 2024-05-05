extends Node3D

var player
var reset = false

func _ready():
	player = $/root/Node3D/Player

func _process(delta):
	if player.error_time == true and reset == false:
		var direction = player.global_transform.origin - global_transform.origin
		direction.y = 0
		direction = direction.normalized()
		reset = true
	
	
	if player and player.in_store == true and player.error_time == true:
		var direction = player.global_transform.origin - global_transform.origin
		direction.y = 0
		direction = direction.normalized()
		$/root/Node3D/Guy.look_at(global_transform.origin + direction, Vector3.UP)
