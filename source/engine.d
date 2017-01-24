module ndimensions.engine;

import  std.stdio,
        std.math,

        core.time;

import  Dgame.Math.Vector2,
        Dgame.Math.Vector3,

        Dgame.System.Keyboard,

        Dgame.Window.Window;

import  ndimensions.hud,

        ndimensions.math,

        ndimensions.shapes.cuboid,
        ndimensions.shapes.hypercuboid;

///
struct Engine
{
private:
    HUD _hud;

    Cuboid _cuboid;
    Hypercuboid _hypercuboid;

    Duration _totalDuration;

    enum ManipulationMode
    {
        Move,
        Rotate,
        Scale
    }

    ManipulationMode _mode = ManipulationMode.Move;

public:
    ///
    this(Vector2i winSize)
    {
        _hud = new HUD(winSize);
        _hud.manipulationMode = "Manipulation mode: move";
                              //~ "\nControls:\n"
                              //~ "x → move along x-axis\n"
                              //~ "y → move along y-axis\n"
                              //~ "z → move along z-axis\n"
                              //~ "w → move along w-axis\n"
                              //~ "Shift → invert the direction of movement\n";

        //_cuboid = new Cuboid(Vector3f(350, 350, 350), Vector3f(0, 0, 0));
        _hypercuboid = new Hypercuboid(Vector4f(350, 350, 350, 350), Vector4f(0, 0, 0, 0), cast(Vector2f) winSize);
    }

    ~this()
    {
        _hud = null;
        _hypercuboid = null;
    }

    ///
    void update(in Duration delta)
    {
        _totalDuration += delta;

        with (Keyboard.Code)
        {
            const byte sign = (Keyboard.isPressed(LShift) ? -1 : 1);
            const float change = delta.total!"usecs" * 0.0000005 * sign;

            if (Keyboard.isPressed(M))
            {
                _mode = ManipulationMode.Move;
                _hud.manipulationMode = "Manipulation mode: move";
                                      //~ "\nControls:\n"
                                      //~ "x → move along x-axis\n"
                                      //~ "y → move along y-axis\n"
                                      //~ "z → move along z-axis\n"
                                      //~ "w → move along w-axis\n"
                                      //~ "Shift → invert the direction of movement\n";
            }
            else if (Keyboard.isPressed(R))
            {
                _mode = ManipulationMode.Rotate;
                _hud.manipulationMode = "Manipulation mode: rotate";
                                      //~ "\nControls:\n"
                                      //~ "x + y → rotate x-y plane\n"
                                      //~ "x + z → rotate x-z plane\n"
                                      //~ "x + w → rotate x-w plane\n"
                                      //~ "y + z → rotate y-z plane\n"
                                      //~ "y + w → rotate y-w plane\n"
                                      //~ "z + w → rotate z-w plane\n"
                                      //~ "Shift → invert the direction of rotation\n";
            }
            else if (Keyboard.isPressed(S))
            {
                _mode = ManipulationMode.Scale;
                _hud.manipulationMode = "Manipulation mode: scale (WIP)";
            }

            if (Keyboard.isPressed(X))
            {
                if (_mode == ManipulationMode.Move)
                {
                    _hypercuboid.moveX(change * 1000);
                }
                else if (_mode == ManipulationMode.Rotate)
                {
                    if (Keyboard.isPressed(Y))
                    {
                        _hypercuboid.rotateXY(change);
                    }
                    if (Keyboard.isPressed(Z))
                    {
                        _hypercuboid.rotateXZ(change);
                    }
                    if (Keyboard.isPressed(W))
                    {
                        _hypercuboid.rotateXW(change);
                    }
                }
                else if (_mode == ManipulationMode.Scale)
                {
                    
                }
            }
            else if (Keyboard.isPressed(Y))
            {
                if (_mode == ManipulationMode.Move)
                {
                    _hypercuboid.moveY(change * 1000);
                }
                else if (_mode == ManipulationMode.Rotate)
                {
                    if (Keyboard.isPressed(X))
                    {
                        _hypercuboid.rotateYX(change);
                    }
                    if (Keyboard.isPressed(Z))
                    {
                        _hypercuboid.rotateYZ(change);
                    }
                    if (Keyboard.isPressed(W))
                    {
                        _hypercuboid.rotateYW(change);
                    }
                }
                else if (_mode == ManipulationMode.Scale)
                {

                }
            }
            else if (Keyboard.isPressed(Z))
            {
                if (_mode == ManipulationMode.Move)
                {
                    _hypercuboid.moveZ(change * 1000);
                }
                else if (_mode == ManipulationMode.Rotate)
                {
                    if (Keyboard.isPressed(X))
                    {
                        _hypercuboid.rotateZX(change);
                    }
                    if (Keyboard.isPressed(Y))
                    {
                        _hypercuboid.rotateZY(change);
                    }
                    if (Keyboard.isPressed(W))
                    {
                        _hypercuboid.rotateZW(change);
                    }
                }
                else if (_mode == ManipulationMode.Scale)
                {

                }
            }
            else if (Keyboard.isPressed(W))
            {
                if (_mode == ManipulationMode.Move)
                {
                    _hypercuboid.moveW(change * 1000);
                }
                else if (_mode == ManipulationMode.Rotate)
                {
                    if (Keyboard.isPressed(X))
                    {
                        _hypercuboid.rotateWX(change);
                    }
                    if (Keyboard.isPressed(Y))
                    {
                        _hypercuboid.rotateWZ(change);
                    }
                    if (Keyboard.isPressed(Z))
                    {
                        _hypercuboid.rotateWZ(change);
                    }
                }
                else if (_mode == ManipulationMode.Scale)
                {

                }
            }
        }

        //_hypercuboid.position = _hypercuboid.position + displacement * 2;

        //_cuboid.rotateXY(delta.total!"usecs" * 0.0000005);
        //_cuboid.rotateXZ(delta.total!"usecs" * 0.0000005);
        //_cuboid.rotateYZ(delta.total!"usecs" * 0.0000005);
    }

    ///
    void draw(in ref Window window)
    {
        //window.draw(_cuboid);
        window.draw(_hypercuboid);
        window.draw(_hud);
    }
}
