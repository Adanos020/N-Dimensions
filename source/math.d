module ndimensions.math;

import std.traits : isNumeric;

import Dgame.Math.Vector2,
       Dgame.Math.Vector3;

///
struct Vector4(T)
    if (isNumeric!T)
{
    T x = 0;
    T y = 0;
    T z = 0;
    T w = 0;

    ///
    @nogc
    this(T x, T y, T z = 0, T w = 0) pure nothrow
    {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }

    ///
    @nogc
    this(U)(U x, U y, U z = 0, U w = 0) pure nothrow
        if (isNumeric!U && !is(U == T))
    {
        this(cast(T) x, cast(T) y, cast(T) z, cast(T) w);
    }

    ///
    @nogc
    this(U)(Vector4!U vec) pure nothrow
        if (isNumeric!U && !is(U == T))
    {
        this(vec.x, vec.y, vec.z, vec.w);
    }

    ///
    @nogc
    bool opEquals(in Vector4!T rhs) const pure nothrow
    {
        return (x == rhs.x) && (y == rhs.y) && (z == rhs.y) && (w == rhs.w);
    }

    ///
    @nogc
    ref Vector4!T opOpAssign(string op)(in Vector4!T rhs) pure nothrow
        if ((op == "+")
         || (op == "-")
         || (op == "*")
         || (op == "/")
         || (op == "%"))
    {
        mixin("x " ~ op ~ "= rhs.x;");
        mixin("y " ~ op ~ "= rhs.y;");
        mixin("z " ~ op ~ "= rhs.z;");
        mixin("w " ~ op ~ "= rhs.w;");

        return this;
    }

    ///
    @nogc
    ref Vector4!T opOpAssign(string op)(in T rhs) pure nothrow
        if ((op == "+")
         || (op == "-")
         || (op == "*")
         || (op == "/")
         || (op == "%"))
    {
        mixin("x " ~ op ~ "= rhs;");
        mixin("y " ~ op ~ "= rhs;");
        mixin("z " ~ op ~ "= rhs;");
        mixin("w " ~ op ~ "= rhs;");

        return this;
    }

    ///
    @nogc
    Vector4!T opBinary(string op)(in Vector4!T rhs) const pure nothrow
        if ((op == "+")
         || (op == "-")
         || (op == "*")
         || (op == "/")
         || (op == "%"))
    {
        mixin("return Vector4!T(x " ~ op ~ " rhs.x,"
                            ~ " y " ~ op ~ " rhs.y,"
                            ~ " z " ~ op ~ " rhs.z,"
                            ~ " w " ~ op ~ " rhs.w);");
    }

    ///
    @nogc
    Vector4!T opBinary(string op)(in T rhs) const pure nothrow
        if ((op == "+")
         || (op == "-")
         || (op == "*")
         || (op == "/")
         || (op == "%"))
    {
        mixin("return Vector4!T(x " ~ op ~ " rhs,"
                            ~ " y " ~ op ~ " rhs,"
                            ~ " z " ~ op ~ " rhs,"
                            ~ " w " ~ op ~ " rhs);");
    }
}

alias Vector4i = Vector4!int;
alias Vector4f = Vector4!float;

///
Vector2f to2D(in Vector3f point)
{
    return Vector2f(point.x / ((1000 + point.z) / 1000),
                    point.y / ((1000 + point.z) / 1000));
}

///
Vector2f to2D(in Vector4f point)
{
    return to2D(to3D(point));
}

///
Vector3f to3D(in Vector4f point)
{
    return Vector3f(point.x / ((1000 + point.w) / 1000),
                    point.y / ((1000 + point.w) / 1000),
                    point.z / ((1000 + point.w) / 1000));
}
