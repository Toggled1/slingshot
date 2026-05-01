extends Control

var lock = 0

func _ready():
	$ScrollContainer/Control/CompleteLabel.text = str(Global.final_time)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$ScrollContainer/Control/Slot1/Gem1.scale = Vector2(0.0,0.0)
	$ScrollContainer/Control/Slot2/Gem2.scale = Vector2(0.0,0.0)
	$ScrollContainer/Control/Slot3/Gem3.scale = Vector2(0.0,0.0)
	$ScrollContainer/Control/CompleteLabel.scale = Vector2(0.0,0.0)
	$ScrollContainer/Control/JumpsLabel.text = ("Jumps -- " + str(Global.jumps))
	animate_label()
	if Global.skill == 3:
		animate_gems1()
		animate_gems2()
		animate_gems3()
	elif Global.skill == 2:
		animate_gems1()
		animate_gems3()
	else:
		animate_gems1()



func _on_next_pressed():
	_zoomin()
	Trans.change_scene("res://levelselect.tscn")


func _on_retry_pressed():
	_zoomin()
	Trans.change_scene(Global.level)

func animate_gems1() -> void:
	await get_tree().create_timer(1.0).timeout
	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	$ScrollContainer/Control/Slot1/Gem1.scale = Vector2(0.0,0.0)
	$ScrollContainer/Control/Slot1/Gem1.rotation = -10.0
	tween.tween_property($ScrollContainer/Control/Slot1/Gem1, "scale", Vector2(1.0, 1.0), 0.5)
	tween.parallel().tween_property($ScrollContainer/Control/Slot1/Gem1, "rotation", 0.0, 1.0)
	$gemSound.play()

func animate_gems2() -> void:
	await get_tree().create_timer(2.0).timeout
	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	$ScrollContainer/Control/Slot2/Gem2.scale = Vector2(0.0,0.0)
	$ScrollContainer/Control/Slot2/Gem2.rotation = -10.0
	tween.tween_property($ScrollContainer/Control/Slot2/Gem2, "scale", Vector2(1.0, 1.0), 0.8)
	tween.parallel().tween_property($ScrollContainer/Control/Slot2/Gem2, "rotation", 0.0, 1.0)
	$gemSound.play()

func animate_gems3() -> void:
	await get_tree().create_timer(1.5).timeout
	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	$ScrollContainer/Control/Slot3/Gem3.scale = Vector2(0.0,0.0)
	$ScrollContainer/Control/Slot3/Gem3.rotation = -10.0
	tween.tween_property($ScrollContainer/Control/Slot3/Gem3, "scale", Vector2(1.0, 1.0), 0.5)
	tween.parallel().tween_property($ScrollContainer/Control/Slot3/Gem3, "rotation", 0.0, 1.0)
	$gemSound.play()

func animate_label() -> void:
	await get_tree().create_timer(0.10).timeout
	var tween := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property($ScrollContainer/Control/CompleteLabel, "scale", Vector2(1, 1), 0.5)


func _on_next_mouse_entered():
	$hoverSound.play()
	_slightzoom()


func _on_retry_mouse_entered():
	$hoverSound.play()
	_slightzoom()

func _slightzoom() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.05,1.05), 1.0)

func _slightzoomout() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.00,1.00), 1.0)

func _zoomin() -> void:
	lock = 1
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($Camera2D, "zoom", Vector2(4,4), 1.0)


func _on_next_mouse_exited():
	if lock == 0:
		_slightzoomout()


func _on_retry_mouse_exited():
	if lock == 0:
		_slightzoomout()
