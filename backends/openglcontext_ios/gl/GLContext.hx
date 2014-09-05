/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 04/06/14
 * Time: 16:08
 */
package gl;

import msignal.Signal;

import types.Touch;

import cpp.Lib;


@:buildXml('
    <files id="haxe">
        <include name="${haxelib:opengl}/backends/openglcontext_ios/native.xml" />
    </files>
')

@:headerCode("
    #include <openglcontext_ios/GLTouch.h>
    #include <types/Touch.h>
    #include <types/TouchState.h>
")
class GLContext
{
	/// STATIC
	public static var onRenderOnMainContext : Signal0;
    public static var onTouchesOnMainContext : Signal1<Array<Touch>>;
    public static var mouseXInMainContext(default, null) : Int;
    public static var mouseYInMainContext(default, null) : Int;

    private static var touchPool : Array<Touch>;
    private static var touchesToSend : Array<Touch>;
    private static var touchPoolSize : Int = 40; /// well, doesn't cost anything

	private static var mainContext : GLContext;
    public static function getMainContext() : GLContext
    {
    	return mainContext;
    }

	static private var openglcontextios_initialize_main_context = Lib.load ("openglcontextios", "openglcontextios_initialize_main_context", 3);
	static private var openglcontextios_get_main_context_width = Lib.load ("openglcontextios", "openglcontextios_get_main_context_width", 0);
    static private var openglcontextios_get_main_context_height = Lib.load ("openglcontextios", "openglcontextios_get_main_context_height", 0);
    
    public static function setupMainContext(params : GLContextParameters) : Void
    {
        touchPool = [];
        for(i in 0...touchPoolSize)
        {
            touchPool.push(new Touch());
        }
        touchesToSend = [];

    	onRenderOnMainContext = new Signal0();

    	mainContext = new GLContext(null);

        /// should be called after main context is created because, the size change callbacks are called immediately
        onTouchesOnMainContext = new Signal1<Array<Touch>>();
        var eaglContext = openglcontextios_initialize_main_context(
            onRenderOnMainContext.dispatch,
            mainContextSizeChangedCallback,
            newTouchesCallback
        );

    	mainContext.nativeContext = eaglContext;
    	mainContext.contextWidth = openglcontextios_get_main_context_width();
    	mainContext.contextHeight = openglcontextios_get_main_context_height();
    }

    public static function mainContextSizeChangedCallback()
    {
    	mainContext.contextWidth = openglcontextios_get_main_context_width();
    	mainContext.contextHeight = openglcontextios_get_main_context_height();
    	mainContext.onContextSizeChanged.dispatch();
    }

    public static function newTouchesCallback(touches : Array<Dynamic>)
    {
        if (touches.length > touchesToSend.length)
        {
            for (i in touchesToSend.length...touches.length)
            {
                touchesToSend.push(touchPool[i]);
            }
        }
        else if (touches.length < touchesToSend.length)
        {
            touchesToSend.splice(touches.length, touchesToSend.length - touches.length);
        }

        for(i in 0...touches.length)
        {
            setupWithNativeGLTouch(touchesToSend[i], touches[i]);
        }

        onTouchesOnMainContext.dispatch(touchesToSend);
    }


    @:functionCode("
        openglcontext_ios::GLTouch *nativeTouch = (openglcontext_ios::GLTouch *)nativeGLTouch->__GetHandle();
        touch->x = nativeTouch->x;
        touch->y = nativeTouch->y;
        touch->timestamp = nativeTouch->timestamp;
        touch->id = nativeTouch->id;

        switch(nativeTouch->state) {
            case (int)0: {
                touch->state = ::types::TouchState_obj::TouchStateBegan;
            }
            ;break;
            case (int)1: {
                touch->state = ::types::TouchState_obj::TouchStateMoved;
            }
            ;break;
            case (int)2: {
                touch->state = ::types::TouchState_obj::TouchStateStationary;
            }
            ;break;
            case (int)3: {
                touch->state = ::types::TouchState_obj::TouchStateEnded;
            }
            ;break;
        }
    ") 
    private static function setupWithNativeGLTouch(touch : Touch, nativeGLTouch : Dynamic) : Void {}

    /// INSTANCE
    private var nativeContext : Dynamic; 

    public var onContextSizeChanged : Signal0;
    public var contextWidth : Int;
    public var contextHeight : Int;

    private function new(params : GLContextParameters) : Void
    {
    	onContextSizeChanged = new Signal0();
    }

    public function bind() : Void
    {

    }

    public function destroy() : Void
    {

    }

}