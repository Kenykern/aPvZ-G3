extends TextureProgress

var charge_time = 2 * 100
var asd = 0.1

func _ready():
	modulate.a = 0.7
	min_value = 0
	max_value = charge_time
	value = charge_time
func _process(delta):
#	print("Valor antes:", value)
	value -= delta * 100
#	print("Valor después:", value)
#	print("Charge time:", charge_time)


#	print("Procesando... Delta:", delta)
#	print("Valor:", value, "Min:", min_value, "Max:", max_value)
#	print("Textura de progreso:", self.texture_progress)
	
	update()
	value -= delta
	if value != 0 or StatList.holding_plant == true:
		get_parent().disabled = true
		get_parent().mouse_default_cursor_shape = Control.CURSOR_ARROW
		if get_parent().pressed:
			$"../AnimatedSprite".stop()
	else:
		if StatList.holding_plant == false:
			get_parent().disabled = false
			get_parent().mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			if !$"../AnimatedSprite".is_playing():
				$"../AnimatedSprite".play()
