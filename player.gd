extends CharacterBody2D

const SPEED := 280.0
const JUMP_FORCE := -520.0
const GRAVITY := 1350.0

var spawn_position := Vector2.ZERO

func _ready() -> void:
    spawn_position = global_position
    queue_redraw()

func _physics_process(delta: float) -> void:
    var direction := Input.get_axis("move_left", "move_right")
    velocity.x = move_toward(velocity.x, direction * SPEED, 1800.0 * delta)

    if not is_on_floor():
        velocity.y += GRAVITY * delta
    elif Input.is_action_just_pressed("jump"):
        velocity.y = JUMP_FORCE

    move_and_slide()
    global_position.x = clamp(global_position.x, 28.0, 932.0)

    if global_position.y > 620.0:
        global_position = spawn_position
        velocity = Vector2.ZERO

func _draw() -> void:
    draw_circle(Vector2(0, -18), 15.0, Color("#f3d7b5"))
    draw_rect(Rect2(-16, -4, 32, 28), Color("#4d8dd9"), true)
    draw_rect(Rect2(-14, 24, 10, 16), Color("#26385f"), true)
    draw_rect(Rect2(4, 24, 10, 16), Color("#26385f"), true)
    draw_circle(Vector2(-5, -20), 2.0, Color("#202020"))
    draw_circle(Vector2(5, -20), 2.0, Color("#202020"))
    draw_line(Vector2(-7, -14), Vector2(7, -14), Color("#8c4438"), 2.0)
