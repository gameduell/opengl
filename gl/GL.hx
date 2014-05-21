package gl;

import gl.GLDefines;
import types.Data;


typedef GLBuffer = Int;
typedef GLProgram = Int;
typedef GLUniformLocation = Int;
typedef GLShader = Int;
typedef GLTexture = Int;

@:buildXml('

	<files id="haxe">

		<include name="${haxelib:types_cpp}/native.xml" />

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
	#include <OpenGL/gl.h>
	#endif
')

@:cppFileCode('		


') 

@:headerClassCode('		
') 

class GL {

    public static var nullShader = 0;
    public static var nullBuffer = 0;
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
    	glBindTexture(target, texture);
	') 
    public static function bindTexture(target:Int, texture:GLTexture):Void {}

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
    	glCompileShader(shader);
	') 
    public static function compileShader(shader:GLShader):Void {}

	@:functionCode('
		GLuint program = glCreateProgram();
    	return program;
	') 
    public static function createProgram():GLProgram { return 0; }

	@:functionCode('
		GLuint bufferID;
    	glGenBuffers(1, &bufferID);
    	return bufferID;
	') 
    public static function createBuffer():GLBuffer { return 0; }

	@:functionCode('
    	return glCreateShader(type);
	') 
    public static function createShader(type:Int):GLShader { return 0; }

	@:functionCode('
		GLuint textureID;
    	glGenTextures(1, &textureID);
    	return textureID;
	') 
    public static function createTexture():GLTexture { return 0; }

	@:functionCode('
    	glDeleteProgram(program);
	') 
    public static function deleteProgram(program:GLProgram):Void {}

	@:functionCode('
    	glDeleteShader(shader);
	') 
    public static function deleteShader(shader:GLShader):Void {}

	@:functionCode('
    	glDetachShader(program, shader);
	') 
    public static function detachShader(program:GLProgram, shader:GLShader):Void {}

	@:functionCode('
    	glGenerateMipmap(target);
	') 
    public static function generateMipmap(target : Int) {}

	@:functionCode('
		GLint logLength;
    	glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);

    	if (logLength > 0) 
    	{
    	    GLchar *log = (GLchar *)malloc((unsigned long)logLength);

    	    glGetProgramInfoLog(program, logLength, &logLength, log);

    	    size_t wlog_length = logLength * (sizeof(wchar_t)/sizeof(char)) + sizeof(wchar_t);

 	       	wchar_t *wlog = (wchar_t *)calloc((unsigned long)wlog_length, 1);
 	       	mbstowcs(wlog, log, logLength);
 	       	free(log);
 	       	
			::String str = ::String(wlog, wlog_length);
			free(wlog);

			return str;
   		}
   		return ::String((char*)0, 0);
	') 
    public static function getProgramInfoLog(program:GLProgram):String { return "";}

	@:functionCode('
		GLint val;
		glGetProgramiv(program, pname, &val);
		return val;
	') 
    public static function getProgramParameter(program:GLProgram, pname:Int):Int { return 0; }

	@:functionCode('
		GLint logLength;
    	glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLength);

    	if (logLength > 0) 
    	{
    	    GLchar *log = (GLchar *)malloc((unsigned long)logLength);

    	    glGetShaderInfoLog(shader, logLength, &logLength, log);

    	    size_t wlog_length = logLength * (sizeof(wchar_t)/sizeof(char)) + sizeof(wchar_t);

 	       	wchar_t *wlog = (wchar_t *)calloc((unsigned long)wlog_length, 1);
 	       	mbstowcs(wlog, log, logLength);
 	       	free(log);
 	       	
			::String str = ::String(wlog, wlog_length);
			free(wlog);

			return str;
   		}
   		return ::String((char*)0, 0);
	') 
    public static function getShaderInfoLog(shader:GLShader):String { return ""; }

	@:functionCode('
		GLint val;
		glGetShaderiv(shader, pname, &val);
		return val;
	') 
    public static function getShaderParameter(shader:GLShader, pname:Int):Int { return 0; }

	@:functionCode('
		GLuint val = glGetUniformLocation(program, name.__CStr());
		return val;
	') 
    public static function getUniformLocation(program:GLProgram, name:String):GLUniformLocation { return 0;}

	@:functionCode('
		glHint(target, mode);
	') 
    public static function hint(target : Int, mode : Int) : Void {}

	@:functionCode('
    	glLinkProgram(program);
	') 
    public static function linkProgram(program:GLProgram):Void {}

	@:functionCode('
		const char * sourceC = source.__CStr();
    	glShaderSource(shader, 1, &sourceC, 0);
	') 
    public static function shaderSource(shader:GLShader, source:String):Void {}

	@:functionCode('
		glTexImage2D(target, level, internalFormat, width, height, border, format, type, pixels->_nativeData->ptr + pixels->_nativeData->offset);
	') 
    public static function texImage2D(target : Int, level : Int, internalFormat : Int, width : Int, height : Int, border : Int, format : Int, type : Int, pixels : Data) {}

	@:functionCode('
    	glTexParameteri(textureType, parameterName, parameterValue);
	') 
    public static function texParameteri(textureType : Int, parameterName : Int, parameterValue : Float) : Void{};

	@:functionCode('
    	glUseProgram(program);
	') 
    public static function useProgram(program:GLProgram):Void {}

	@:functionCode('
    	glUniform1i(location, x);
	') 
    public static function uniform1i(location:GLUniformLocation, x:Int):Void {}

	@:functionCode('
    	glUniformMatrix4fv(location, count, transpose, (float*)((uint8_t*)data->_nativeData->ptr + data->_nativeData->offset));
	') 
    public static function uniformMatrix4fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void {}

	@:functionCode('
    	glVertexAttribPointer(indx, size, type, normalized, stride, (void*)offset);
	') 
    public static function vertexAttribPointer(indx:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void {}

	@:functionCode('
    	glEnableVertexAttribArray(index);
	') 
    public static function enableVertexAttribArray(index:Int):Void {}

	@:functionCode('
    	glDrawElements(mode, count, type, (void*)offset);
	') 
    public static function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void {}

	@:functionCode('
    	glDrawArrays(mode, first, count);
	') 
    public static function drawArrays(mode:Int, first:Int, count:Int):Void {}

	@:functionCode('
    	glViewport(x, y, width, height);
	') 
    public static function viewport(x:Int, y:Int, width:Int, height:Int):Void {}

}