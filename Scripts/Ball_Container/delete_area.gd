extends Area2D


func onBodyEntered(body: Node2D):
	if body.is_in_group('Ball'):
		body.queue_free()
