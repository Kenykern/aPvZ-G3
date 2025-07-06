extends TextureProgress

func _ready():
	min_value = 0
	max_value = 5
	value = max_value
	set_process(true)  # solo si necesitás activarlo manualmente

func _process(delta):
	value = max(value - delta, 0)
	#print("Valor:", value)
	#modulate = Color(1, 0, 0, 1)  # rojo visible
	update()
