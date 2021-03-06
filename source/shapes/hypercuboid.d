module ndimensions.shapes.hypercuboid;

import std.math,
       std.stdio,
       std.typecons;

import Dgame.Graphic.Color,
       Dgame.Graphic.Drawable,
       Dgame.Graphic.Shape,
       Dgame.Graphic.Transformable,

       Dgame.Math.Geometry,
       Dgame.Math.Vector2,
       Dgame.Math.Vector3,
       Dgame.Math.Vertex,

       Dgame.Window.Window;

import ndimensions.math;

///
class Hypercuboid : Drawable
{
private:
    Vector4f _position;
    Vector4f _size;

    Vector4f[16] _vertices;
    size_t[] _elements = [
         0,  1,   0,  2,   0,  4,   0,  8,
         1,  3,   1,  5,   1,  9,   2,  3,
         2,  6,   2, 10,   3,  7,   3, 11,
         4,  5,   4,  6,   4, 12,   5,  7,
         5, 13,   6,  7,   6, 14,   7, 15,
         8,  9,   8, 10,   8, 12,   9, 11,
         9, 13,  10, 11,  10, 14,  11, 15,
        12, 13,  12, 14,  13, 15,  14, 15
    ];

    Shape _shape;

    Vector2f _screenCenter;

    void setVertices()
    {
        foreach (i; 0 .. _elements.length - 1)
        {
            _shape.getVertices[i].position = to2D(_vertices[_elements[i++]]) + screenPosition;
            _shape.getVertices[i].position = to2D(_vertices[_elements[ i ]]) + screenPosition;
        }
    }

public:
    ///
    this(in Vector4f size, in Vector4f position, in Vector2f screenSize)
    in {
        assert ((size.x > 0) && (size.y > 0) && (size.z > 0) && (size.w > 0));
        assert ((screenSize.x > 0) && (screenSize.y > 0));
    }
    body {
        _shape = new Shape(Geometry.Lines);

        _size     = size;
        _position = position;
        _screenCenter = screenSize / 2;

        foreach (i; 0 .. 64)
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
                    foreach (w; [-1, 1])
                    {
                        _vertices[vertCount++] = Vector4f(_position.x + x * (_size.x / 2),
                                                          _position.y + y * (_size.y / 2),
                                                          _position.z + z * (_size.z / 2),
                                                          _position.w + w * (_size.w / 2));
                    }
                }
            }
        }

        setVertices();

        _shape.setColor(Color4b.White);
        _shape.fill = Shape.Fill.Line;
    }

    override void draw(ref const Window window) nothrow @nogc
    {
        window.draw(_shape);
    }

    /// Rotates selected plane of the hypercuboid.
    void rotate(string axis)(float θ)
        if (axis == "xy" || axis == "yx" ||
            axis == "xz" || axis == "zx" ||
            axis == "xw" || axis == "wx" ||
            axis == "yz" || axis == "zy" ||
            axis == "yw" || axis == "wy" ||
            axis == "zw" || axis == "wz")
    {
        static if (axis == "xy" || axis == "yx")
        foreach (ref vert; _vertices)
        {
            vert = Vector4f(vert.x * cos(θ) - vert.y * sin(θ),
                            vert.x * sin(θ) + vert.y * cos(θ),
                            vert.z,
                            vert.w);
        }
        else static if (axis == "xz" || axis == "zx")
        foreach (ref vert; _vertices)
        {
            vert = Vector4f(vert.x * cos(θ) - vert.z * sin(θ),
                            vert.y,
                            vert.x * sin(θ) + vert.z * cos(θ),
                            vert.w);
        }
        else static if (axis == "xw" || axis == "wx")
        foreach (ref vert; _vertices)
        {
            vert = Vector4f(vert.x * cos(θ) - vert.w * sin(θ),
                            vert.y,
                            vert.z,
                            vert.x * sin(θ) + vert.w * cos(θ));
        }
        else static if (axis == "yz" || axis == "zy")
        foreach (ref vert; _vertices)
        {
            vert = Vector4f(vert.x,
                            vert.y * cos(θ) - vert.z * sin(θ),
                            vert.y * sin(θ) + vert.z * cos(θ),
                            vert.w);
        }
        else static if (axis == "yw" || axis == "wy")
        foreach (ref vert; _vertices)
        {
            vert = Vector4f(vert.x,
                            vert.y * cos(θ) - vert.w * sin(θ),
                            vert.z,
                            vert.y * sin(θ) + vert.w * cos(θ));
        }
        else static if (axis == "zw" || axis == "wz")
        foreach (ref vert; _vertices)
        {
            vert = Vector4f(vert.x,
                            vert.y,
                            vert.z * cos(θ) - vert.w * sin(θ),
                            vert.z * sin(θ) + vert.w * cos(θ));
        }
        setVertices();
    }

    alias rotateXY = rotate!"xy"; alias rotateYX = rotate!"yx";
    alias rotateXZ = rotate!"xz"; alias rotateZX = rotate!"zx";
    alias rotateXW = rotate!"xw"; alias rotateWX = rotate!"wx";
    alias rotateYZ = rotate!"yz"; alias rotateZY = rotate!"zy";
    alias rotateYW = rotate!"yw"; alias rotateWY = rotate!"wy";
    alias rotateZW = rotate!"zw"; alias rotateWZ = rotate!"wz";

    /// Moves the hypercuboid along chosen axis.
    void move(string axis)(float displacemet)
        if (axis == "x" || axis == "y" || axis == "z" || axis == "w")
    {
        foreach (ref vertex; _vertices)
        {
            mixin ("vertex." ~ axis ~ " += displacemet;");
        }
        setVertices();
    }

    alias moveX = move!"x";
    alias moveY = move!"y";
    alias moveZ = move!"z";
    alias moveW = move!"w";

    /// Scales the hypercuboid along chosen axis.
    void scale(string axis)(float scale)
        if (axis == "x" || axis == "y" || axis == "z" || axis == "w")
    {
        foreach (ref vertex; _vertices)
        {
            mixin ("vertex." ~ axis ~ " *= scale;");
        }
        setVertices();
    }

    alias scaleX = scale!"x";
    alias scaleY = scale!"y";
    alias scaleZ = scale!"z";
    alias scaleW = scale!"w";

    @property
    {
        ///
        Vector4f size() const
        {
            return _size;
        }

        ///
        void size(Vector4f size)
        in {
            assert ((size.x > 0) && (size.y > 0) && (size.z > 0) && (size.w > 0));
        }
        body {
            _size = size;
            setVertices();
        }

        ///
        Vector4f position() const
        {
            return _position;
        }

        ///
        Vector2f screenPosition() const
        {
            return Vector2f(_screenCenter.x + _position.x,
                            _screenCenter.y + _position.y);
        }

        ///
        void position(Vector4f position)
        {
            const auto displacement = _position - position;

            foreach (ref vert; _vertices)
            {
                vert += displacement;
            }

            _position = position;
            setVertices();
        }
    }
}
