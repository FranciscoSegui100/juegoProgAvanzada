extends Sprite2D

var tiempo = 0.0

func _process(delta):
	# 1. Acumulamos el tiempo en cada frame
	tiempo += delta
	
	# 2. Tu fórmula exacta: el 8.0 controla la velocidad, el 0.35 la intensidad
	# Usamos un valor base de 0.75 si quieres que el sprite sea un poco más chico al respirar
	var escala_respiracion = 0.75 + (sin(tiempo * 8.0) * 0.15)
	
	# 3. Aplicamos el cambio a la propiedad scale del propio Sprite
	scale = Vector2(escala_respiracion, escala_respiracion)
