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

	static private var openglcontextandroid_assign_native_callbacks = Lib.load ("openglcontextandroid", "openglcontextandroid_assign_native_callbacks", 3);
    private static var j_initialize = JNI.createStaticMethod("org/haxe/duell/opengl/DuellGLActivityExtension", "initialize", "()Lorg/haxe/duell/opengl/DuellGLView;");

    public static function setupMainContext(finishedCallback : Void -> Void) : Void
    {
    	onRenderOnMainContext = new Signal0();

    	mainContext = new GLContext(null);

        onRenderOnMainContext.addOnce(contextCreated);
        onRenderOnMainContext.addOnce(finishedCallback);

        /// should be called after main context is created because, the size change callbacks are called immediately
        openglcontextandroid_assign_native_callbacks(
            onRenderOnMainContext.dispatch,
            mainContextSizeChangedCallback,
            mainContext.onContextRecreated.dispatch
        );

        mainContext.javaView = j_initialize();
    }

    public static function contextCreated(): Void
    {
        mainContext.determinePlatformGraphicsCapabilities();
        GLExt.bindExtensions();
    }

    public static function mainContextSizeChangedCallback(width : Int, height : Int)
    {
        mainContext.contextWidth = width;
    	mainContext.contextHeight = height;

        GL.viewport(0, 0, width, height);

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

    private var javaView : Dynamic;

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

        var extensionsString: String = GL.getParameter(GLDefines.EXTENSIONS);

        if (extensionsString == null)
        {
            extensionsString = "GL_INVALID_ENUM";
        }

        extensions = extensionsString;

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

        trace("########################################");
    }

}
