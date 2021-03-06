extends Area2D
signal hit

# export lets us use this variable in the godot scene panel
# going to try to use types as often as i can
export var speed: int = 75
var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  # hide()
  screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
  # the player's movement vector - we set it to 0,0
  var velocity: Vector2 = Vector2.ZERO

  if Input.is_action_pressed("move_right"):
    velocity.x =+ 1
  if Input.is_action_pressed("move_left"):
    velocity.x -= 1
  if Input.is_action_pressed("move_down"):
    velocity.y += 1
  if Input.is_action_pressed("move_up"):
    velocity.y -= 1

  if velocity.length() > 0:
    velocity = velocity.normalized() * speed
    $PlayerWalk.play()
  else:
    $PlayerWalk.stop()

  position += velocity * delta
  position.x = clamp(position.x, 0, screen_size.x)
  position.y = clamp(position.y, 0, screen_size.y)

  if velocity.x > 0:
    $PlayerWalk.animation = "walk_right"
  if velocity.x < 0:
    $PlayerWalk.animation = "walk_left"
  if velocity.y > 0:
    $PlayerWalk.animation = "walk_down"
  if velocity.y < 0:
    $PlayerWalk.animation = "walk_up"

# *** signal functions are not currently auto created due to using VS Code ***
func _on_Player_body_entered(_body: Node) -> void:
  # player will hide when hit
  hide()
  emit_signal("hit")
  # set deferred tell godot to wait until it's safe to disable shape to avoid error
  $CollisionShape2D.set_deferred("disabled", true)

func start(pos: Vector2) -> void:
  position = pos
  show()
  $CollisionShape2D.disabled = false