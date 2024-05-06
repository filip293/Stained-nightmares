extends Node3D

var Flicker: AnimationPlayer
var neon: AudioStreamPlayer3D
var neontime: Timer
var done: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Flicker = $AnimationPlayer
	neon = $AudioStreamPlayer3D
	neontime = $NeonSignTimer

func _process(delta):
	if done == true:
		Flicker.play("Flicker")
		neon.play()
		done = false

func _on_bell_ding_body_entered(body):
	$RootNode/Door/AudioStreamPlayer3D.play()


func _on_audio_stream_player_3d_finished():
	neontime.start()


func _on_neon_sign_timer_timeout():
	done = true
