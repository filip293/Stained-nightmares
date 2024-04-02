extends RayCast3D

# Reference to the prompt label
@onready var prompt = $/root/Node3D/CarCutscene/Label
@onready var player = $/root/Node3D/Player
var on_screen: bool = false
var noise = AudioStreamPlayer
var noise_playing: bool = false

func _ready():
	noise = $AudioStreamPlayer

# Called every frame
func _process(delta):
	if is_colliding():
		var detected = get_collider()
		if detected.has_method("get_prompt"):
			var detected_word = detected.get_prompt()
			if detected_word == "Player" and on_screen == true and noise_playing == false:
				noise_playing = true
				print("Player detected")
				noise.play()

func _on_visible_on_screen_notifier_3d_screen_entered():
	on_screen = true

func _on_visible_on_screen_notifier_3d_screen_exited():
	on_screen = false

func _on_audio_stream_player_finished():
	noise_playing = false
