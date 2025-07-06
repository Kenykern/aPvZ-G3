# INDIVIDUAL BUTTON FOR "seed_planter.tscn"
extends Button
var button_pressed = false
#later to be used by "main.tscn"
export var seedpacket: String

#where all the plant and properties are in a dictionary

onready var set_packet = StatList.plants[seedpacket]

func _on_ready():
	pass
func _process(delta):
	if Input.is_mouse_button_pressed(2):
		pressed = false
		
	if is_pressed():
		if StatList.seedpacket_id != get_instance_id():
			pass
#			pressed = false
	pass


func _on_SeedPacket_toggled(button_pressed):
	if button_pressed:
		StatList.holding_plant = true
		StatList.seedpacket_id = get_instance_id()
		$Sprite.modulate.a = 0.5
	else:
		$Sprite.modulate.a = 0

	pass # Replace with function body.

func seedPacket_reset():
	$TextureProgressBar.value = $TextureProgressBar.charge_time
#	pressed = false


func _on_SeedPacket_pressed():
	pass # Replace with function body.
