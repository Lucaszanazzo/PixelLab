class_name CamaraPlayer
extends CamaraJuego

## Variables Export 
export var variacion_zoom: float = 0.1
export var zoom_minimo: float = 0.8
export var zoom_maximo: float = 1.2


##Metodos

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_acercar"):
		controlar_zoom(-variacion_zoom)
	elif event.is_action_pressed("zoom_alejar"):
		controlar_zoom(variacion_zoom)


##Metodos custom 
func controlar_zoom(mood_zoom: float) ->void:
	print("controlador zoom")
	var zoom_x = clamp(zoom.x + mood_zoom, zoom_minimo, zoom_maximo)
	var zoom_y = clamp(zoom.y + mood_zoom, zoom_minimo, zoom_maximo)
	zoom_suavizado(zoom_x, zoom_y, 0.15)


