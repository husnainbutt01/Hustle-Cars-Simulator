extends CharacterBody3D

@export var acceleration := 17.0
@export var max_speed := 24.0
@export var reverse_speed := 9.0
@export var turn_speed := 1.65
@export var friction := 9.0
var speed := 0.0

func _ready() -> void:
    # Keyboard controls also work with a connected controller.
    for action in ["accelerate","brake","steer_left","steer_right","interact"]:
        if not InputMap.has_action(action):
            InputMap.add_action(action)
    _key("accelerate", KEY_W)
    _key("accelerate", KEY_UP)
    _key("brake", KEY_S)
    _key("brake", KEY_DOWN)
    _key("steer_left", KEY_A)
    _key("steer_left", KEY_LEFT)
    _key("steer_right", KEY_D)
    _key("steer_right", KEY_RIGHT)
    _key("interact", KEY_E)

func _key(action: String, keycode: Key) -> void:
    var ev := InputEventKey.new()
    ev.physical_keycode = keycode
    InputMap.action_add_event(action, ev)

func _physics_process(delta: float) -> void:
    var throttle := Input.get_action_strength("accelerate") - Input.get_action_strength("brake")
    if throttle > 0:
        speed = move_toward(speed, max_speed, acceleration*delta)
    elif throttle < 0:
        speed = move_toward(speed, -reverse_speed, acceleration*delta)
    else:
        speed = move_toward(speed, 0.0, friction*delta)
    var steer := Input.get_action_strength("steer_right") - Input.get_action_strength("steer_left")
    if abs(speed) > 0.3:
        rotate_y(-steer * turn_speed * delta * clamp(abs(speed)/8.0,0.25,1.0) * sign(speed))
    var forward := -global_transform.basis.z
    velocity.x = forward.x * speed
    velocity.z = forward.z * speed
    velocity.y -= 22.0 * delta
    move_and_slide()
    if global_position.y < -5:
        global_position = Vector3(0,1,5)
        speed = 0
