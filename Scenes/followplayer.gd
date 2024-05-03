extends Node3D

var player

func _ready():
	player = $/root/Node3D/Player

func _process(delta):
	if player:
		var direction = player.global_transform.origin - global_transform.origin
		direction.y = 0
		direction = direction.normalized()
		look_at(global_transform.origin - direction, Vector3.UP)
