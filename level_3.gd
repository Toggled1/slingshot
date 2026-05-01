extends Node2D

var x = -200
var time = 0
var end = 0
var lock = 1
@export var randomStrength: float = 20.0
@export var shakeFade: float = 3.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func _ready():
	Global.level = ("res://level_3.tscn")
	
func _process(delta):
	$Camera2D.position.y = 280 + ($hello.position.y - 280) / 4
	$Camera2D.position.x = $hello.position.x + 300
	$Camera2D.limit_left = x
	x += 2
	if $hello.position.x < x + 20:
		Trans2.change_scene("res://dead.tscn")
		set_process(false)
	if end == 1:
		time += .1
		$CanvasModulate.color = Color(0.722 - time, 0.267 - time, 0.267 - time)
	if lock == 0:
		apply_shake()
		if shakeFade > 0:
			shake_strength = lerpf(shake_strength,0,shakeFade * delta)
			$Camera2D.offset = randomOffset()

func _on_area_2d_body_entered(body):
	end = 1
	$hello.linear_velocity.y = 0
	$hello.gravity_scale = 0
	$goalSound.play()
	$Timer.start()
	$GameTime.stop()


func _on_timer_timeout():
	Trans2.change_scene("res://levelcomplete.tscn")
	
func _input(event):
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("click"):
		_slightzoom()
	if event.is_action_released("click"):
		_slightzoomout()

func apply_shake():
	shake_strength = randomStrength * shakeFade
	shakeFade -= 0.1
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))


func _on_hello_body_entered(body):
	if body.is_in_group("coll"):
		lock = 0
		
func _slightzoom() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.04,1.04), 0.3)

func _slightzoomout() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera2D, "zoom", Vector2(1.00,1.00), 0.3)
