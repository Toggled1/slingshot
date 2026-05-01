extends Node2D


func _back_animation_in():
	var tween := create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property($Back, "position", Vector2(-86,33), 0.2)

func _back_animation_out():
	var tween := create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property($Back, "position", Vector2(-121,33),0.2)

func _on_back_pressed():
	Trans.change_scene("res://home.tscn")



func _on_back_mouse_entered():
	_back_animation_in()


func _on_back_mouse_exited():
	_back_animation_out()
