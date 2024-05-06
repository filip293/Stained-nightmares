extends Camera3D
var runonce = false
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	await global.endinganim
	if !runonce:
		runonce = true
		make_current()
		$/root/Node3D/TextureRect.visible = false
		$/root/Node3D/Player/AmbientNoise.stop()
		$/root/Node3D/Player/ScaryAmb.stop()
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("wakingup")
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/Itwasalladream.dialogue"), "waking_up")
		await get_tree().create_timer(6.6).timeout
		$AudioStreamPlayer3.play()
		await get_tree().create_timer(3.9).timeout
		$AudioStreamPlayer2.play()
		await get_tree().create_timer(2).timeout
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$/root/Node3D/EndingScreen.visible = true
		$/root/Node3D/EndingScreen/EndingText.text = "ENDING 1/4"
