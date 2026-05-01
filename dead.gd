extends Node2D

var lock = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_retry_pressed():
	_zoomin()
	Trans.change_scene(Global.level)
	

func _on_exit_pressed():
	_zoomin()
	Trans.change_scene("res://levelselect.tscn")

func _zoomin() -> void:
	lock = 1
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($Camera2D, "zoom", Vector2(4,4), 1.0)

func _on_retry_mouse_entered():
	$hoverSound.play()
	_slightzoom()
	_top_animation_in()


func _on_exit_mouse_entered():
	$hoverSound.play()
	_slightzoom()
	_bottom_animation_in()
func _slightzoom() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.05,1.05), 1.0)
func _slightzoomout() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.00,1.00), 1.0)
func _on_retry_mouse_exited():
	if lock == 0:
		_slightzoomout()
		_top_animation_out()


func _on_exit_mouse_exited():
	if lock == 0:
		_slightzoomout()
		_bottom_animation_out()
		
func _top_animation_in():
	var tween := create_tween().set_trans(Tween.TRANS_SPRING)
	tween.parallel().tween_property($Control/Retry, "position", Vector2(290,52), 0.2)

func _top_animation_out():
	var tween := create_tween().set_parallel(Tween.TRANS_SPRING)
	tween.parallel().tween_property($Control/Retry, "position", Vector2(324,52),0.2)
	
func _bottom_animation_in():
	var tween := create_tween().set_trans(Tween.TRANS_SPRING)
	tween.parallel().tween_property($Control/Exit, "position", Vector2(290,195), 0.2)

func _bottom_animation_out():
	var tween := create_tween().set_parallel(Tween.TRANS_SPRING)
	tween.parallel().tween_property($Control/Exit, "position", Vector2(324,195),0.2)
	
