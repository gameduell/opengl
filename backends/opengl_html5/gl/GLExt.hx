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

import js.html.webgl.ExtensionVertexArray;
import gl.GLExtDefines;

import js.html.webgl.RenderingContext;

typedef GLVertexArrayObject = js.html.webgl.VertexArray;

@:keep
@:keepInit
class GLExt
{
    public static var nullVertexArrayObject: GLVertexArrayObject = null;

    public static var context : RenderingContext;
    public static var vertexArrayExtension: ExtensionVertexArray;

    public static function discardFramebufferEXT(target:Int, color:Int = 0, depth:Int = 0, stencil:Int = 0): Void
    {
        // Not supported by WebGL
    }

    public static function createVertexArrayOES(): GLVertexArrayObject
    {
        vertexArrayExtension = context.getExtension(GLExtDefines.OES_vertex_array_object);
        return vertexArrayExtension.createVertexArrayOES();
    }

    public static function deleteVertexArrayOES(arrayObject: GLVertexArrayObject): Void
    {
        vertexArrayExtension = context.getExtension(GLExtDefines.OES_vertex_array_object);
        vertexArrayExtension.deleteVertexArrayOES(arrayObject);
    }

    public static function bindVertexArrayOES(arrayObject: GLVertexArrayObject): Void
    {
        vertexArrayExtension = context.getExtension(GLExtDefines.OES_vertex_array_object);
        vertexArrayExtension.bindVertexArrayOES(arrayObject);
    }

    public static function isVertexArrayOES(arrayObject: GLVertexArrayObject): Bool
    {
        vertexArrayExtension = context.getExtension(GLExtDefines.OES_vertex_array_object);
        return vertexArrayExtension.isVertexArrayOES(arrayObject);
    }
}
