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

@:keep
@:keepInit
class GLExtDefines
{
    // String to compare against
    public static inline var EXT_discard_framebuffer          = "GL_EXT_discard_framebuffer";
    public static inline var COLOR_EXT            = 0x1800;
    public static inline var DEPTH_EXT            = 0x1801;
    public static inline var STENCIL_EXT          = 0x1802;

    #if html5
    public static inline var OES_vertex_array_object          = "OES_vertex_array_object";
    public static inline var VERTEX_ARRAY_BINDING_OES: Int = 34229;
	public static inline var DEPTH_TEXTURE					  = "WEBGL_depth_texture";
    #else
    public static inline var OES_vertex_array_object          = "GL_OES_vertex_array_object";
    public static inline var VERTEX_ARRAY_BINDING_OES    = 0x85B5;
	public static inline var DEPTH_TEXTURE					  = "GL_OES_packed_depth_stencil";
    #end
}
