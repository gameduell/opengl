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
    static private var openglcontextios_removeSplashScreen = Lib.load("openglcontextios", "openglcontextios_removeSplashScreen", 2);
    static private var openglcontextios_get_splashScreenRemoved = Lib.load("openglcontextios", "openglcontextios_get_splashScreenRemoved", 0);

    public static function setupMainContext(finishedCallback : Void->Void) : Void
    {
    	onRenderOnMainContext = new Signal0();

    	mainContext = new GLContext(null);

        /// should be called after main context is created because, the size change callbacks are called immediately
        var eaglContext = openglcontextios_initialize_main_context(
            onRenderOnMainContext.dispatch,
            mainContextSizeChangedCallback
        );

        mainContext.determinePlatformGraphicsCapabilities();
        GLExt.bindExtensions(); // Does nothing on iOS

    	mainContext.nativeContext = eaglContext;
    	mainContext.contextWidth = openglcontextios_get_main_context_width();
    	mainContext.contextHeight = openglcontextios_get_main_context_height();

        if (!GLInitialState.iosShowSplashScreen)
            mainContext.removeSplashScreen();

        finishedCallback();
    }

    public static function mainContextSizeChangedCallback()
    {
    	mainContext.contextWidth = openglcontextios_get_main_context_width();
    	mainContext.contextHeight = openglcontextios_get_main_context_height();
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

    public function removeSplashScreen(delay: Float = 0.0, fadeOutDuration: Float = 0.0): Void
    {
        if (!splashScreenRemoved())
            openglcontextios_removeSplashScreen(delay, fadeOutDuration);
    }

    public function splashScreenRemoved(): Bool
    {
        return openglcontextios_get_splashScreenRemoved();
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

        var queryMaxTextureSize: Null<Int> = GL.getParameter(GLDefines.MAX_TEXTURE_SIZE);
        var queryMaxCubeTextureSize: Null<Int> = GL.getParameter(GLDefines.MAX_CUBE_MAP_TEXTURE_SIZE);
        var queryMaxVertexUniformVectors: Null<Int> = GL.getParameter(GLDefines.MAX_VERTEX_UNIFORM_VECTORS);

        if (queryMaxTextureSize != null)
            maxTextureSize = queryMaxTextureSize;

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
        trace("MAX_CUBE_MAP_TEXTURE_SIZE: " + maxCubeTextureSize);
        trace("MAX_VERTEX_UNIFORM_VECTORS: " + maxVertexUniformVectors);

        trace("########################################");
    }
}
