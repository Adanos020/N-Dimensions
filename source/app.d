module pseudo3d.app;

import std.stdio;

import core.time;

import Dgame.Graphic.Color,

       Dgame.System.Keyboard,

       Dgame.Window.Event,
       Dgame.Window.Window;

import pseudo3d.engine;

///
struct App
{
private:
    Window _window  = void;
    bool   _running = false;

    Engine _engine;

    void pollEvents()
    {
        Event event;
        while (_window.poll(&event))
        {
            switch (event.type)
                with (Event.Type)
            {
                case Quit:
                {
                    _running = false;
                }
                break;

                case KeyDown:
                {
                    if (event.keyboard.key == Keyboard.Code.Esc)
                    {
                        _running = false;
                    }
                }
                break;

                default: break;
            }
        }
    }

    void draw()
    {
        _window.clear();
        _engine.draw(_window);
        _window.display();
    }

public:
    ///
    void run()
    {
        _window = Window(1600, 900, "N-Dimensions");
        _window.setClearColor(Color4b.Black);

        _engine.initialize();

        _running = true;

        MonoTime clock;
        auto start = clock.currTime;
        auto prev = clock.currTime - start;

        while (_running)
        {
            const auto now = clock.currTime - start;
            auto delta = (now - prev);
            prev = now;

            _engine.update(delta);

            draw();
            pollEvents();
        }
    }
}

void main()
{
    App app;
    try
    {
        app.run;
    }
    catch (Exception ex)
    {
        stderr.writeln(ex.msg);
    }
}
