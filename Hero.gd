extends KinematicBody2D

var rate = 120
var speed = Vector2.ZERO
var rate_jump = -380
var gravitasi = 12

onready var sprite = $Sprite

func _physics_process(delta):
	speed.y = speed.y + gravitasi
	
	if(Input.is_action_pressed("gerak_kanan")):
		speed.x = rate
	if(Input.is_action_pressed("gerak_kiri")):
		speed.x = -rate
	if(Input.is_action_pressed("lompat") and is_on_floor()):
		speed.y = rate_jump
	
	speed.x = lerp(speed.x, 0, 0.2)
	speed = move_and_slide(speed, Vector2.UP)

	update_animation()

func update_animation():
	if is_on_floor():
		#idle
		if speed.x < (rate * 0.5) and speed.x > (-rate * 0.5):
			sprite.play("idle")
		#run
		else:
			sprite.play("run")
	else:
		#fall
		if speed.y > 0:
			sprite.play("fall")
		#jump
		else:
			sprite.play("jump")
	
	sprite.flip_h = false
	if speed.x < 0:
		sprite.flip_h = true
