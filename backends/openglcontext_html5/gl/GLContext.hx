/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package gl;

#if webgldebug
import js.html.webgl.WebGLDebugUtils;
#end

import html5_appdelegate.HTML5AppDelegate;
import js.Browser;
import js.html.webgl.ContextAttributes;
import msignal.Signal;

import js.Browser.document;
import js.html.*;
import js.html.webgl.RenderingContext;
import gl.GL;
import gl.GLConfig;
import msignal.Signal;

class GLContext
{
	/// STATIC
	public static var onRenderOnMainContext : Signal0;

	private static var mainContext : GLContext;

    private static var canvas : CanvasElement;

#if webgldebug
    private static var debugCanvas: WebGLDebugLostContextSimulatingCanvas;
#end

    private static var body : Element;

    private static var requestId : Int;

    public static function getMainContext() : GLContext
    {
    	return mainContext;
    }

    public static function setupMainContext(finishedCallback : Void->Void) : Void
    {
        var doc = js.Browser.document;
        body = doc.body;

    	onRenderOnMainContext = new Signal0();

        //create Canvas
        var dom: Element = doc.createElement('Canvas');
        canvas  = cast dom;

#if webgldebug
        debugCanvas = WebGLDebugUtils.makeLostContextSimulatingCanvas(canvas);
#end

        canvas.addEventListener(
            "webglcontextlost", handleContextLost, false);
        canvas.addEventListener(
            "webglcontextrestored", handleContextRestored, false);

        // grab the CanvasRenderingContext2D for drawing on
        var  webGLContext : RenderingContext = canvas.getContextWebGL({alpha:false, antialias:true, depth:true, premultipliedAlpha:false, preserveDrawingBuffer:false, stencil:true});

#if webgldebug
        WebGLDebugUtils.init(webGLContext);
        webGLContext = WebGLDebugUtils.makeDebugContext(webGLContext);

        //debugCanvas.loseContextInNCalls(5000);
#end
        var contextAttributes = webGLContext.getContextAttributes();

        if (!contextAttributes.stencil)
        {
            trace("Warning No Stencil buffer attached:");
        }

        // style can be used for postioning/styling the div or canvas.
        var style = dom.style;

        var d;
		if (GLConfig.html5ContainerID != null && (d = document.getElementById(GLConfig.html5ContainerID)) != null)
		{
			d.appendChild( dom );
		}
		else
		{
        	// add the canvas to the body of the document
        	body.appendChild( dom );
		}
        // setup dimensions.
        canvas.width  = GLConfig.html5Width;
        canvas.height = GLConfig.html5Height;
        canvas.id = "#duell-view";

        HTML5AppDelegate.instance().rootView = canvas;

    	mainContext = new GLContext(null);
        GL.context = webGLContext;
        GLExt.context = webGLContext;
        mainContext.determinePlatformGraphicsCapabilities();
        GLExt.bindExtensions();

        mainContext.nativeContext = webGLContext;
    	mainContext.contextWidth = canvas.width;
    	mainContext.contextHeight = canvas.height;
        GL.viewport(0,0,canvas.width, canvas.height);

        requestId = Browser.window.requestAnimationFrame(_onRequestAnimationFrame);

        finishedCallback();
    }

    @:noCompletion static function _onRequestAnimationFrame(time: Float): Void
    {
        onRenderOnMainContext.dispatch();
        requestId = Browser.window.requestAnimationFrame(_onRequestAnimationFrame);
    }

    @:noCompletion static function handleContextLost(event)
    {
        event.preventDefault();
        Browser.window.cancelAnimationFrame(requestId);
    }

    @:noCompletion static function handleContextRestored(event)
    {
        mainContext.onContextRecreated.dispatch();
        _onRequestAnimationFrame(0.0);
    }

    public static function mainContextSizeChangedCallback()
    {
        GL.viewport(0,0,canvas.width, canvas.height);
    	mainContext.contextWidth = canvas.width;
    	mainContext.contextHeight = canvas.height;
    	mainContext.onContextSizeChanged.dispatch();
    }

