extends Node2D

var frijol_recogido = false
var vidas = 3
var fuente
var intentos = 0
var posicion_frijol = Vector2.ZERO

func _ready():
	fuente = SystemFont.new()
	actualizar_posicion_frijol()
	
	# El juego inicia pausado esperando que toques "Jugar"
	get_tree().paused = true

func _process(_delta):
	if has_node("MetaSprite"):
		$MetaSprite.visible = intentos == 9
		
	# ACTUALIZAR LOS TEXTOS DE LA INTERFAZ
	if has_node("CanvasLayer"):
		$CanvasLayer/LabelVidas.text = "Vidas: " + str(vidas)
		$CanvasLayer/LabelFrijoles.text = "Frijoles: " + str(intentos) + " / 9"
		$CanvasLayer/LabelControles.text = "Flechas: mover  |  Espacio: saltar  | ESC: Pausa"
		$CanvasLayer/LabelNivel.text = " NIVEL FINAL! "
		
	if Input.is_action_just_pressed("ui_cancel"):
		
		var menu_pr = get_node_or_null("CanvasLayer/MenuPrincipal") if has_node("CanvasLayer/MenuPrincipal") else get_node_or_null("MenuPrincipal")
		var pant_fin = get_node_or_null("CanvasLayer/PantallaFin") if has_node("CanvasLayer/PantallaFin") else get_node_or_null("PantallaFin")
		
		if menu_pr and pant_fin:
			if not menu_pr.visible and not pant_fin.visible:
				mostrar_pausa(not get_tree().paused)


var msg = "Frijoles: " + str(intentos) + " / 9"

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

	if has_node("FrijolSprite"):
		$FrijolSprite.position = posicion_frijol
		$FrijolSprite.visible = intentos < 9

# === GESTIÓN DE INTERFACES Y MENÚS ===

func mostrar_pausa(activar: bool):
	get_tree().paused = activar

	# Buscamos y mostramos/ocultamos el menú de pausa donde sea que esté
	if has_node("MenuPausa"):
		$MenuPausa.visible = activar
		print("-> [INTERFAZ] MenuPausa encontrado en la raíz.")
	elif has_node("CanvasLayer/MenuPausa"):
		$CanvasLayer/MenuPausa.visible = activar
		print("-> [INTERFAZ] MenuPausa encontrado dentro de CanvasLayer.")
	else:
		print("-> [ERROR GRAVE] ¡Godot no encuentra el nodo 'MenuPausa' por ningún lado!")

func finalizar_juego(victoria: bool):
	get_tree().paused = true
	if has_node("PantallaFin"):
		$PantallaFin.visible = true
		if victoria:
			$PantallaFin/TextoFin.text = "¡HAS GANADO EL JUEGO!"
		else:
			$PantallaFin/TextoFin.text = "PERDISTE - TE QUEDASTE SIN TUS VIDAS"

# === SEÑALES DE LOS BOTONES ===

func _on_boton_jugar_pressed() -> void:
	if has_node("MenuPrincipal"):
		$MenuPrincipal.visible = false
	get_tree().paused = false

func _on_boton_salir_pressed() -> void:
	get_tree().quit()

func _on_boton_reanudar_pressed() -> void:
	mostrar_pausa(false)

func _on_boton_reiniciar_pausa_pressed() -> void:
	mostrar_pausa(false)
	get_tree().reload_current_scene()

func _on_boton_reiniciar_fin_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_timer_inmortal_timeout() -> void:
	pass
