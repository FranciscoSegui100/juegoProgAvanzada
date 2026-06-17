extends Node2D

var frijol_recogido = false
var vidas = 3
var fuente
var intentos = 0


# Creamos una variable para guardar la posición actual del frijol
var posicion_frijol = Vector2.ZERO

func _ready():
	fuente = SystemFont.new()
	# Calculamos la primera posición al arrancar el juego
	actualizar_posicion_frijol()

func _process(_delta):
	queue_redraw()

func _draw():
	# Frijol dorado: Solo se dibuja si intentos es menor que 3
	
	if intentos < 3:
		draw_circle(posicion_frijol, 15, Color(1, 0.85, 0))
		
	# Meta (puerta)
	if intentos == 3:
		draw_rect(Rect2(1590, 370, 50, 60), Color(0, 0.8, 0))

	# HUD - vidas
	draw_string(fuente, Vector2(20, 40),
		"Vidas: " + str(vidas), HORIZONTAL_ALIGNMENT_LEFT, -1, 26, Color.WHITE)

	# HUD - frijol
	var msg = "Frijol recogido!" if frijol_recogido else "Busca el frijol dorado"
	draw_string(fuente, Vector2(20, 72),
		msg, HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color.YELLOW)

	# Instrucciones
	draw_string(fuente, Vector2(300, 630),
		"Flechas: mover  |  Espacio: saltar",
		HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color.LIGHT_GRAY)

# Esta función la debes llamar CADA VEZ que el jugador sume un intento
func actualizar_posicion_frijol():
	match intentos:
		0:
			posicion_frijol = Vector2(randi_range(400, 530), randi_range(100, 170))
		1:
			posicion_frijol = Vector2(20, 315)
		2:
			# Aquí puedes agregar una tercera posición para cuando intentos sea 2
			posicion_frijol = Vector2(randi_range(600, 750), randi_range(100, 200))
