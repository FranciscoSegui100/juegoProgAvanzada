extends Area2D

@export var velocidad = 300.0
@export var limite_izquierdo = 1650.0
@export var limite_derecho = 1910.0

var direccion = 1 # 1 = Derecha, -1 = Izquierda

func _process(delta):
	# Moverse horizontalmente
	position.x += velocidad * direccion * delta
	
	# Cambiar de rumbo si toca los límites configurados
	if position.x > limite_derecho:
		direccion = -1
	elif position.x < limite_izquierdo:
		direccion = 1
