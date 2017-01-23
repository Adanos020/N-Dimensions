module pseudo3d.engine;

import	std.stdio,
		std.math;

import	core.time;

import	Dgame.Window.Window,

		Dgame.Math.Vector3;

import	pseudo3d.drawables.cuboid,
		pseudo3d.drawables.hypercuboid,

		pseudo3d.math;

///
struct Engine
{
private:
	//Cuboid _cuboid;
	Hypercuboid _hypercuboid;

	Duration _totalDuration;

public:
	///
	void initialize()
	{
		//_cuboid = new Cuboid(Vector3f(100, 200, 400), Vector3f(0, 0, 1));
		_hypercuboid = new Hypercuboid(Vector4f(350, 350, 350, 350), Vector4f(0, 0, 0, 0));
		_hypercuboid.rotateXZ(10);
		_hypercuboid.rotateYZ(10);
	}

	///
	void update(in Duration delta)
	{
		_totalDuration += delta;
		/*
		const auto displacement = Vector3f(	0.01 * cos(0.000001 * _totalDuration.total!"usecs"),
											0.01 * sin(0.000005 * _totalDuration.total!"usecs"),
											0.05 * sin(0.000001 * _totalDuration.total!"usecs"));
		_cuboid.position = _cuboid.position + displacement * 2;
		*/
		/*
		const auto displacement = Vector4f(	0.03 * cos(0.000002 * _totalDuration.total!"usecs"),
											0.03 * sin(0.000002 * _totalDuration.total!"usecs"),
											0.03 * sin(0.000001 * _totalDuration.total!"usecs"),
											0.03 * cos(0.000001 * _totalDuration.total!"usecs"));
		_hypercuboid.position = _hypercuboid.position + displacement * 2;
		*/
		//_hypercuboid.rotateXY(delta.total!"usecs" * 0.0000001);
		//_hypercuboid.rotateXZ(delta.total!"usecs" * 0.0000001);
		//_hypercuboid.rotateYZ(delta.total!"usecs" * 0.0000001);
		_hypercuboid.rotateXW(delta.total!"usecs" * 0.0000005);
	}

	///
	void draw(in ref Window window)
	{
		//window.draw(_cuboid);
		window.draw(_hypercuboid);
	}
}
