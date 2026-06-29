extends Area2D

@export var velocidad = 80.0
@export var limite_abajo = 190.0
@export var limite_arriba = 280.0

var direccion = 1 # 1 = abajo (Y aumenta), -1 = arriba (Y disminuye)
var tiempo = 0.0

# NUEVA: Aquí guardaremos el tamaño original que configuraste en el editor
var escala_base_polygon = Vector2.ONE

func _ready():
	# Al arrancar, guardamos la escala que tiene tu Polygon2D en el Inspector
	if has_node("Polygon2D"):
		escala_base_polygon = $Polygon2D.scale

func _process(delta):
	# 1. Movimiento vertical de patrulla
	position.y += velocidad * direccion * delta
	
	# Cambiar de rumbo si toca los límites configurados
	# Nota: En Godot, "limite_arriba" en Y suele ser un número menor, 
	# pero mantengo tus condicionales exactos para no romper tu lógica actual.
	if position.y > limite_arriba:
		direccion = -1
	elif position.y < limite_abajo:
		direccion = 1

	# 2. EFECTO DE RESPIRACIÓN AUTOMÁTICO REPARADO
	tiempo += delta 
	
	# Calculamos el multiplicador del vaivén (varía sutilmente entre -0.15 y +0.15)
	var multiplicador = sin(tiempo * 8.0) * 0.15
	
	# Aplicamos el efecto sumándolo a la escala base original
	if has_node("Polygon2D"):
		$Polygon2D.scale.x = escala_base_polygon.x + multiplicador
		$Polygon2D.scale.y = escala_base_polygon.y + multiplicador
