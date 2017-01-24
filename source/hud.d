module ndimensions.hud;

import Dgame.Math.Vector2,

       Dgame.Graphic.Color,
       Dgame.Graphic.Drawable,
       Dgame.Graphic.Text,

       Dgame.System.Font,

       Dgame.Window.Window;

///
class HUD : Drawable
{
private:
    Font unifont = void;

    Text _manipulationMode = null;

public:
    ///
    this(in Vector2i winSize)
    {
        unifont = Font("assets/font/unifont-9.0.06.ttf", 15);

        _manipulationMode = new Text(unifont);
        _manipulationMode.setPosition(Vector2f(10, 10));
        _manipulationMode.foreground = Color4b.White;
        _manipulationMode.background = Color4b(0, 0, 0, 0);
    }

    ~this()
    {
        _manipulationMode = null;
    }

    override void draw(in ref Window window) nothrow @nogc
    {
        window.draw(_manipulationMode);
    }

    @property
    {
        ///
        void manipulationMode(in string str)
        {
            _manipulationMode.format(str);
        }

        ///
        ref Text manipulationMode()
        {
            return _manipulationMode;
        }
    }
}
