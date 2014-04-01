package gl;

import types.Data;

extern class GLShader {}
extern class GLBuffer {}
extern class GLProgram {}
extern class GLUniformLocation {}

extern class GL {

    public static var nullShader : GLShader;
    public static var nullBuffer : GLBuffer;
    public static var nullProgram : GLProgram;
    public static var nullUniformLocation : GLUniformLocation;

    public static function attachShader(program:GLProgram, shader:GLShader):Void;

    public static function bindAttribLocation(program:GLProgram, index:Int, name:String):Void;

    public static function bindBuffer(target:Int, buffer:GLBuffer):Void ;

    public static function bufferData(target:Int, offsetInData:Int, lengthInData:Int, data:Data, usage:Int):Void;

    public static function bufferSubData(target:Int, offsetInBuffer:Int, offsetInData:Int, lengthInData:Int, data:Data):Void;

    public static function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;

    public static function clear(mask:Int):Void;

    public static function compileShader(shader:GLShader):Void;

    public static function createProgram():GLProgram;

    public static function createShader(type:Int):GLShader;

    public static function createBuffer():GLBuffer;

    public static function deleteProgram(program:GLProgram):Void;

    public static function deleteShader(shader:GLShader):Void;

    public static function detachShader(program:GLProgram, shader:GLShader):Void;

    public static function getProgramInfoLog(program:GLProgram):String;

    public static function getProgramParameter(program:GLProgram, pname:Int):Int;

    public static function getShaderInfoLog(shader:GLShader):String;

    public static function getShaderParameter(shader:GLShader, pname:Int):Int;

    public static function getUniformLocation(program:GLProgram, name:String):GLUniformLocation;

    public static function linkProgram(program:GLProgram):Void;

    public static function shaderSource(shader:GLShader, source:String):Void;

    public static function useProgram(program:GLProgram):Void;

    public static function uniform1i(location:GLUniformLocation, x:Int):Void;

    public static function uniformMatrix4fv(location:GLUniformLocation, count:Int, transpose:Bool, offsetInData:Int, v:Data):Void;

    public static function vertexAttribPointer(indx:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void;

    public static function enableVertexAttribArray(index:Int):Void;

    public static function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void;

    public static function drawArrays(mode:Int, first:Int, count:Int):Void;

    public static function viewport(x:Int, y:Int, width:Int, height:Int):Void;

}