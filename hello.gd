extends RigidBody2D

var already_jumped = false
var mouse_pos = Vector2()
var queue : Array
var dragging
var drag_start

@export var MAX_LENGTH : int
@export var lightcolor = Color()

func _ready():
	$PointLight2D.color = lightcolor
	$Sprite2D.modulate = lightcolor
	Global.jumps = 0
	process_mode = PROCESS_MODE_DISABLED
	await get_tree().create_timer(1.4).timeout
	process_mode = PROCESS_MODE_INHERIT
	
	
#this controls the movement of the player
func _input(event):
	if event.is_action_pressed("click") and already_jumped == false and not dragging:
		dragging = true
		drag_start = get_viewport().get_mouse_position()
	if event.is_action_released("click") and dragging:
		dragging = false
		var drag_end = get_viewport().get_mouse_position()
		var dir = drag_start - drag_end
		apply_impulse(Vector2(dir * 8))
		$JumpSound.play()
		already_jumped = true
		Global.jumps += 1
	
	
		#old movement below
		
		##$JumpSound.play()
		##sleeping = false
		##already_jumped = true
		##var mousepos = get_global_mouse_position()
		##var bodypos = self.position
		##var dir = -(bodypos - mousepos)
		##apply_impulse(Vector2(dir * 6))
		
#Here we can detect if it collides with spikes or other dangerous sprites
func _on_body_entered(body):
	if body.is_in_group("coll"):
		already_jumped = true
		gravity_scale = 0
		linear_velocity.x = 0
		linear_velocity.y = 0
		$deadSound2.play()
		$AnimationPlayer.play("Explode")
		await $AnimationPlayer.animation_finished
		Trans2.change_scene("res://dead.tscn")

	else:
		already_jumped = false
	sleeping = true
	
func _process(delta):
	#Here we can create the player's trail
	var pos = self.position
	queue.push_front(pos)
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
	$Trail.clear_points()
	
	for point in queue:
		$Trail.add_point(point)
	
	#here we do the predictive trail
	if dragging == true:
		var max_points = 400
		$Preline.clear_points()
		var drag_end = get_viewport().get_mouse_position()
		var dir = Vector2(drag_start - drag_end)
		var prepos: Vector2 = Vector2.ZERO
		var vel = (Vector2(dir * .25))
		$Preline/CollisionTest.position = Vector2.ZERO

#dir * .82
		for i in max_points:
			$Preline.add_point(prepos)
			var move = Vector2(vel.x,vel.y + .98)
			var collision = $Preline/CollisionTest.move_and_collide(move, false, true, true)
			if collision:
				vel = Vector2.ZERO
				$Preline/CollisionTest.linear_velocity = Vector2.ZERO
				break
			else:
				vel.y += .98
				prepos += vel
				$Preline/CollisionTest.position = prepos
	else:
		$Preline.clear_points()