    /// INSTANCE

    // Is set on initialisation
    public var vendor(default, null): Null<String>;
    public var renderer(default, null): Null<String>;
    public var version(default, null): Null<String>;
    public var extensions(default, null): Null<String>;

    // API Extensions
    public var supportsDiscardFramebuffer(default, null): Bool = false;
    public var supportsVertexArrayObjects(default, null): Bool = false;

    // Limitation
    public var maxTextureSize(default, null): Int = 64; // From the spec
    public var maxRenderbufferSize(default, null): Int = 1; // From the spec
    public var maxCubeTextureSize(default, null): Int = 16; // From the spec
    public var maxVertexUniformVectors(default, null): Int = 128; // From the spec

    private var nativeContext : Dynamic;

    public var onContextRecreated : Signal0;
    public var onContextSizeChanged : Signal0;
    public var contextWidth : Int;
    public var contextHeight : Int;

    private function new(params : GLContextParameters) : Void
    {
        onContextRecreated = new Signal0();
    	onContextSizeChanged = new Signal0();
    }

    public function bind() : Void
    {

    }

    public function destroy() : Void
    {

    }

    private function determinePlatformGraphicsCapabilities(): Void
    {
        vendor = GL.getParameter(GLDefines.VENDOR);
        version = GL.getParameter(GLDefines.VERSION);
        renderer = GL.getParameter(GLDefines.RENDERER);

        extensions = Std.string(GL.getSupportedExtensions());

        var queryMaxTextureSize: Null<Int> = GL.getParameter(GLDefines.MAX_TEXTURE_SIZE);
        var queryMaxRenderbufferSize: Null<Int> = GL.getParameter(GLDefines.MAX_RENDERBUFFER_SIZE);
        var queryMaxCubeTextureSize: Null<Int> = GL.getParameter(GLDefines.MAX_CUBE_MAP_TEXTURE_SIZE);
        var queryMaxVertexUniformVectors: Null<Int> = GL.getParameter(GLDefines.MAX_VERTEX_UNIFORM_VECTORS);

        if (queryMaxTextureSize != null)
            maxTextureSize = queryMaxTextureSize;

        if (queryMaxRenderbufferSize != null)
            maxRenderbufferSize = queryMaxRenderbufferSize;

        if (queryMaxCubeTextureSize != null)
            maxCubeTextureSize = queryMaxCubeTextureSize;

        if (queryMaxVertexUniformVectors != null)
            maxVertexUniformVectors = queryMaxVertexUniformVectors;

        trace("##### Graphic Hardware Description #####");
        vendor != null ? trace("Vendor: ", vendor) : trace("Vendor: null");
        version != null ? trace("Version: ", version) : trace("Version: null");
        renderer != null ? trace("Renderer: ", renderer) : trace("Renderer: null");
        extensions != null ? trace("Extensions: ", extensions) : trace("Extensions: null");
        trace("##### Enabled Extensions #####");

        if (extensions.indexOf(GLExtDefines.EXT_discard_framebuffer) != -1)
        {
            this.supportsDiscardFramebuffer = true;
            trace(GLExtDefines.EXT_discard_framebuffer);
        }

        if (extensions.indexOf(GLExtDefines.OES_vertex_array_object) != -1)
        {
            this.supportsVertexArrayObjects = true;
            trace(GLExtDefines.OES_vertex_array_object);
        }

        trace("##### Limitations #####");

        trace("MAX_TEXTURE_SIZE: " + maxTextureSize);
        trace("MAX_RENDERBUFFER_SIZE: " + maxRenderbufferSize);
        trace("MAX_CUBE_MAP_TEXTURE_SIZE: " + maxCubeTextureSize);
        trace("MAX_VERTEX_UNIFORM_VECTORS: " + maxVertexUniformVectors);

        trace("########################################");
    }
}
