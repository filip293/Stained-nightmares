extends Node3D

@onready var IntRay = $/root/Node3D/Player/Neck/SpringArm/Camera/InteractRay
@onready var Creature1 = $/root/Node3D/creature/RayCast3D
@onready var Creature2 = $/root/Node3D/creature3/RayCast3D
@onready var player = $/root/Node3D/Player
var first = true
func _ready():
	$RayCast3D.enabled = false
	$/root/Node3D/creature3/RayCast3D.enabled = false
	$/root/Node3D/creature.visible = false
	$/root/Node3D/creature3.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if IntRay.hasPlayedSound == true and IntRay.havekey == true and first == true:
		$/root/Node3D/Motel2/Window_frame_10/Cube_317/creature2.visible = true
		$RayCast3D.enabled = true
		$/root/Node3D/creature3/RayCast3D.enabled = true
		$/root/Node3D/creature.visible = true
		$/root/Node3D/creature3.visible = true
		first = false
	if Creature1.noisedone == true or Creature2.noisedone == true:
			$/root/Node3D/creature3.free()
			$/root/Node3D/creature.free()
