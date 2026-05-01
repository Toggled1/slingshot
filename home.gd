extends Control


var lock = 0
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_quit_pressed():
	get_tree().quit()
	
func _on_quit_mouse_entered():
	$hoverSound.play()
	_slightzoom()
func _on_quit_mouse_exited():
	if lock == 0:
		_slightzoomout()

func _on_start_pressed():
	lock = 1
	_zoomin()
	Trans.change_scene("res://levelselect.tscn")
	
func _on_start_mouse_entered():
	$hoverSound.play()
	_slightzoom()


func _on_start_mouse_exited():
	if lock == 0:
		_slightzoomout()
	
	
func _slightzoom() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "offset", Vector2(-25,25),1.0)
	tween.parallel().tween_property($Camera2D, "zoom", Vector2(1.05,1.05),1.0)
func _slightzoomout() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "offset", Vector2(0,0), 1.0)
	tween.parallel().tween_property($Camera2D, "zoom", Vector2(1,1),1.0)
func _zoomin() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($Camera2D, "zoom", Vector2(4,4), 1.0)




func _on_credits_pressed():
	lock = 1
	_zoomin()
	Trans.change_scene("res://credits.tscn")


func _on_credits_mouse_entered():
	$hoverSound.play()
	_slightzoom()


func _on_credits_mouse_exited():
	if lock == 0:
		_slightzoomout()
