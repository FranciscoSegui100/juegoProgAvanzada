extends Node2D
var frijol_recogido = false
var vidas = 3
var fuente
var intentos = 0
var posicion_frijol = Vector2.ZERO

func _ready():
	fuente = SystemFont.new()
	actualizar_posicion_frijol()

func _process(_delta):
	queue_redraw()

func _draw():
	if intentos < 9:
		draw_circle(posicion_frijol, 15, Color(1, 0.85, 0))
	if intentos == 9:
		draw_rect(Rect2(3020, 320, 50, 60), Color(0, 0.8, 0))
	draw_string(fuente, Vector2(20, 40),
		"Vidas: " + str(vidas), HORIZONTAL_ALIGNMENT_LEFT, -1, 26, Color.WHITE)
	draw_string(fuente, Vector2(2400, 200),
		" NIVEL FINAL! ", HORIZONTAL_ALIGNMENT_CENTER, -1, 26, Color.DARK_RED)
	var msg = "Frijoles: " + str(intentos) + " / 9"
	draw_string(fuente, Vector2(20, 72),
		msg, HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color.YELLOW)
	draw_string(fuente, Vector2(20, 72),
		msg, HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color.YELLOW)
	draw_string(fuente, Vector2(300, 630),
		"Flechas: mover  |  Espacio: saltar",
		HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color.LIGHT_GRAY)

func actualizar_posicion_frijol():
	match intentos:
		0:
			posicion_frijol = Vector2(randi_range(400, 530), randi_range(100, 170))
		1:
			posicion_frijol = Vector2(20, 315)
		2:
			posicion_frijol = Vector2(randi_range(600, 750), randi_range(100, 200))
		3:
			posicion_frijol = Vector2(randi_range(850, 1000), randi_range(250, 300))
		4:
			posicion_frijol = Vector2(randi_range(1260, 1330), randi_range(280, 280))
		5:
			posicion_frijol = Vector2(randi_range(1460, 1530), randi_range(230, 260))
		6:
			posicion_frijol = Vector2(randi_range(1900, 2000), randi_range(170, 200))
		7:
			posicion_frijol = Vector2(randi_range(2300, 2380), randi_range(230, 260))
		8:
			posicion_frijol = Vector2(2725, randi_range(160, 170))
