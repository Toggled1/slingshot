extends Control

var selected = 1
var sel_cord = 544.85
var rect_color
var light_color
var lock = 0
const SCALEVALUE = Vector2(1.1,1.1)
const NORMAL = Vector2(1.0,1.0)
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _input(event):
	if $HBoxContainer.position.x < 544.85 and $HBoxContainer.position.x > -407.15:
		if event.is_action_pressed("reversescroll"):
			sel_cord -= 238
			selected += 1
			_slidetrans()
		if event.is_action_pressed("arrow right"):
			sel_cord -= 238
			selected += 1
			_slidetrans()
	if $HBoxContainer.position.x < 544.85:
		if event.is_action_pressed("scroll"):
			sel_cord += 238
			selected -= 1
			_slidetrans()
		if event.is_action_pressed("arrow left"):
			sel_cord += 238
			selected -= 1
			_slidetrans()

@warning_ignore("unused_parameter")
func _process(delta):
	if $HBoxContainer.position.x > 544.85:
		$HBoxContainer.position.x = 544.85
		selected = 1
		sel_cord = 544.85
	if $HBoxContainer.position.x < -407.15:
		$HBoxContainer.position.x = -407.15
		selected = 5
		sel_cord = -407.15
	if selected == 1:
		light_color = Color(0.941, 0.216, 0.118)
		rect_color = Color(0.698, 0, 0.094, 0.847)
		$HBoxContainer/Button.disabled = false
		_backcolor()
	else:
		$HBoxContainer/Button.disabled = true
	if selected == 2:
		light_color = Color(0.778, 0.227, 0.889)
		rect_color = Color(1, 0.188, 1, 0.847)
		$HBoxContainer/Button2.disabled = false
		_backcolor()
	else:
		$HBoxContainer/Button2.disabled = true
	if selected == 3:
		light_color = Color(0.255, 0.62, 0.271)
		rect_color = Color(0.255, 0.62, 0.271)
		$HBoxContainer/Button3.disabled = false
		_backcolor()
	else:
		$HBoxContainer/Button3.disabled = true
	if selected == 4:
		light_color = Color(0.016, 0.58, 0.757)
		rect_color = Color(0.082, 0.714, 0.816, 0.847)
		$HBoxContainer/Button4.disabled = false
		_backcolor()
	else:
		$HBoxContainer/Button4.disabled = true
	if selected == 5:
		light_color = Color(0.801, 0.837, 0)
		rect_color = Color(0.691, 0.657, 0.001, 0.847)
		$HBoxContainer/Button5.disabled = false
		_backcolor()
	else:
		$HBoxContainer/Button5.disabled = true


func _on_back_pressed():
	_zoomin()
	Trans.change_scene("res://home.tscn")


func _on_left_button_pressed():
	if $HBoxContainer.position.x < 543:
		sel_cord += 238
		selected -= 1
		_slidetrans()
func _on_right_button_pressed():
	if $HBoxContainer.position.x < 545 and $HBoxContainer.position.x > -405:
		sel_cord -= 238
		selected += 1
		_slidetrans()


func _on_oversize_pressed():
	lock = 1
	_zoomin()
	if selected == 1:
		Trans.change_scene("res://level1.tscn")
	if selected == 2:
		Trans.change_scene("res://level_2.tscn")
	if selected == 3:
		Trans.change_scene("res://level_3.tscn")
	if selected == 4:
		Trans.change_scene("res://level_4.tscn")
	if selected == 5:
		Trans.change_scene("res://level_5.tscn")


func _on_oversize_mouse_entered():
	$ColorRect2.scale = SCALEVALUE
	$LightOccluder2D.visible = false
	$LightOccluder2alt.visible = true
	$hoverSound.play()
	_slightzoom()
	
func _on_oversize_mouse_exited():
	if lock == 0:
		$ColorRect2.scale = NORMAL
		$LightOccluder2D.visible = true
		$LightOccluder2alt.visible = false
		_slightzoomout()
	
func _slightzoom() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.05,1.05), 1.0)

func _slightzoomout() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.00,1.00), 1.0)
	
func _zoomin() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($Camera2D, "zoom", Vector2(4,4), 1.0)
	
func _slidetrans() -> void:
	$hoverSound.play()
	if $HBoxContainer.position.x > 544.85:
		$HBoxContainer.position.x = 544.85
		selected = 1
		sel_cord = 544.85
		pass
	if $HBoxContainer.position.x < -407.15:
		$HBoxContainer.position.x = -407.15
		selected = 5
		sel_cord = -407.15
		pass
	var tween := create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property($HBoxContainer, "position", Vector2(sel_cord,270), 0.3)
	
func _backcolor() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($PointLight2D, "color", light_color, 0.3)
	tween.parallel().tween_property($ColorRect2, "color", rect_color, 0.3)


func _on_back_mouse_entered():
	$hoverSound.play()
	_back_animation_in()
	
func _back_animation_in():
	var tween := create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property($Back, "position", Vector2(-86,33), 0.2)

func _back_animation_out():
	var tween := create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property($Back, "position", Vector2(-121,33),0.2)


func _on_back_mouse_exited():
	_back_animation_out()
