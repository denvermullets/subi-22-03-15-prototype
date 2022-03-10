extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  var mob_types: PoolStringArray = $AnimatedSprite.frames.get_animation_names()
  $AnimatedSprite.playing = true
  $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityNotifier2D_screen_exited() -> void:
  queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
