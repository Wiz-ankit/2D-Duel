extends KinematicBody2D
var speed=400
var velocity=Vector2.ZERO
var direction=Vector2.ZERO
var rot=Vector2.ZERO
var canShoot=true
var health=100
onready var guncontainer=get_node("gunContainer")
onready var muzzle=get_node("gunContainer/Position2D")
onready var guntimer=get_node("guntimer")
onready var bullet=preload("res://bullet.tscn")
func _physics_process(delta):
	rot=get_global_mouse_position()-self.global_position
	guncontainer.rotation=rot.angle()
	direction=Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		 direction.y=-1
	elif Input.is_action_pressed("ui_down"):
		 direction.y=+1
	elif Input.is_action_pressed("ui_left"):
		 direction.x=-1
	elif Input.is_action_pressed("ui_right"):
		 direction.x=+1
	direction=direction.normalized()
	velocity=lerp(velocity,direction*speed,delta*30)
	move_and_slide(velocity)
	if Input.is_action_pressed("shoot"):
		if canShoot==true:
			shooting()
func shooting():
	var bulletInstance=bullet.instance()
	bulletInstance.position=muzzle.global_position
	bulletInstance.rotation=guncontainer.rotation
	get_parent().add_child(bulletInstance)
	canShoot=false
	guntimer.start()
func _on_guntimer_timeout():
	canShoot=true
	pass 
func damage(value):
	health=health-value
	if health<value:
		get_tree().reload_current_scene()
		
