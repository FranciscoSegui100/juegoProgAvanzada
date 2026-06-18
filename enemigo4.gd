extends Area2D

@export var velocidad = 80.0
@export var limite_abajo = 190.0
@export var limite_arriba = 280.0

var direccion = 1 # 1 = arriba, -1 = bajo

# Variable para contar el tiempo (esencial para la respiración)
var tiempo = 0.0

func _process(delta):
	# 1. Movimiento horizontal normal de patrulla
	position.y += velocidad * direccion * delta
	
	# Cambiar de rumbo si toca los límites configurados
	if position.y > limite_arriba:
		direccion = -1
	elif position.y < limite_abajo:
		direccion = 1

	# 2. EFECTO DE RESPIRACIÓN AUTOMÁTICO
	tiempo += delta # Sumamos el tiempo que pasa en cada frame
	
	# Usamos la función Matemática SIN (Seno) para hacer un vaivén suave.
	# El 8.0 controla la velocidad de la respiración.
	# El 0.35 controla qué tan inflado/desinflado se vuelve.
	var escala_respiracion = 1.0 + (sin(tiempo * 8.0) * 0.35)
	
	# Le aplicamos la escala al polígono visual
	$Polygon2D.scale = Vector2(escala_respiracion, escala_respiracion)
