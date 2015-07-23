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

// https://github.com/KhronosGroup/WebGLDeveloperTools/blob/master/src/debug/externs/webgl-debug.js

/**
 * @externs
 * @see http://www.khronos.org/webgl/wiki/Debugging
 * @see http://www.khronos.org/webgl/wiki/HandlingContextLost
 */

#if webgldebug

package js.html.webgl;

@:native("WebGLDebugUtils")
extern class WebGLDebugUtils
{
    /**
     * @nosideeffects
     * @param {number} value
     * @return {string}
     */
    static public function glEnumToString(value: Int): String;

    /**
     * @nosideeffects
     * @param {string} functionName
     * @param {Array} args Args.
     * @return {string} String.
     */
    static public function glFunctionArgsToString(functionName: String, args: Array<Dynamic>): String;

    /**
     * @param {WebGLRenderingContext} ctx
     */
    static public function init(context: RenderingContext): Void;

    /**
     * @param {HTMLCanvasElement} canvas
     * @return {WebGLDebugLostContextSimulatingCanvas}
     */
    static public function makeLostContextSimulatingCanvas(canvas: CanvasElement): WebGLDebugLostContextSimulatingCanvas;

    /**
     * @param {WebGLRenderingContext} context
     * @param {Function=} opt_onErrorFunc
     * @param {Function=} opt_onFunc
     * @return {WebGLDebugRenderingContext}
     */
    static public function makeDebugContext(context: RenderingContext, ?opt_onErrorFunc: Dynamic, ?opt_onFunc: Dynamic): WebGLDebugRenderingContext;
}

@:native("WebGLDebugUtils")
extern class WebGLDebugLostContextSimulatingCanvas extends CanvasElement
{
    public function getNumCalls(): Int;
    public function loseContext(): Void;
    public function loseContextInNCalls(value: Int): Void;
    public function restoreContext(): Void;

    /// -1: Turns off automatic restoring, 5000 = 5 sec;
    public function setRestoreTimeout(value: Int): Void;
}

@:native("WebGLDebugUtils")
extern class WebGLDebugRenderingContext extends RenderingContext
{

}

#end