extends Node3D

const ROAD_LENGTH := 180.0
var dealership_area: Area3D
var player: CharacterBody3D
var cash := 25000

func _ready() -> void:
    player = $PlayerCar
    _build_world()
    _build_dealership()
    $UI/Dealership.set_game(self)
    _update_cash()

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("interact") and player.global_position.distance_to(Vector3(0, 0, -13)) < 9.0:
        $UI/Dealership.visible = not $UI/Dealership.visible
        player.set_physics_process(not $UI/Dealership.visible)

func _build_world() -> void:
    var ground := _box("Ground", Vector3(0,-0.6,0), Vector3(100,1,200), Color(0.20,0.34,0.22))
    add_child(ground)
    var road := _box("MainRoad", Vector3(0,-0.05,0), Vector3(12,0.12,180), Color(0.12,0.13,0.15))
    add_child(road)
    for z in range(-85, 90, 10):
        var line := _box("RoadMark", Vector3(0,0.025,z), Vector3(0.22,0.025,4.5), Color(0.95,0.88,0.55))
        add_child(line)
    for side in [-1,1]:
        for i in range(9):
            var h := 5.0 + float((i*7+int(side*3))%5)
            var b := _box("CityBuilding", Vector3(side*(13.0+float(i%3)*8.0),h/2.0,-70.0+i*17.0), Vector3(7,h,9), Color(0.34+0.04*(i%3),0.39,0.46))
            add_child(b)
        var sidewalk := _box("Sidewalk", Vector3(side*7.3,0.02,0), Vector3(2.2,0.2,180), Color(0.48,0.48,0.45))
        add_child(sidewalk)

func _build_dealership() -> void:
    var building := _box("Showroom", Vector3(0,2.2,-18), Vector3(20,4.4,12), Color(0.12,0.22,0.30))
    add_child(building)
    var sign := _box("ShowroomSign", Vector3(0,4.7,-11.85), Vector3(11,1.0,0.25), Color(0.08,0.65,0.82))
    add_child(sign)
    dealership_area = Area3D.new()
    dealership_area.position = Vector3(0,0,-13)
    var shape := CollisionShape3D.new()
    var sphere := SphereShape3D.new()
    sphere.radius = 8.0
    shape.shape = sphere
    dealership_area.add_child(shape)
    add_child(dealership_area)
    var display_car := _box("DisplayCar", Vector3(0,0.65,-9), Vector3(3.5,1.1,5.5), Color(0.75,0.12,0.08))
    add_child(display_car)

func _box(label: String, pos: Vector3, size: Vector3, color: Color) -> StaticBody3D:
    var body := StaticBody3D.new()
    body.name = label
    body.position = pos
    var mesh_node := MeshInstance3D.new()
    var mesh := BoxMesh.new()
    mesh.size = size
    mesh_node.mesh = mesh
    var mat := StandardMaterial3D.new()
    mat.albedo_color = color
    mat.roughness = 0.78
    mesh_node.material_override = mat
    body.add_child(mesh_node)
    var collision := CollisionShape3D.new()
    var shape := BoxShape3D.new()
    shape.size = size
    collision.shape = shape
    body.add_child(collision)
    return body

func _update_cash() -> void:
    $UI/HUD/Money.text = "CASH: $%s" % str(cash)

func buy_car(price: int) -> bool:
    if cash < price:
        return false
    cash -= price
    _update_cash()
    return true

func sell_car(price: int) -> void:
    cash += price
    _update_cash()
