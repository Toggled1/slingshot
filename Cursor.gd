extends Node2D

#two states of mouse

var clicked = load("res://images/graycircle.png")

var normal = load("res://images/whitecircle.png")
var isclicked = 0
const SCALECLICKED = Vector2(1, 1)
const SCALENORMAL = Vector2(.5, .5)
var drag_start
var drag_end
var dragging
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Sprite2D.visible = false
	$CanvasLayer/Swipeline.visible = false
	
func _process(delta):
	$CanvasLayer/Swipeline.clear_points()
	$Sprite2D.visible = true
	$CanvasLayer/Swipeline.visible = true
	$Sprite2D.position = $Sprite2D.get_global_mouse_position()
	if isclicked == 1:
		$Sprite2D.texture = clicked
		$Sprite2D.scale = SCALECLICKED
	else:
		$Sprite2D.texture = normal
		$Sprite2D.scale = SCALENORMAL
	if dragging == true:
		$CanvasLayer/Swipeline.add_point(drag_start)
		drag_end = get_viewport().get_mouse_position()
		$CanvasLayer/Swipeline.add_point(drag_end)
func _input(event):
	if event.is_action_pressed("click"):
		isclicked = 1
		drag_start = get_viewport().get_mouse_position()
		dragging = true
		_expand()
	if event.is_action_released("click"):
		isclicked = 0
		dragging = false
		$CanvasLayer/Swipeline.clear_points()
		_contract()

func _expand() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property($CanvasLayer/Swipeline, "width", 134, 0.7)
	
func _contract() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property($CanvasLayer/Swipeline, "width", 100, 0.7)
