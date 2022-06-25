tool
extends Node2D
## Draw-based 2D confetti particles emitter.
class_name FakeConfettiParticles

## If `true`, particles are being emitted.
export (bool) var emitting = false setget _set_emitting
## The type of particles:
## - `0 (Square)`.
## - `1 (Circle)`.
export (int, "Square", "Circle") var type = 0
## The number of particles.
export (int) var amount = 100

## The size of the particles.
##
## If the particles are squares, `size` is the length of their sides.
## If the particles are circles, `size` is their radius.
export (float) var size = 6.0

## The color/s of the particles.
export (Array) var colors = [
	Color("#008751"),
	Color("#00e436"),
	Color("#29adff"),
	Color("#7e2553"),
	Color("#83769c"),
	Color("#ff004d"),
	Color("#ff77a8"),
	Color("#ffa300"),
	Color("#ffec27")
]
## If `true`, only one emission cycle occurs.
export (bool) var one_shot = true
## If `true`, the particles will gradually fade.
##
## If `false`, the particles will end abruptly.
export (bool) var fade = true
## The duration (in seconds) of the emission cycle.
export (float) var timer_wait_time = 10.0

var particles = []
var particles_amount
var particles_position
var timer = 0.0


func _ready():
	set_process(false)
	self.emitting = not Engine.editor_hint


func _process(delta):
	timer += delta

	if timer > timer_wait_time:
		timer = 0.0

		if one_shot:
			self.emitting = false
		else:
			_create_particles()

	_particles_explode(delta)

	update()


func _draw():
	for particle in particles:
		if type == 0:
			draw_rect(Rect2(particle.position, particle.size), particle.color)
		elif type == 1:
			draw_circle(
				particle.position, ((particle.size.x + particle.size.y) / 2) / 2, particle.color
			)


func _create_particles():
	particles.clear()
	particles_amount = amount
	particles_position = get_viewport_rect().size / 2

	for _i in particles_amount:
		var particle = {
			color = _get_random_color(),
			gravity = _get_random_gravity(),
			position = particles_position,
			size = Vector2(size, size),
			velocity = _get_random_velocity()
		}

		particles.append(particle)


func _particles_explode(delta):
	for particle in particles:
		if fade:
			particle.color.a -= 0.6 * delta

		particle.velocity.x *= .999
		particle.velocity.y *= .991

		particle.position += (particle.velocity + particle.gravity) * delta


func _get_random_color():
	return colors[randi() % colors.size()]


func _get_random_gravity():
	return Vector2(rand_range(-200, 200), rand_range(400, 800))


func _get_random_velocity():
	return Vector2(rand_range(-200, 200), rand_range(-600, -800))


func _set_emitting(new_value):
	if new_value != emitting:
		emitting = new_value

		if emitting:
			set_process(true)
			_create_particles()
		else:
			set_process(false)
			particles.clear()
			timer = 0.0
			update()
			property_list_changed_notify()
