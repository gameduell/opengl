package gl;

import gl.GLDefines;
import types.Data;

import js.html.webgl.GL;
import js.html.webgl.RenderingContext;

typedef GLBuffer = js.html.webgl.Buffer;
typedef GLProgram = js.html.webgl.Program;
typedef GLUniformLocation = js.html.webgl.UniformLocation;
typedef GLShader = js.html.webgl.Shader;
typedef GLTexture = js.html.webgl.Texture;

class GL {

    public static var nullShader = null;
    public static var nullBuffer = null;
    public static var nullProgram = null;
    public static var nullUniformLocation = null;
    public static var nullTexture = null;

	public static var context : RenderingContext;

    public static function activeTexture(position:Int):Void
    {
        context.activeTexture(position);
    }

    public static function attachShader(program:GLProgram, shader:GLShader):Void 
    {
    	context.attachShader(program, shader);

    }

    public static function bindAttribLocation(program:GLProgram, index:Int, name:String):Void 
    {
    	context.bindAttribLocation(program, index, name);
    }

    public static function bindBuffer(target:Int, buffer:GLBuffer):Void 
    {
    	context.bindBuffer(target, buffer);
    }

    public static function bindTexture(target:Int, texture:GLTexture):Void 
    {
        context.bindTexture(target, texture);
    }

    public static function bufferData(target:Int, data:Data, usage:Int):Void 
    {
    	context.bufferData(target, data.uint8Array.subarray(data.offset, data.offset + data.offsetLength), usage);
    }

    public static function bufferSubData(	target:Int, 
    										offsetInBuffer:Int, 
    										data:Data):Void 
    {
    	context.bufferSubData(	target, 
    							offsetInBuffer, 
    							data.uint8Array.subarray(data.offset, data.offset + data.offsetLength));
    }
    
    public static function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void
    {
    	context.clearColor(red, green, blue, alpha);
    }

    public static function clear(mask:Int):Void 
    {
    	context.clear(mask);
    }

    public static function compileShader(shader:GLShader):Void 
    {
    	context.compileShader(shader);
    }

    public static function createProgram():GLProgram 
    { 
    	return context.createProgram(); 
    }

    public static function createBuffer():GLBuffer 
    { 
    	return context.createBuffer(); 
    }

    public static function createTexture():GLTexture
    { 
        return context.createTexture(); 
    }

    public static function createShader(type:Int):GLShader 
    { 
    	return context.createShader(type); 
    }

    public static function deleteProgram(program:GLProgram):Void 
    {
    	context.deleteProgram(program); 
    }

    public static function deleteShader(shader:GLShader):Void 
    {
		context.deleteShader(shader);
    }

    public static function detachShader(program:GLProgram, shader:GLShader):Void 
    {
    	context.detachShader(program, shader);
    }

    public static function generateMipmap(target : Int) : Void
    {
        context.generateMipmap(target);
    }

    public static function getProgramInfoLog(program:GLProgram):String 
    { 
    	return context.getProgramInfoLog(program);
    }

    public static function getProgramParameter(program:GLProgram, pname:Int):Int 
    { 
		return context.getProgramParameter(program, pname);
    }

    public static function getShaderInfoLog(shader:GLShader):String 
    { 
		return context.getShaderInfoLog(shader);
    }

    public static function getShaderParameter(shader:GLShader, pname:Int):Int 
    { 
		return context.getShaderParameter(shader, pname);
    }

    public static function getUniformLocation(program:GLProgram, name:String):GLUniformLocation 
    { 
		return context.getUniformLocation(program, name);
    }

    public static function hint(target : Int, mode : Int) : Void
    {
        context.hint(target, mode);
    }

    public static function linkProgram(program:GLProgram):Void 
    {
		context.linkProgram(program);
    }

    public static function shaderSource(shader:GLShader, source:String):Void 
    {
    	context.shaderSource(shader, source);
    }

    public static function texImage2D(target : Int, level : Int, internalFormat : Int, width : Int, height : Int, border : Int, format : Int, type : Int, pixels : Data)
    {
        context.texImage2D(target, level, internalFormat, width, height, border, format, type, pixels.uint8Array);
    }

    public static function texParameteri(textureType : Int, parameterName : Int, parameterValue : Int) : Void
    {
        context.texParameteri(textureType, parameterName, parameterValue);
    }

    public static function useProgram(program:GLProgram):Void 
    {
		context.useProgram(program);
    }

    public static function uniform1i(location:GLUniformLocation, x:Int):Void 
    {
		context.uniform1i(location, x);
    }

    public static function uniformMatrix4fv(location:GLUniformLocation, 
    										count:Int, 
    										transpose:Bool, 
    										data:Data):Void
    {
		context.uniformMatrix4fv(location, 
								 transpose, 
								 data.float32Array.subarray(data.offset, data.offset + 4*4*4 * count));
    }

    public static function vertexAttribPointer( indx:Int, 
    											size:Int, 
    											type:Int, 
    											normalized:Bool, 
    											stride:Int, 
    											offset:Int):Void 
    {
		context.vertexAttribPointer(indx, size, type, normalized, stride, offset);
    }

    public static function enableVertexAttribArray(index:Int):Void 
    {
		context.enableVertexAttribArray(index);
    }

    public static function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void 
    {
    	context.drawElements(mode, count, type, offset);
    }

    public static function drawArrays(mode:Int, first:Int, count:Int):Void 
    {
    	context.drawArrays(mode, first, count);
    }

    public static function viewport(x:Int, y:Int, width:Int, height:Int):Void 
    {
		context.viewport(x, y, width, height);
    }

}