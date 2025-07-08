extends Node2D

# Estados para controlar lógicas mutuas
enum State { HEALTHY, HURT, DEAD }

export(int) var max_health := 100
var curr_health := max_health setget _set_health
var lane = 1
var state = State.HEALTHY

# Precargas de escenas de piezas
const ARM_PH = preload("res://scenes/enemies/zombie/arm_phs.tscn")
const HEAD_PH = preload("res://scenes/enemies/zombie/head_phs.tscn")

func _ready():
	# asegúrate de que el sprite esté opaco al inicio
	$an_zombie.modulate.a = 1.0
	
func _process(delta):
		
	if $an_zombie.get_frame() >= 38 and $an_zombie.get_frame() <= 55:
		global_position.x -= 1
	elif $an_zombie.get_frame() >= 55 and $an_zombie.get_frame() <= 67:
		global_position.x -= 0.5
	elif $an_zombie.get_frame() >= 78 and $an_zombie.get_frame() <= 82:
		global_position.x -= 1.2
	elif $an_zombie.get_frame() >= 101 and $an_zombie.get_frame() <= 123:
		global_position.x -= 1.1
	elif $an_zombie.get_frame() >= 123 and $an_zombie.get_frame() <= 131:
		global_position.x -= 1
	elif $an_zombie.get_frame() >= 137 and $an_zombie.get_frame() <= 183:
		global_position.x -= 0.5
		
	############################
func _set_health(value):
	# clampea entre 0 y max
	curr_health = clamp(value, 0, max_health)
	_update_state()

func _update_state():
	match state:
		State.HEALTHY:
			if curr_health <= max_health / 2:
				_enter_hurt()
		State.HURT:
			if curr_health <= 0:
				_enter_dead()
		# DEAD no se reingresa
		
		
	################################
	
func _enter_hurt():
	state = State.HURT
	var frame = $an_zombie.get_frame()
	$an_zombie.play("walk_noarm")
	$an_zombie.set_frame(frame)

	var ph = ARM_PH.instance()
	ph.position = $arm_spawn.position
	ph.pgp = global_position
	add_child(ph)

func _enter_dead():
	state = State.DEAD
	var frame = $an_zombie.get_frame()
	$an_zombie.play("walk_nohead")
	$an_zombie.set_frame(frame)

	var ph = HEAD_PH.instance()
	ph.position = $head_spawn.position
	ph.pgp = global_position
	add_child(ph)

	$hitArea.queue_free()
	_start_death_sequence()
	
################################

func _start_death_sequence():
	# conectamos la señal para saltar al “death” justo al finalizar
	state = State.DEAD
	$an_zombie.connect("animation_finished", self, "_on_anim_finished")
	# tocamos la animación de muerte parcial; al terminar, irá a “death”
	$an_zombie.play("walk_nohead")

func _on_anim_finished():
	# Si ya estamos muertos y la animación que acabó NO es “death”, la lanzamos
	if state == State.DEAD and $an_zombie.animation != "death":
		$an_zombie.play("death")
	# Si era “death” la que terminó, liberamos el nodo
	elif state == State.DEAD and $an_zombie.animation == "death":
		queue_free()
