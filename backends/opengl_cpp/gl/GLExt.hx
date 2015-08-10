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

import gl.GLDefines;
import gl.GLExtDefines;
import types.Data;

@:buildXml('

	<files id="haxe">

		<include name="${haxelib:duell_types}/backends/types_cpp/native.xml" />

	</files>

')

@:headerCode('
	#include <types/NativeData.h>

	#include <cstdlib>
	#ifdef ANDROID
	#include <GLES2/gl2.h>
	#include <GLES2/gl2ext.h>
	#endif

	#ifdef IPHONE
	#include <OpenGLES/ES2/gl.h>
	#include <OpenGLES/ES2/glext.h>
	#endif

	#ifdef HX_MACOS
    #import <OpenGL/OpenGL.h>
    #import <OpenGL/gl.h>
	#endif
')

@:cppFileCode('

namespace hx{
	HX_CHAR *NewString(int inLen);
}

#ifdef HX_MACOS


#endif

')

@:headerClassCode('
')

@:keep
@:keepInit
class GLExt {

    @:functionCode('
        GLenum discards[] = {0,0,0};

        GLsizei count = 0;

        if (color == GL_COLOR_ATTACHMENT0)
        {
            discards[count] = GL_COLOR_ATTACHMENT0;
            ++count;
        }

        if (depth == GL_DEPTH_ATTACHMENT)
        {
            discards[count] = GL_DEPTH_ATTACHMENT;
            ++count;
        }

        if (stencil == GL_STENCIL_ATTACHMENT)
        {
            discards[count] = GL_STENCIL_ATTACHMENT;
            ++count;
        }

        glDiscardFramebufferEXT(target, count, discards);
	')
    public static function discardFramebufferEXT(target:Int, color:Int = 0, depth:Int = 0, stencil:Int = 0): Void {}
}
