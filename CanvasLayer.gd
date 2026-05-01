extends Node2D

#This is the timer code

var time: float = 0.0
var seconds: int = 0
var msec: int = 0
var lock = 1
var flashing = 1

#Countdown begins right as scene is loaded with 0.5 second delay
func _ready():
	set_process(false)
	await get_tree().create_timer(0.5).timeout
	$countdownAudio.play()
	$CanvasLayer/Countdown.visible = true
	$AnimationPlayer.play("countdownfade")
	await $AnimationPlayer.animation_finished
	$CanvasLayer/Countdown.text = "Set"
	$AnimationPlayer.play("countdownfade")
	await $AnimationPlayer.animation_finished
	$CanvasLayer/Countdown.text = "Go!"
	$AnimationPlayer.speed_scale = 1
	$AnimationPlayer.play("countdownfade")
	set_process(true)

func _process(delta):

	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	$CanvasLayer/Panel/seconds.text = "%02d." % seconds
	$CanvasLayer/Panel/msec.text = "%03d" % msec
	
func stop() -> void:
	Global.final_time = "%.3f" % time
	print(Global.final_time)
	if Global.level == ("res://level_4.tscn"):
		if seconds <= 15:
			Global.skill = 3
		elif seconds <= 20:
			Global.skill = 2
		else:
			Global.skill = 1
	elif Global.level == ("res://level_5.tscn"):
		if seconds <= 22:
			Global.skill = 3
		elif seconds <= 25:
			Global.skill = 2
		else:
			Global.skill = 1
	else:
		if seconds <= 6:
			Global.skill = 3
		elif seconds <= 10:
			Global.skill = 2
		else:
			Global.skill = 1
	print(Global.skill)
	set_process(false)
