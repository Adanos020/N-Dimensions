module pseudo3d.drawables.cuboid;

import	std.math,
		std.stdio;

import	Dgame.Graphic.Color,
		Dgame.Graphic.Drawable,
		Dgame.Graphic.Shape,
		Dgame.Graphic.Transformable,

		Dgame.Math.Geometry,
		Dgame.Math.Vector2,
		Dgame.Math.Vector3,
		Dgame.Math.Vertex,

		Dgame.Window.Window;

import	pseudo3d.math;

///
class Cuboid : Transformable, Drawable
{
private:
	Vector3f _position;
	Vector3f _size;

	Vector3f[8] _vertices;
	size_t[] _elements = [
		0,	 1,		0,	 2,		0,	 4,		
		1,	 3,		1,	 5,		2,	 3,		
		2,	 6,		3,	 7,		4,	 5,		
		4,	 6,		5,	 7,		6,	 7
	];

	Shape _shape;

	void setVertices()
	{
		foreach (i; 0 .. _elements.length - 1)
		{
			_shape.getVertices[i].position = to2D(_vertices[_elements[i++]]) + Vector2f(screenPosition.x, screenPosition.y);
			_shape.getVertices[i].position = to2D(_vertices[_elements[ i ]]) + Vector2f(screenPosition.x, screenPosition.y);
		}
	}

public:
	///
	this(Vector3f size = Vector3f(1, 1, 1), Vector3f position = Vector3f(0, 0, 0))
	in {
		assert ((size.x > 0) || (size.y > 0) || (size.z > 0));
	}
	body {
		_shape = new Shape(Geometry.Lines);

		_size		= size;
		_position	= position;

		foreach (i; 0 .. 24)
		{
			_shape.append(Vector2f(0, 0));
		}

		size_t vertCount = 0;
		foreach (x; [-1, 1])
		{
			foreach (y; [-1, 1])
			{
				foreach (z; [-1, 1])
				{
					_vertices[vertCount++] = Vector3f(	_position.x + x * (_size.x / 2),
														_position.y + y * (_size.y / 2),
														_position.z + z * (_size.z / 2));
				}
			}
		}

		setVertices();

		_shape.setColor(Color4b.White);
		_shape.fill = Shape.Fill.Line;

		static if (false)
		foreach (i, vertex; _shape.getVertices)
		{
			writeln('v', i, ' ', vertex.position.x, ' ', vertex.position.y);
		}
	}

	///
	override void draw(ref const Window window) nothrow @nogc
	{
		window.draw(_shape);
	}

	/// Rotates a selected plane of the hypercuboid
	void rotate(string axis)(float θ)
		if (axis == "xy" ||
			axis == "xz" ||
			axis == "xw" ||
			axis == "yz" ||
			axis == "yw" ||
			axis == "zw")
	{
		static if (axis == "xy")
		foreach (ref vert; _vertices)
		{
			vert = Vector3f(vert.x * cos(θ) - vert.y * sin(θ),
							vert.x * sin(θ) + vert.y * cos(θ),
							vert.z);
		}
		else static if (axis == "xz")
		foreach (ref vert; _vertices)
		{
			vert = Vector3f(vert.x * cos(θ) + vert.z * sin(θ),
							vert.y,
							vert.x);
		}
		else static if (axis == "yz")
		foreach (ref vert; _vertices)
		{
			vert = Vector3f(vert.x,
							vert.y * cos(θ) - vert.z * sin(θ),
							vert.y);
		}
		setVertices();
	}

	alias rotateXY = rotate!"xy";
	alias rotateXZ = rotate!"xz";
	alias rotateYZ = rotate!"yz";

	@property
	{
		///
		Vector3f size() const
		{
			return _size;
		}

		///
		void size(Vector3f size)
		in {
			assert ((size.x > 0) || (size.y > 0) || (size.z > 0));
		}
		body {
			_size = size;
			setVertices();
		}

		///
		Vector3f position() const
		{
			return _position;
		}

		///
		Vector3f screenPosition() const
		{
			return _position + Vector3f(800, 450, 0);
		}

		///
		void position(Vector3f position)
		{
			_position = position;
			setVertices();
		}
	}
}
