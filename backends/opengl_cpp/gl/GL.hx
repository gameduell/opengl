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
import types.Data;


typedef GLBuffer = Int;
typedef GLFramebuffer = Int;
typedef GLRenderbuffer = Int;
typedef GLProgram = Int;
typedef GLUniformLocation = Int;
typedef GLShader = Int;
typedef GLTexture = Int;

@:buildXml('

    <target id="haxe" tool="linker" toolid="${haxelink}" output="${HAXE_OUTPUT}${DBG}" >
        <lib name="-lEGL" if="android" />
        <lib name="-lGLESv2" if="android" />
    </target>

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
class GL {

    public static var nullShader = 0;
    public static var nullBuffer = 0;
    public static var nullFramebuffer = 0;
    public static var nullRenderbuffer = 0;
    public static var nullProgram = 0;
    public static var nullUniformLocation = -1;
    public static var nullTexture = -1;


	@:functionCode('
    	glActiveTexture(position);
	')
    public static function activeTexture(position:Int):Void {}

	@:functionCode('
    	glAttachShader( program,
    					shader );
	')
    public static function attachShader(program:GLProgram, shader:GLShader):Void {}

	@:functionCode('
    	glBindAttribLocation(program, index, name.__CStr());
	')
    public static function bindAttribLocation(program:GLProgram, index:Int, name:String):Void {}

	@:functionCode('
    	glBindBuffer(target, buffer);
	')
    public static function bindBuffer(target:Int, buffer:GLBuffer):Void {}

    @:functionCode('
    	glBindFramebuffer(target, framebuffer);
	')
    public static function bindFramebuffer(target:Int, framebuffer:GLFramebuffer):Void {}

    @:functionCode('
    	glBindRenderbuffer(target, renderbuffer);
	')
    public static function bindRenderbuffer(target:Int, renderbuffer:GLRenderbuffer):Void {}

	@:functionCode('
    	glBindTexture(target, texture);
	')
    public static function bindTexture(target:Int, texture:GLTexture):Void {}

    @:functionCode('
    	glBlendColor(red, green, blue, alpha);
	')
    public static function blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void  {}

    @:functionCode('
    	glBlendEquation(mode);
	')
    public static function blendEquation(mode:Int):Void  {}

    @:functionCode('
    	glBlendEquationSeparate(modeRGB, modeAlpha);
	')
    public static function blendEquationSeparate(modeRGB:Int, modeAlpha:Int):Void  {}

    @:functionCode('
    	glBlendFunc(sfactor, dfactor);
	')
    public static function blendFunc(sfactor:Int, dfactor:Int):Void  {}

    @:functionCode('
    	glBlendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha);
	')
    public static function blendFuncSeparate(srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void  {}

	@:functionCode('
    	glBufferData(target, data->_nativeData->offsetLength, (uint8_t*)data->_nativeData->ptr + data->_nativeData->offset, usage);
	')
    public static function bufferData(target:Int, data:Data, usage:Int):Void {}

	@:functionCode('
    	glBufferSubData(target, offsetInBuffer, data->_nativeData->offsetLength, (uint8_t*)data->_nativeData->ptr + data->_nativeData->offset);
	')
    public static function bufferSubData(target:Int, offsetInBuffer:Int, data:Data):Void {}

	@:functionCode('
    	glClearColor(red, green, blue, alpha);
	')
    public static function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void {}

	@:functionCode('
    	glClear(mask);
	')
    public static function clear(mask:Int):Void {}

    @:functionCode('
	#ifdef HX_MACOS
    	glClearDepth(depth);
	#else
    	glClearDepthf(depth);
    #endif
	')
    public static function clearDepth(depth:Float):Void  {}

    @:functionCode('
    	glClearStencil(s);
	')
    public static function clearStencil(s:Int):Void  {}

    @:functionCode('
    	glColorMask(red, green, blue, alpha);
	')
    public static function colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void  {}

	@:functionCode('
    	glCompileShader(shader);
	')
    public static function compileShader(shader:GLShader):Void {}

    @:functionCode('
    	glCompressedTexImage2D(target, level, internalFormat, width, height, border, data->_nativeData->offsetLength, (uint8_t*)data->_nativeData->ptr + data->_nativeData->offset);
	')
    public static function compressedTexImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, data:Data):Void  {}

    @:functionCode('
    	glCompressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, data->_nativeData->offsetLength, (uint8_t*)data->_nativeData->ptr + data->_nativeData->offset);
	')
    public static function compressedTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, data:Data):Void  {}

    @:functionCode('
    	glCopyTexImage2D(target, level, internalFormat, x, y, width, height, border);
	')
    public static function copyTexImage2D(target:Int, level:Int, internalFormat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void  {}

    @:functionCode('
    	glCopyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height);
	')
    public static function copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void  {}

    @:functionCode('
        return glCheckFramebufferStatus(target);
	')
    public static function checkFramebufferStatus(target:Int):Int { return 0; }

	@:functionCode('
		GLuint program = glCreateProgram();
    	return program;
	')
    public static function createProgram():GLProgram { return 0; }

    @:functionCode('
		GLuint bufferID;
    	glGenFramebuffers(1, &bufferID);
    	return bufferID;
	')
    public static function createFramebuffer():GLFramebuffer {return 0;}

	@:functionCode('
		GLuint bufferID;
    	glGenBuffers(1, &bufferID);
    	return bufferID;
	')
    public static function createBuffer():GLBuffer { return 0; }

	@:functionCode('
    	GLuint shader = glCreateShader(type);
    	return shader;
	')
    public static function createShader(type:Int):GLShader { return 0; }

    @:functionCode('
		GLuint bufferID;
    	glGenRenderbuffers(1, &bufferID);
    	return bufferID;
	')
    public static function createRenderbuffer():GLRenderbuffer {return 0;}

	@:functionCode('
		GLuint textureID;
    	glGenTextures(1, &textureID);
    	return textureID;
	')
    public static function createTexture():GLTexture { return 0; }

    @:functionCode('
        glCullFace(mode);
	')
    public static function cullFace(mode:Int):Void  {}

    @:functionCode('
        glDeleteFramebuffers(1, (const unsigned int*)&framebuffer);
	')
    public static function deleteFramebuffer(framebuffer:GLFramebuffer):Void {}

    @:functionCode('
        glDeleteRenderbuffers(1, (const unsigned int*)&renderbuffer);
	')
    public static function deleteRenderbuffer(renderbuffer:GLRenderbuffer):Void {}

	@:functionCode('
    	glDeleteProgram(program);
	')
    public static function deleteProgram(program:GLProgram):Void {}

	@:functionCode('
    	glDeleteShader(shader);
	')
    public static function deleteShader(shader:GLShader):Void {}

    @:functionCode('
    	glDeleteTextures(1, (const unsigned int*)&texture);
	')
    public static function deleteTexture(texture:GLTexture)  {}

    @:functionCode('
    	glDeleteBuffers(1, (const unsigned int*)&shader);
	')
    public static function deleteBuffer(shader:GLBuffer):Void {}

    @:functionCode('
    	glDepthFunc(func);
	')
    public static function depthFunc(func:Int):Void {}

    @:functionCode('
        if (flag)
        {
            glDepthMask(GL_TRUE);
        }
        else
        {
            glDepthMask(GL_FALSE);
        }
	')
    public static function depthMask(flag:Bool):Void {}

    @:functionCode('
    	glDetachShader(program, shader);
	')
    public static function detachShader(program:GLProgram, shader:GLShader):Void {}

    @:functionCode('
    	glDisable(cap);
	')
    public static function disable(cap:Int)  {}

    @:functionCode('
    	glDisableVertexAttribArray(index);
	')
    public static function disableVertexAttribArray(index:Int)  {}

    @:functionCode('
    	glDrawElements(mode, count, type, (void*)offset);
	')
    public static function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void {}

    @:functionCode('
    	glDrawArrays(mode, first, count);
	')
    public static function drawArrays(mode:Int, first:Int, count:Int):Void {}

    @:functionCode('
    	glEnable(cap);
	')
    public static function enable(cap:Int)  {}

    @:functionCode('
    	glEnableVertexAttribArray(index);
	')
    public static function enableVertexAttribArray(index:Int):Void {}

    @:functionCode('
    	glFinish();
	')
    public static function finish()  {}

    @:functionCode('
    	glFlush();
	')
    public static function flush()  {}

    @:functionCode('
    	glFramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer);
	')
    public static function framebufferRenderbuffer(target:Int, attachment:Int, renderbuffertarget:Int, renderbuffer:GLRenderbuffer)  {}

    @:functionCode('
    	glFramebufferTexture2D(target, attachment, textarget, texture, level);
	')
    public static function framebufferTexture2D(target:Int, attachment:Int, textarget:Int, texture:GLTexture, level:Int)  {}

    @:functionCode('
    	glFrontFace(mode);
	')
    public static function frontFace(mode:Int)  {}

    @:functionCode('
    	glGenerateMipmap(target);
	')
    public static function generateMipmap(target : Int) {}

    @:functionCode('
        char buf[1024];
        GLsizei outLen = 1024;
        GLsizei size = 0;
        GLenum  type = 0;

        glGetActiveAttrib(program, index, 1024, &outLen, &size, &type, buf);

		HX_CHAR *name = hx::NewString(outLen);
		memcpy(name, buf, sizeof(HX_CHAR)*(outLen));

        hx::Anon anon = hx::Anon_obj::Create();
        anon->Add(HX_CSTRING("name") , ::String(name, outLen), false);
        anon->Add(HX_CSTRING("size") , (int)size, false);
        anon->Add(HX_CSTRING("type") , (int)type, false);
        return anon;
	')
    public static function getActiveAttrib(program:GLProgram, index:Int):GLActiveInfo {return null;}

    @:functionCode('
        static const int BUF_SIZE = 1024;
        char buf[BUF_SIZE];
        GLsizei outLen = 1024;
        GLsizei size = 0;
        GLenum  type = 0;

        glGetActiveUniform(program, index, BUF_SIZE, &outLen, &size, &type, buf);

		HX_CHAR *name = hx::NewString(outLen);
		memcpy(name, buf, sizeof(HX_CHAR)*(outLen));

        hx::Anon anon = hx::Anon_obj::Create();
        anon->Add(HX_CSTRING("name") , ::String(name, outLen),false);
        anon->Add(HX_CSTRING("size") , (int)size, false);
        anon->Add(HX_CSTRING("type") , (int)type, false);
        return anon;
	')
    public static function getActiveUniform(program:GLProgram, index:Int) {return null;}

    @:functionCode('
        static const int BUF_SIZE = 1024;
        GLuint buf[BUF_SIZE];
        GLsizei outLen = 1024;
        glGetAttachedShaders(program, BUF_SIZE, &outLen, buf);

        Array< int > output = Array_obj< int >::__new();

        for(int i = 0; i < outLen; ++i)
        {
            output->push(buf[i]);
        }

        return output;
	')
    public static function getAttachedShaders(program:GLProgram):Array<GLShader> {return null;}

    @:functionCode('
    	return glGetAttribLocation(program, name.__CStr());
	')
    public static function getAttribLocation(program:GLProgram, name:String):Int {return 0;}

    @:functionCode('
        GLint data = 0;
        glGetBufferParameteriv(target, pname, &data);
        return data;
	')
    public static function getBufferParameter(target:Int, pname:Int):Dynamic {return null;}

    @:functionCode('
        int floats = 0;
        int ints = 0;
        int strings = 0;

        switch(pname)
        {
            case GL_ALIASED_LINE_WIDTH_RANGE:
            case GL_ALIASED_POINT_SIZE_RANGE:
            case GL_DEPTH_RANGE:
                floats = 2;
                break;

            case GL_BLEND_COLOR:
            case GL_COLOR_CLEAR_VALUE:
                floats = 4;
                break;

            case GL_COLOR_WRITEMASK:
                ints = 4;
                break;

            //case GL_COMPRESSED_TEXTURE_FORMATS  null

            case GL_MAX_VIEWPORT_DIMS:
                ints = 2;
                break;
            case GL_SCISSOR_BOX:
            case GL_VIEWPORT:
                ints = 4;
                break;

            // case GL_ARRAY_BUFFER_BINDING  WebGLBuffer
            // case GL_CURRENT_PROGRAM  WebGLProgram
            // case GL_ELEMENT_ARRAY_BUFFER_BINDING  WebGLBuffer
            case GL_FRAMEBUFFER_BINDING:
                int val;
                glGetIntegerv(pname,&val);
                return val;
            // case GL_RENDERBUFFER_BINDING  WebGLRenderbuffer
            // case GL_TEXTURE_BINDING_2D  WebGLTexture
            // case GL_TEXTURE_BINDING_CUBE_MAP  WebGLTexture

            case GL_DEPTH_CLEAR_VALUE:
            case GL_LINE_WIDTH:
            case GL_POLYGON_OFFSET_FACTOR:
            case GL_POLYGON_OFFSET_UNITS:
            case GL_SAMPLE_COVERAGE_VALUE:
                ints = 1;
                break;

            case GL_BLEND:
            case GL_DEPTH_WRITEMASK:
            case GL_DITHER:
            case GL_CULL_FACE:
            case GL_POLYGON_OFFSET_FILL:
            case GL_SAMPLE_COVERAGE_INVERT:
            case GL_STENCIL_TEST:
            //case GL_UNPACK_FLIP_Y_WEBGL:
            //case GL_UNPACK_PREMULTIPLY_ALPHA_WEBGL:
                ints = 1;
                break;

            case GL_ALPHA_BITS:
            case GL_ACTIVE_TEXTURE:
            case GL_BLEND_DST_ALPHA:
            case GL_BLEND_DST_RGB:
            case GL_BLEND_EQUATION_ALPHA:
            case GL_BLEND_EQUATION_RGB:
            case GL_BLEND_SRC_ALPHA:
            case GL_BLEND_SRC_RGB:
            case GL_BLUE_BITS:
            case GL_CULL_FACE_MODE:
            case GL_DEPTH_BITS:
            case GL_DEPTH_FUNC:
            case GL_DEPTH_TEST:
            case GL_FRONT_FACE:
            case GL_GENERATE_MIPMAP_HINT:
            case GL_GREEN_BITS:
            case GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS:
            case GL_MAX_CUBE_MAP_TEXTURE_SIZE:
            //case GL_MAX_FRAGMENT_UNIFORM_VECTORS:
            //case GL_MAX_RENDERBUFFER_SIZE:
            case GL_MAX_TEXTURE_IMAGE_UNITS:
            case GL_MAX_TEXTURE_SIZE:
            //case GL_MAX_VARYING_VECTORS:
            case GL_MAX_VERTEX_ATTRIBS:
            case GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS:
            //case GL_MAX_VERTEX_UNIFORM_VECTORS:
            case GL_NUM_COMPRESSED_TEXTURE_FORMATS:
            case GL_PACK_ALIGNMENT:
            case GL_RED_BITS:
            case GL_SAMPLE_BUFFERS:
            case GL_SAMPLES:
            case GL_SCISSOR_TEST:
            case GL_SHADING_LANGUAGE_VERSION:
            case GL_STENCIL_BACK_FAIL:
            case GL_STENCIL_BACK_FUNC:
            case GL_STENCIL_BACK_PASS_DEPTH_FAIL:
            case GL_STENCIL_BACK_PASS_DEPTH_PASS:
            case GL_STENCIL_BACK_REF:
            case GL_STENCIL_BACK_VALUE_MASK:
            case GL_STENCIL_BACK_WRITEMASK:
            case GL_STENCIL_BITS:
            case GL_STENCIL_CLEAR_VALUE:
            case GL_STENCIL_FAIL:
            case GL_STENCIL_FUNC:
            case GL_STENCIL_PASS_DEPTH_FAIL:
            case GL_STENCIL_PASS_DEPTH_PASS:
            case GL_STENCIL_REF:
            case GL_STENCIL_VALUE_MASK:
            case GL_STENCIL_WRITEMASK:
            case GL_SUBPIXEL_BITS:
            case GL_UNPACK_ALIGNMENT:
            //case GL_UNPACK_COLORSPACE_CONVERSION_WEBGL:
                ints = 1;
                break;

            case GL_EXTENSIONS:
                strings = 1;
                break;
            case GL_VENDOR:
                strings = 1;
                break;
            case GL_VERSION:
                strings = 1;
                break;
            case GL_RENDERER:
                strings = 1;
                break;
        }
        if (ints==1)
        {
            int val;
            glGetIntegerv(pname,&val);
            return val;
        }
        else if (strings==1)
        {
            const char* val = (const char *)glGetString(pname);
            int val_size = strlen(val);

            HX_CHAR *result = hx::NewString(val_size);

            memcpy(result, val, sizeof(HX_CHAR)*(val_size));

            return ::String(result, val_size);
        }
        else if (floats==1)
        {
            float f;
            glGetFloatv(pname,&f);
            return f;
        }
        else if (ints>0)
        {
            int vals[4];
            glGetIntegerv(pname,vals);

            Array< int > result = Array_obj< int >::__new();
            for(int i=0;i<ints;i++)
                result->push(vals[i]);
            return result;
        }
        else if (floats>0)
        {
            float vals[4];
            glGetFloatv(pname,vals);

            Array< Float > result = Array_obj< Float >::__new();
            for(int i=0;i<floats;i++)
                result->push(vals[i]);
            return result;
        }
	')
    public static function getParameter(pname:Int):Dynamic {return null;}

    @:functionCode('
    	return glGetError();
	')
    public static function getError():Int {return 0;}

    @:functionCode('
        GLint result = 0;
        glGetFramebufferAttachmentParameteriv(target, attachment, pname, &result);
    	return result;
	')
    public static function getFramebufferAttachmentParameter(target:Int, attachment:Int, pname:Int):Dynamic {return null;}

    @:functionCode('
		GLint logLength;
    	glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);

    	if (logLength > 0)
    	{
            HX_CHAR *result = hx::NewString(logLength);

    	    glGetProgramInfoLog(program, logLength, 0, result);

			::String str = ::String(result, logLength);

			return str;
   		}
	')
    public static function getProgramInfoLog(program:GLProgram):String { return "";}

    @:functionCode('
		GLint val;
		glGetProgramiv(program, pname, &val);
		return val;
	')
    public static function getProgramParameter(program:GLProgram, pname:Int):Int { return 0; }

    @:functionCode('
        int result = 0;
        glGetRenderbufferParameteriv(target, pname, &result);
        return result;
    ')
    public static function getRenderBufferParameter(target:Int, pname:Int):Dynamic {return null;}

    @:functionCode('

		GLint logLength;
    	glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLength);

    	if (logLength > 0)
    	{
            HX_CHAR *result = hx::NewString(logLength);

    	    glGetShaderInfoLog(shader, logLength, 0, result);

			::String str = ::String(result, logLength);

			return str;
   		}
   		return ::String((char*)0, 0);
	')
    public static function getShaderInfoLog(shader:GLShader):String { return ""; }

    @:functionCode('
		GLint val = 0;
		glGetShaderiv(shader, pname, &val);
		return val;
	')
    public static function getShaderParameter(shader:GLShader, pname:Int):Int { return 0; }

    @:functionCode('

        #ifndef HX_MACOS

        int range[2];
        int precision;
        glGetShaderPrecisionFormat(shadertype, precisiontype, range, &precision);

        hx::Anon anon = hx::Anon_obj::Create();
        anon->Add(HX_CSTRING("rangeMin"), range[0], false);
        anon->Add(HX_CSTRING("rangeMax"), range[1], false);
        anon->Add(HX_CSTRING("precision"), precision, false);
        return anon;

        #endif
    ')
    public static function getShaderPrecisionFormat(shadertype:Int, precisiontype:Int):GLShaderPrecisionFormat {return null;}

    @:functionCode('

		GLint len;
    	glGetShaderiv(shader, GL_SHADER_SOURCE_LENGTH, &len);

    	if (len > 0)
    	{
            HX_CHAR *result = hx::NewString(len);

    	    glGetShaderSource(shader, len, 0, result);

			::String str = ::String(result, len);

			return str;
   		}
	')
    public static function getShaderSource(shader:GLShader):String {return "";}

    @:functionCode('
        int result = 0;
        glGetTexParameteriv(target, pname, &result);
        return result;
	')
    public static function getTexParameter(target:Int, pname:Int):Dynamic {return null;}

    @:functionCode('
        char buf[1];
        GLsizei outLen = 1;
        GLsizei size = 0;
        GLenum  type = 0;

        glGetActiveUniform(program, location, 1, &outLen, &size, &type, buf);
        int ints = 0;
        int floats = 0;
        int bools = 0;
        switch(type)
        {
            case  GL_FLOAT:
            {
                float result = 0;
                glGetUniformfv(program, location, &result);
                return result;
            }

            case  GL_FLOAT_VEC2:  floats = 2;
            case  GL_FLOAT_VEC3:  floats = 3;
            case  GL_FLOAT_VEC4:  floats = 4;
                break;

            case  GL_INT_VEC2: ints = 2;
            case  GL_INT_VEC3: ints = 3;
            case  GL_INT_VEC4: ints = 4;
                break;

            case  GL_BOOL_VEC2: bools = 2;
            case  GL_BOOL_VEC3: bools = 3;
            case  GL_BOOL_VEC4: bools = 4;
                break;

            case  GL_FLOAT_MAT2: floats = 4; break;
            case  GL_FLOAT_MAT3: floats = 9; break;
            case  GL_FLOAT_MAT4: floats = 16; break;
            #ifdef HX_MACOS
            case  GL_FLOAT_MAT2x3: floats = 4*3; break;
            case  GL_FLOAT_MAT2x4: floats = 4*4; break;
            case  GL_FLOAT_MAT3x2: floats = 9*2; break;
            case  GL_FLOAT_MAT3x4: floats = 9*4; break;
            case  GL_FLOAT_MAT4x2: floats = 16*2; break;
            case  GL_FLOAT_MAT4x3: floats = 16*3; break;
            #endif

            case  GL_INT:
            case  GL_BOOL:
            case  GL_SAMPLER_2D:
            #ifdef HX_MACOS
            case  GL_SAMPLER_1D:
            case  GL_SAMPLER_3D:
            case  GL_SAMPLER_CUBE:
            case  GL_SAMPLER_1D_SHADOW:
            case  GL_SAMPLER_2D_SHADOW:
            #endif
            {
                int result = 0;
                glGetUniformiv(program, location, &result);
                return result;
            }
        }

        if (ints + bools > 0)
        {
            int buffer[4];
            glGetUniformiv(program, location, buffer);

            Array< int > result = Array_obj< int >::__new();
            for(int i = 0; i < ints + bools; i++)
                result->push(buffer[i]);
            return result;
        }
        if (floats>0)
        {
            float buffer[16*3];
            glGetUniformfv(program, location, buffer);

            Array< Float > result = Array_obj< Float >::__new();
            for(int i = 0; i < floats; i++)
                result->push(buffer[i]);
            return result;
        }
	')
    public static function getUniform(program:GLProgram, location:GLUniformLocation):Dynamic {return null;}

    @:functionCode('
		GLuint val = glGetUniformLocation(program, name.__CStr());
		return val;
	')
    public static function getUniformLocation(program:GLProgram, name:String):GLUniformLocation {return 0;}

    @:functionCode('
        int result = 0;
        glGetVertexAttribiv(index, pname, &result);
        return result;
	')
    public static function getVertexAttrib(index:Int, pname:Int):Dynamic {return null;}

    @:functionCode('
        int result = 0;
        glGetVertexAttribPointerv(index, pname, (void **)&result);
        return result;
	')
    public static function getVertexAttribOffset(index:Int, pname:Int):Int {return 0;}

	@:functionCode('
		glHint(target, mode);
	')
    public static function hint(target : Int, mode : Int) : Void {}

    @:functionCode('
		return glIsBuffer(buffer);
	')
    public static function isBuffer(buffer:GLBuffer):Bool {return false;}

    @:functionCode('
		return glIsEnabled(cap);
	')
    public static function isEnabled(cap:Int):Bool {return false;}

    @:functionCode('
		return glIsFramebuffer(framebuffer);
	')
    public static function isFramebuffer(framebuffer:GLFramebuffer):Bool {return false;}

    @:functionCode('
		return glIsProgram(program);
	')
    public static function isProgram(program:GLProgram):Bool {return false;}

    @:functionCode('
		return glIsRenderbuffer(renderbuffer);
	')
    public static function isRenderbuffer(renderbuffer:GLRenderbuffer):Bool {return false;}

    @:functionCode('
		return glIsShader(shader);
	')
    public static function isShader(shader:GLShader):Bool {return false;}

    @:functionCode('
		return glIsTexture(texture);
	')
    public static function isTexture(texture:GLTexture):Bool {return false;}

    @:functionCode('
		glLineWidth(width);
	')
    public static function lineWidth(width:Float):Void {}

	@:functionCode('
    	glLinkProgram(program);
	')
    public static function linkProgram(program:GLProgram):Void {}

    @:functionCode('
    	glPixelStorei(pname, param);
	')
    public static function pixelStorei(pname:Int, param:Int)  {}

    @:functionCode('
    	glPolygonOffset(factor, units);
	')
    public static function polygonOffset(factor:Float, units:Float)  {}

    @:functionCode('
    	glReadPixels(x, y, width, height, format, type, outputData->_nativeData->ptr + outputData->_nativeData->offset);
	')
    public static function readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int, outputData:Data)  {}

    @:functionCode('
    	glRenderbufferStorage(target, internalFormat, width, height);
	')
    public static function renderbufferStorage(target:Int, internalFormat:Int, width:Int, height:Int)  {}

    @:functionCode('
    	glSampleCoverage(value, invert);
	')
    public static function sampleCoverage(value:Float, invert:Bool)  {}

    @:functionCode('
    	glScissor(x, y, width, height);
	')
    public static function scissor(x:Int, y:Int, width:Int, height:Int)  {}

    @:functionCode('
		const char *sourceC = source.__CStr();
    	glShaderSource(shader, 1, &sourceC, 0);
	')
    public static function shaderSource(shader:GLShader, source:String):Void {}

    @:functionCode('
    	glStencilFunc(func, ref, mask);
	')
    public static function stencilFunc(func:Int, ref:Int, mask:Int)  {}

    @:functionCode('
    	glStencilFuncSeparate(face, func, ref, mask);
	')
    public static function stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int)  {}

    @:functionCode('
    	glStencilMask(mask);
	')
    public static function stencilMask(mask:Int)  {}

    @:functionCode('
    	glStencilMaskSeparate(face, mask);
	')
    public static function stencilMaskSeparate(face:Int, mask:Int)  {}

    @:functionCode('
    	glStencilOp(fail, zfail, zpass);
	')
    public static function stencilOp(fail:Int, zfail:Int, zpass:Int)  {}

    @:functionCode('
    	glStencilOpSeparate(face, fail, zfail, zpass);
	')
    public static function stencilOpSeparate(face:Int, fail:Int, zfail:Int, zpass:Int)  {}

	@:functionCode('
        void *dataPointer = NULL;
        if (pixels != null())
        {
            dataPointer = pixels->_nativeData->ptr + pixels->_nativeData->offset;
        }
		glTexImage2D(target, level, internalFormat, width, height, border, format, type, dataPointer);
	')
    public static function texImage2D(target : Int, level : Int, internalFormat : Int, width : Int, height : Int, border : Int, format : Int, type : Int, pixels : Data) {}

	@:functionCode('
    	glTexParameteri(textureType, parameterName, parameterValue);
	')
    public static function texParameteri(textureType : Int, parameterName : Int, parameterValue : Int) : Void{};

    @:functionCode('
    	glTexParameterf(textureType, parameterName, parameterValue);
	')
    public static function texParameterf(textureType:Int, parameterName:Int, parameterValue:Float)  {}

    @:functionCode('
		glTexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pixels->_nativeData->ptr + pixels->_nativeData->offset);
	')
    public static function texSubImage2D(   target:Int,
                                            level:Int,
                                            xoffset:Int,
                                            yoffset:Int,
                                            width:Int,
                                            height:Int,
                                            format:Int,
                                            type:Int,
                                            pixels:Data)  {}


    @:functionCode('
    	glUniform1f(location, v0);
	')
    public static function uniform1f(location:GLUniformLocation, v0:Float)  {}

    @:functionCode('
    	glUniform1fv(location, count, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform1fv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniform1iv(location, count, (GLint*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform1iv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniform1i(location, v0);
	')
    public static function uniform1i(location:GLUniformLocation, v0:Int):Void {}

    @:functionCode('
    	glUniform2f(location, v0, v1);
	')
    public static function uniform2f(location:GLUniformLocation, v0:Float, v1:Float)  {}

    @:functionCode('
    	glUniform2fv(location, count, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform2fv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniform2i(location, v0, v1);
	')
    public static function uniform2i(location:GLUniformLocation, v0:Int, v1:Int)  {}

    @:functionCode('
    	glUniform2iv(location, count, (GLint*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform2iv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniform3f(location, v0, v1, v2);
	')
    public static function uniform3f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float)  {}

    @:functionCode('
    	glUniform3fv(location, count, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform3fv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniform3i(location, v0, v1, v2);
	')
    public static function uniform3i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int)  {}

    @:functionCode('
    	glUniform3iv(location, count, (GLint*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform3iv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniform4f(location, v0, v1, v2, v3);
	')
    public static function uniform4f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float, v3:Float)  {}

    @:functionCode('
    	glUniform4i(location, v0, v1, v2, v3);
	')
    public static function uniform4i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int, v3:Int)  {}

    @:functionCode('
    	glUniform4iv(location, count, (GLint*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform4iv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniform4fv(location, count, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniform4fv(location:GLUniformLocation, count:Int, data:Data)  {}

    @:functionCode('
    	glUniformMatrix2fv(location, count, transpose, (GLfloat*)((uint8_t*)data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniformMatrix2fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data)  {}

    @:functionCode('
    	glUniformMatrix3fv(location, count, transpose, (GLfloat*)((uint8_t*)data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniformMatrix3fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data)  {}

    @:functionCode('
    	glUniformMatrix4fv(location, count, transpose, (GLfloat*)((uint8_t*)data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function uniformMatrix4fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void {}

	@:functionCode('
    	glUseProgram(program);
	')
    public static function useProgram(program:GLProgram):Void {}

	@:functionCode('
    	glVertexAttribPointer(indx, size, type, normalized, stride, (void*)offset);
	')
    public static function vertexAttribPointer(indx:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void {}

    @:functionCode('
    	glVertexAttrib1f(indx, x);
	')
    public static function vertexAttrib1f(indx:Int, x:Float)  {}

    @:functionCode('
    	glVertexAttrib1fv(indx, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function vertexAttrib1fv(indx:Int, data:Data)  {}

    @:functionCode('
    	glVertexAttrib2f(indx, x, y);
	')
    public static function vertexAttrib2f(indx:Int, x:Float, y:Float)  {}

    @:functionCode('
    	glVertexAttrib2fv(indx, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function vertexAttrib2fv(indx:Int, data:Data)  {}

    @:functionCode('
    	glVertexAttrib3f(indx, x, y, z);
	')
    public static function vertexAttrib3f(indx:Int, x:Float, y:Float, z:Float)  {}

    @:functionCode('
    	glVertexAttrib3fv(indx, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function vertexAttrib3fv(indx:Int, data:Data)  {}

    @:functionCode('
    	glVertexAttrib4f(indx, x, y, z, w);
	')
    public static function vertexAttrib4f(indx:Int, x:Float, y:Float, z:Float, w:Float)  {}

    @:functionCode('
    	glVertexAttrib4fv(indx, (GLfloat*)(data->_nativeData->ptr + data->_nativeData->offset));
	')
    public static function vertexAttrib4fv(indx:Int, data:Data)  {}

	@:functionCode('
    	glViewport(x, y, width, height);
	')
    public static function viewport(x:Int, y:Int, width:Int, height:Int):Void {}

}
