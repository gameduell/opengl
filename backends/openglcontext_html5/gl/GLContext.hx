/**
 * @autor kgar
 * @date 05.09.2014.
 * @company Gameduell GmbH
 */
package gl;

import msignal.Signal;

import js.Browser.document;
import js.html.*;
import js.html.webgl.RenderingContext;
import gl.GL;

import types.Touch;

import msignal.Signal;

class GLContext
{
	/// STATIC
	public static var onRenderOnMainContext : Signal0;

	private static var mainContext : GLContext;

    private static var canvas : CanvasElement;
    private static var body:Element;

    public static function getMainContext() : GLContext
    {
    	return mainContext;
    }

    
    public static function setupMainContext(params : GLContextParameters) : Void
    {
        var doc = js.Browser.document;
        body = doc.body;

    	onRenderOnMainContext = new Signal0();

        //create Canvas
        var dom: Element = doc.createElement('Canvas');
        canvas  = cast dom;
        // grab the CanvasRenderingContext2D for drawing on
        var  webGLContext : RenderingContext =  canvas.getContextWebGL();
        // style can be used for postioning/styling the div or canvas.
        var style = dom.style;
        // add the canvas to the body of the document
        body.appendChild( dom );
        // setup dimensions.
        canvas.width  = gl.GLInitialState.html5Width ;    
        canvas.height = gl.GLInitialState.html5Height;
        canvas.id = "#duell-view";

    	mainContext = new GLContext(null);
        GL.context = webGLContext;
        mainContext.nativeContext = webGLContext;
    	mainContext.contextWidth = canvas.width;
    	mainContext.contextHeight = canvas.height;
        GL.viewport(0,0,canvas.width, canvas.height);

        
        var timer = new haxe.Timer(16); // 1000ms delay
        timer.run = function(){
            onRenderOnMainContext.dispatch();
        };

    }

    public static function mainContextSizeChangedCallback()
    {
    	mainContext.contextWidth = canvas.width;
    	mainContext.contextHeight = canvas.height;
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