/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 04/06/14
 * Time: 16:08
 */
package gl;

import msignal.Signal;

import cpp.Lib;

class GLContext
{
	/// STATIC
	public static var onRenderOnMainContext : Signal0;

	private static var mainContext : GLContext;
    public static function getMainContext() : GLContext
    {
    	return mainContext;
    }

	static private var openglcontextios_initialize_main_context = Lib.load ("openglcontextios", "openglcontextios_initialize_main_context", 2);
	static private var openglcontextios_get_main_context_width = Lib.load ("openglcontextios", "openglcontextios_get_main_context_width", 0);
    static private var openglcontextios_get_main_context_height = Lib.load ("openglcontextios", "openglcontextios_get_main_context_height", 0);
    
    public static function setupMainContext(params : GLContextParameters) : Void
    {
    	onRenderOnMainContext = new Signal0();

    	mainContext = new GLContext(null);

        /// should be called after main context is created because, the size change callbacks are called immediately
        var eaglContext = openglcontextios_initialize_main_context(
            onRenderOnMainContext.dispatch,
            mainContextSizeChangedCallback
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