extends NinePatchRect

var mousePos = Vector2()
var showLabel = false

#onready var set_packet = StatList.plants
#onready var set_packet = StatList.plants[$"../..".seedpacket]
onready var set_packet = StatList.plants[get_parent().get_parent().seedpacket]

func _ready():
	raise()
	$PlantName.set_text(set_packet["name"])
	$SunCost.set_text("Cost: " + set_packet["suncost"])
	modulate.a = 0
	pass

func _process(delta):
	#mousePos = get_viewport().get_mouse_position()
	mousePos = get_global_mouse_position()
	#raise()
	if showLabel ==  true:
		if modulate.a < 1:
			modulate.a += 0.1
	else:
		modulate.a = 0
		
	rect_global_position = Vector2(mousePos.x, mousePos.y)
	pass

#func _input(event):
#	if event is InputEventMouseMotion:
#		mousePos = event.position


func _on_SeedPacket_mouse_entered():
	showLabel = true
	pass # Replace with function body.


func _on_SeedPacket_mouse_exited():
	showLabel = false
	pass # Replace with function body.
