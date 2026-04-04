extends Node3D

@onready var camera_3d : Camera3D = $"../../Camera3D"

@export var rotate_speed := 1.2
@export var smooth := 10.0

var _target_basis: Basis

func _ready() -> void:
	_target_basis = basis

func _process(delta: float) -> void:
	var yaw := 0.0
	var pitch := 0.0

	if Input.is_action_pressed("ui_left"):
		yaw += rotate_speed * delta
	if Input.is_action_pressed("ui_right"):
		yaw -= rotate_speed * delta
	if Input.is_action_pressed("ui_up"):
		pitch += rotate_speed * delta
	if Input.is_action_pressed("ui_down"):
		pitch -= rotate_speed * delta

	if yaw != 0.0:
		_target_basis = Basis(Vector3.UP, yaw) * _target_basis

	if pitch != 0.0:
		var screen_right := camera_3d.global_basis.x.normalized()
		_target_basis = Basis(screen_right, pitch) * _target_basis

	_target_basis = _target_basis.orthonormalized()
	basis = basis.slerp(_target_basis, min(1.0, smooth * delta)).orthonormalized()
