extends Node

@onready var timer: Timer = $Timer
@onready var ball = preload("res://Scenes/ball.tscn")

func _ready():
	self.timer.start()
	self.timer.timeout.connect(self.onTimer)
	
func onTimer():
	var ball_int: RigidBody2D = ball.instantiate()
	ball_int.apply_impulse(Vector2.from_angle(randf_range(0, 2 * PI)) * 100)
	self.add_child(ball_int)
