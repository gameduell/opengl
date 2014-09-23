/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 04/06/14
 * Time: 16:08
 */
package gl;

import msignal.Signal;

import cpp.Lib;

import hxjni.JNI;

import gl.GL;

@:buildXml('

    <target id="haxe" tool="linker" toolid="${haxelink}" output="${HAXE_OUTPUT}${DBG}">
        <lib name="-lGLESv2" />
    </target>

')
class GLContext
{
	/// STATIC
	public static var onRenderOnMainContext : Signal0;

	private static var mainContext : GLContext;
    public static function getMainContext() : GLContext
    {
    	return mainContext;
    }

	static private var openglcontextandroid_assign_native_callbacks = Lib.load ("openglcontextandroid", "openglcontextandroid_assign_native_callbacks", 2);
    private static var j_initialize = JNI.createStaticMethod("org/haxe/duell/opengl/DuellGLActivityExtension", "initialize", "()Lorg/haxe/duell/opengl/DuellGLView;");

    public static function setupMainContext(finishedCallback : Void -> Void) : Void
    {
    	onRenderOnMainContext = new Signal0();

    	mainContext = new GLContext(null);

        onRenderOnMainContext.addOnce(finishedCallback);
        
        /// should be called after main context is created because, the size change callbacks are called immediately
        openglcontextandroid_assign_native_callbacks(
            onRenderOnMainContext.dispatch,
            mainContextSizeChangedCallback
        );

        mainContext.javaView = j_initialize();

    }

    public static function mainContextSizeChangedCallback(width : Int, height : Int)
    {
        mainContext.contextWidth = width; 
    	mainContext.contextHeight = height;

        GL.viewport(0, 0, width, height);

    	mainContext.onContextSizeChanged.dispatch();
    }

    /// INSTANCE

    private var javaView : Dynamic;

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