extends Node

var route: String
var chosen: bool = false
var bobannoyed = 0
var in_bathroom := false
var otherambient := false
var bobgiveskey := false
var bobshotgun := false
var Bobanimplayer: AnimationPlayer
var runonce1 := false
var runonce2 := false
var Keyanim: AnimationPlayer
var Keyanimtimer: Timer
signal animdone 
# Called when the node enters the scene tree for the first time.
func _ready():
	var Bobanimplayer = $/root/Node3D/Guy/Bob/AnimationPlayer
	var Keyanim = $/root/Node3D/Key2/AnimationPlayer
	var Keyanimtimer = $/root/Node3D/Key2/Timer
	$/root/Node3D/Guy/Shotgun_12.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bobgiveskey and !runonce1:
		runonce1 = true
		$/root/Node3D/Key2/AnimationPlayer.play("passkey")
		$/root/Node3D/Key2/Timer.start()
		await $/root/Node3D/Key2/Timer.timeout
		animdone.emit()
	
	if bobshotgun and !runonce2:
		runonce2 = true
		#Bobanimplayer.play("shotgun")
		
		$/root/Node3D/Guy/Shotgun_12.visible = true
		$/root/Node3D/Guy/Pow.play()
