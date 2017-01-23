module pseudo3d.drawables.cuboid;

import	std.stdio;

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

	Shape _vertices;

	void setVertices()
	{
		// front top
		_vertices.getVertices[0].position = to2D(Vector3f(_position.x - _size.x / 2,
														  _position.y - _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[1].position = to2D(Vector3f(_position.x + _size.x / 2,
														  _position.y - _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// front right
		_vertices.getVertices[2].position = to2D(Vector3f(_position.x + _size.x / 2,
														  _position.y - _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[3].position = to2D(Vector3f(_position.x + _size.x / 2,
														  _position.y + _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// front bottom
		_vertices.getVertices[4].position = to2D(Vector3f(_position.x + _size.x / 2,
														  _position.y + _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[5].position = to2D(Vector3f(_position.x - _size.x / 2,
														  _position.y + _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// front left
		_vertices.getVertices[6].position = to2D(Vector3f(_position.x - _size.x / 2,
														  _position.y - _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[7].position = to2D(Vector3f(_position.x - _size.x / 2,
														  _position.y + _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// left top
		_vertices.getVertices[8].position = to2D(Vector3f(_position.x - _size.x / 2,
														  _position.y - _size.y / 2,
														  _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[9].position = to2D(Vector3f(_position.x - _size.x / 2,
														  _position.y - _size.y / 2,
														  _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// left back
		_vertices.getVertices[10].position = to2D(Vector3f(_position.x - _size.x / 2,
														   _position.y - _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[11].position = to2D(Vector3f(_position.x - _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// left bottom
		_vertices.getVertices[12].position = to2D(Vector3f(_position.x - _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[13].position = to2D(Vector3f(_position.x - _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// back top
		_vertices.getVertices[14].position = to2D(Vector3f(_position.x - _size.x / 2,
														   _position.y - _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[15].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y - _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// back bottom
		_vertices.getVertices[16].position = to2D(Vector3f(_position.x - _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[17].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// right back
		_vertices.getVertices[18].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[19].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y - _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// right top
		_vertices.getVertices[20].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y - _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[21].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y - _size.y / 2,
														   _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
		// right bottom
		_vertices.getVertices[22].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z - _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);

		_vertices.getVertices[23].position = to2D(Vector3f(_position.x + _size.x / 2,
														   _position.y + _size.y / 2,
														   _position.z + _size.z / 2))
											+ Vector2f(screenPosition.x, screenPosition.y);
	}

public:
	///
	this(Vector3f size = Vector3f(1, 1, 1), Vector3f position = Vector3f(0, 0, 0))
	in {
		assert ((size.x > 0) || (size.y > 0) || (size.z > 0));
	}
	body {
		_vertices = new Shape(Geometry.Lines);

		foreach (i; 0 .. 24)
		{
			_vertices.append(Vector2f(0, 0));
		}

		_vertices.setColor(Color4b.White);
		_vertices.fill = Shape.Fill.Line;

		this.size		= size;
		this.position	= position;

		foreach (i, vertex; _vertices.getVertices)
		{
			writeln('v', i, ' ', vertex.position.x, ' ', vertex.position.y);
		}
	}

	///
	override void draw(ref const Window window) nothrow @nogc
	{
		window.draw(_vertices);
	}

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
