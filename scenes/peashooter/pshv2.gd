extends Node2D

# Estados del Peashooter
enum State { IDLE, SHOOTING, HURT, DYING, DEAD }
var state = State.IDLE
var gr
export(PackedScene) var pea
export(int) var lane = 1
var health = 100

onready var spawn_marker = $PeaSpawn
onready var anim         = $AnimatedSprite
onready var timer        = $TargetCheck

func _ready():
	timer.start(2.0)
	anim.play("popup")
	anim.play("std")
	anim.connect("animation_finished", self, "_on_anim_finished")

func _process(delta):
	# Cambio manual de estado
	if Input.is_action_just_pressed("ui_accept"):
		if state == State.IDLE:
			state = State.SHOOTING
		else:
			state = State.IDLE

	if health <= 0:
		queue_free()

func _on_TargetCheck_timeout():
	var foes  = get_tree().get_nodes_in_group("foe")
	var found = false

	for foe in foes:
		if not foe.has_method("get"): continue
		var foe_lane = foe.get("lane")
		if foe_lane == null or foe_lane != lane: continue
		var foe_state = foe.get("state")
		if foe_state == null or foe_state == State.DEAD: continue
		if foe.global_position.x > global_position.x:
			found = true
			break

	if found:
		state = State.SHOOTING
	else:
		state = State.IDLE

	print("TargetCheck → found=", found, " state=", state)


func _on_anim_finished(anim_name):
	print("▶ animation_finished:", anim_name, " state:", state)
	if anim_name == "std":
		if state == State.SHOOTING:
			anim.play("shoot")
	elif anim_name == "shoot":
		_spawn_pea()
		anim.play("std")

func _spawn_pea():
	var cPea = pea.instance()
	cPea.lane = lane
	cPea.global_position = spawn_marker.global_position
	get_parent().add_child(cPea)
