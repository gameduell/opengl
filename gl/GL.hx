package gl;

import js.html.webgl.ShaderPrecisionFormat;
import gl.GLDefines;
import gl.GLActiveInfo;
import gl.GLShaderPrecisionFormat;
import types.Data;

import js.html.webgl.GL;
import js.html.webgl.RenderingContext;
import js.html.webgl.ActiveInfo;

typedef GLBuffer = js.html.webgl.Buffer;
typedef GLFramebuffer = js.html.webgl.Framebuffer;
typedef GLRenderbuffer = js.html.webgl.Renderbuffer;
typedef GLProgram = js.html.webgl.Program;
typedef GLUniformLocation = js.html.webgl.UniformLocation;
typedef GLShader = js.html.webgl.Shader;
typedef GLTexture = js.html.webgl.Texture;

class GL {

    public static var nullShader = null;
    public static var nullBuffer = null;
    public static var nullRenderbuffer = null;
    public static var nullFramebuffer = null;
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

    public static function bindFramebuffer(target:Int, framebuffer:GLFramebuffer):Void
    {
        context.bindFramebuffer(target, framebuffer);
    }

    public static function bindRenderbuffer(target:Int, renderbuffer:GLRenderbuffer):Void
    {
        context.bindRenderbuffer(target, renderbuffer);
    }

    public static function bindTexture(target:Int, texture:GLTexture):Void 
    {
        context.bindTexture(target, texture);
    }

    public static function blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void
    {
        context.blendColor(red, green, blue, alpha);
    }

    public static function blendEquation(mode:Int):Void
    {
        context.blendEquation(mode);
    }

    public static function blendEquationSeparate(modeRGB:Int, modeAlpha:Int):Void
    {
        context.blendEquationSeparate(modeRGB, modeAlpha);
    }

    public static function blendFunc(sfactor:Int, dfactor:Int):Void
    {
        context.blendFunc(sfactor, dfactor);
    }

    public static function blendFuncSeparate(srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void
    {
        context.blendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha);
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

    public static function checkFramebufferStatus(target:Int):Int
    {
        return context.checkFramebufferStatus(target);
    }

    public static function clear(mask:Int):Void
    {
        context.clear(mask);
    }

    public static function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void
    {
    	context.clearColor(red, green, blue, alpha);
    }

    public static function clearDepth(depth:Float):Void
    {
        context.clearDepth(depth);
    }

    public static function clearStencil(s:Int):Void
    {
        context.clearStencil(s);
    }

    public static function colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void
    {
        context.colorMask(red, green, blue, alpha);
    }

    public static function compileShader(shader:GLShader):Void 
    {
    	context.compileShader(shader);
    }

    public static function compressedTexImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, data:Data)
    {
        context.compressedTexImage2D(target, level, internalFormat, width, height, border, data.uint8Array.subarray(data.offset, data.offset + data.offsetLength));
    }

    public static function compressedTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, data:Data)
    {
        context.compressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, data.uint8Array.subarray(data.offset, data.offset + data.offsetLength));
    }

    public static function copyTexImage2D(target:Int, level:Int, internalFormat:Int, x:Int, y:Int, width:Int, height:Int, border:Int)
    {
        context.copyTexImage2D(target, level, internalFormat, x, y, width, height, border);
    }

    public static function copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int)
    {
        context.copyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height);
    }

    public static function createProgram():GLProgram 
    { 
    	return context.createProgram(); 
    }

    public static function createFramebuffer():GLFramebuffer
    {
        return context.createFramebuffer();
    }

    public static function createRenderbuffer():GLRenderbuffer
    {
        return context.createRenderbuffer();
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

    public static function cullFace(mode:Int):Void
    {
        context.cullFace(mode);
    }

    public static function deleteBuffer(shader:GLBuffer):Void
    {
        context.deleteBuffer(shader);
    }

    public static function deleteFramebuffer(framebuffer:GLFramebuffer):Void
    {
        context.deleteFramebuffer(framebuffer);
    }

    public static function deleteRenderbuffer(renderbuffer:GLRenderbuffer):Void
    {
        context.deleteRenderbuffer(renderbuffer);
    }

    public static function deleteProgram(program:GLProgram):Void 
    {
    	context.deleteProgram(program); 
    }

    public static function deleteShader(shader:GLShader):Void 
    {
		context.deleteShader(shader);
    }

    public static function deleteTexture(texture:GLTexture):Void
    {
        context.deleteTexture(texture);
    }

    public static function depthFunc(func:Int):Void
    {
        context.depthFunc(func);
    }

    public static function depthMask(flag:Bool):Void
    {
        context.depthMask(flag);
    }

    public static function depthRange(zNear:Float, zFar:Float):Void
    {
        context.depthRange(zNear, zFar);
    }

    public static function detachShader(program:GLProgram, shader:GLShader):Void 
    {
    	context.detachShader(program, shader);
    }

    public static function disable(cap:Int):Void
    {
        context.disable(cap);
    }

    public static function disableVertexAttribArray(index:Int):Void
    {
        context.disableVertexAttribArray(index);
    }

    public static function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void
    {
        context.drawElements(mode, count, type, offset);
    }

    public static function drawArrays(mode:Int, first:Int, count:Int):Void
    {
        context.drawArrays(mode, first, count);
    }

    public static function enable(cap:Int):Void
    {
        context.enable(cap);
    }

    public static function enableVertexAttribArray(index:Int):Void
    {
        context.enableVertexAttribArray(index);
    }

    public static function finish():Void
    {
        context.finish();
    }

    public static function flush():Void
    {
        context.flush();
    }

    public static function framebufferRenderbuffer(target:Int, attachment:Int, renderbuffertarget:Int, renderbuffer:GLRenderbuffer):Void
    {
        context.framebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer);
    }

    public static function framebufferTexture2D(target:Int, attachment:Int, textarget:Int, texture:GLTexture, level:Int):Void
    {
        context.framebufferTexture2D(target, attachment, textarget, texture, level);
    }

    public static function frontFace(mode:Int):Void
    {
        context.frontFace(mode);
    }

    public static function generateMipmap(target : Int) : Void
    {
        context.generateMipmap(target);
    }

    public static function getActiveAttrib(program:GLProgram, index:Int):GLActiveInfo
    {
        var info:ActiveInfo = context.getActiveAttrib(program, index);

        return {
            name: info.name,
            size: info.size,
            type: info.type
        }
    }

    public static function getActiveUniform(program:GLProgram, index:Int):GLActiveInfo
    {
        var info:ActiveInfo = context.getActiveUniform(program, index);

        return {
            name: info.name,
            size: info.size,
            type: info.type
        }
    }

    public static function getAttachedShaders(program:GLProgram):Array<GLShader>
    {
        return context.getAttachedShaders(program);
    }

    public static function getAttribLocation(program:GLProgram, name:String):Int
    {
        return context.getAttribLocation(program, name);
    }

    public static function getBufferParameter(target:Int, pname:Int):Dynamic
    {
        return context.getBufferParameter(target, pname);
    }

    public static function getParameter(pname:Int):Dynamic
    {
        return context.getParameter(pname);
    }

    public static function getError():Int
    {
        return context.getError();
    }

    public static function getFramebufferAttachmentParameter(target:Int, attachment:Int, pname:Int):Dynamic
    {
        return context.getFramebufferAttachmentParameter(target, attachment, pname);
    }

    public static function getProgramInfoLog(program:GLProgram):String 
    { 
    	return context.getProgramInfoLog(program);
    }

    public static function getProgramParameter(program:GLProgram, pname:Int):Int 
    { 
		return context.getProgramParameter(program, pname);
    }

    public static function getRenderBufferParameter(target:Int, pname:Int):Dynamic
    {
        return context.getRenderbufferParameter(target, pname);
    }

    public static function getShaderInfoLog(shader:GLShader):String 
    { 
		return context.getShaderInfoLog(shader);
    }

    public static function getShaderParameter(shader:GLShader, pname:Int):Int 
    { 
		return context.getShaderParameter(shader, pname);
    }

    public static function getShaderPrecisionFormat(shadertype:Int, precisiontype:Int):GLShaderPrecisionFormat
    {
        var info:ShaderPrecisionFormat = context.getShaderPrecisionFormat(shadertype, precisiontype);

        return {
            precision: info.precision,
            rangeMax: info.rangeMax,
            rangeMin: info.rangeMin
        }
    }

    public static function getShaderSource(shader:GLShader):String
    {
        return context.getShaderSource(shader);
    }

    public static function getTexParameter(target:Int, pname:Int):Dynamic
    {
        return context.getTexParameter(target, pname);
    }

    public static function getUniform(program:GLProgram, location:GLUniformLocation)
    {
        return context.getUniform(program, location);
    }

    public static function getUniformLocation(program:GLProgram, name:String):GLUniformLocation 
    { 
		return context.getUniformLocation(program, name);
    }

    public static function getVertexAttrib(index:Int, pname:Int):Dynamic
    {
        return context.getVertexAttrib(index, pname);
    }

    public static function getVertexAttribOffset(index:Int, pname:Int):Int
    {
        return context.getVertexAttribOffset(index, pname);
    }

    public static function hint(target : Int, mode : Int) : Void
    {
        context.hint(target, mode);
    }

    public static function isBuffer(buffer:GLBuffer):Bool
    {
        return context.isBuffer(buffer);
    }

    public static function isEnabled(cap:Int):Bool
    {
        return context.isEnabled(cap);
    }

    public static function isFramebuffer(framebuffer:GLFramebuffer):Bool
    {
        return context.isFramebuffer(framebuffer);
    }

    public static function isProgram(program:GLProgram):Bool
    {
        return context.isProgram(program);
    }

    public static function isRenderbuffer(renderbuffer:GLRenderbuffer):Bool
    {
        return context.isRenderbuffer(renderbuffer);
    }

    public static function isShader(shader:GLShader):Bool
    {
        return context.isShader(shader);
    }

    public static function isTexture(texture:GLTexture):Bool
    {
        return context.isTexture(texture);
    }

    public static function lineWidth(width:Float):Void
    {
        context.lineWidth(width);
    }

    public static function linkProgram(program:GLProgram):Void 
    {
		context.linkProgram(program);
    }

    public static function pixelStorei(pname:Int, param:Int):Void
    {
        context.pixelStorei(pname, param);
    }

    public static function polygonOffset(factor:Float, units:Float):Void
    {
        context.polygonOffset(factor, units);
    }

    public static function readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int, outputData:Data):Void
    {
        context.readPixels(x, y, width, height, format, type, outputData.uint8Array.subarray(outputData.offset, outputData.offset + outputData.offsetLength));
    }

    public static function renderbufferStorage(target:Int, internalFormat:Int, width:Int, height:Int):Void
    {
        context.renderbufferStorage(target, internalFormat, width, height);
    }

    public static function sampleCoverage(value:Float, invert:Bool):Void
    {
        context.sampleCoverage(value, invert);
    }

    public static function scissor(x:Int, y:Int, width:Int, height:Int):Void
    {
        context.scissor(x, y, width, height);
    }

    public static function shaderSource(shader:GLShader, source:String):Void 
    {
    	context.shaderSource(shader, source);
    }

    public static function stencilFunc(func:Int, ref:Int, mask:Int):Void
    {
        context.stencilFunc(func, ref, mask);
    }

    public static function stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int):Void
    {
        context.stencilFuncSeparate(face, func, ref, mask);
    }

    public static function stencilMask(mask:Int):Void
    {
        context.stencilMask(mask);
    }

    public static function stencilMaskSeparate(face:Int, mask:Int):Void
    {
        context.stencilMaskSeparate(face, mask);
    }

    public static function stencilOp(fail:Int, zfail:Int, zpass:Int):Void
    {
        context.stencilOp(fail, zfail, zpass);
    }

    public static function stencilOpSeparate(face:Int, fail:Int, zfail:Int, zpass:Int):Void
    {
        context.stencilFuncSeparate(face, fail, zfail, zpass);
    }

    public static function texImage2D(target : Int, level : Int, internalFormat : Int, width : Int, height : Int, border : Int, format : Int, type : Int, pixels : Data)
    {
        context.texImage2D(target, level, internalFormat, width, height, border, format, type, pixels.uint8Array.subarray(pixels.offset, pixels.offset + pixels.offsetLength));
    }

    public static function texParameteri(textureType : Int, parameterName : Int, parameterValue : Int) : Void
    {
        context.texParameteri(textureType, parameterName, parameterValue);
    }

    public static function texParameterf(textureType:Int, parameterName:Int, parameterValue:Float):Void
    {
        context.texParameterf(textureType, parameterName, parameterValue);
    }

    public static function texSubImage2D(   target:Int,
                                            level:Int,
                                            xoffset:Int,
                                            yoffset:Int,
                                            width:Int,
                                            height:Int,
                                            format:Int,
                                            type:Int,
                                            pixels:Data):Void
    {
        context.texSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pixels.uint8Array.subarray(pixels.offset, pixels.offset + pixels.offsetLength));
    }

    public static function uniform1f(location:GLUniformLocation, v0:Float):Void
    {
        context.uniform1f(location, v0);
    }

    public static function uniform1fv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform1fv(location, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 1 * count));
    }

    public static function uniform1iv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform1iv(location, data.int32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 1 * count));
    }

    public static function uniform1i(location:GLUniformLocation, v0:Int):Void
    {
        context.uniform1i(location, v0);
    }

    public static function uniform2f(location:GLUniformLocation, v0:Float, v1:Float):Void
    {
        context.uniform2f(location, v0, v1);
    }

    public static function uniform2fv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform2fv(location, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 2 * count));
    }

    public static function uniform2i(location:GLUniformLocation, v0:Int, v1:Int):Void
    {
        context.uniform2i(location, v0, v1);
    }

    public static function uniform2iv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform2iv(location, data.int32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 2 * count));
    }

    public static function uniform3f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float):Void
    {
        context.uniform3f(location, v0, v1, v2);
    }

    public static function uniform3fv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform3fv(location, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 3 * count));
    }

    public static function uniform3i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int):Void
    {
        context.uniform3i(location, v0, v1, v2);
    }

    public static function uniform3iv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform3iv(location, data.int32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 3 * count));
    }

    public static function uniform4f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float, v3:Float):Void
    {
        context.uniform4f(location, v0, v1, v2, v3);
    }

    public static function uniform4fv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform4fv(location, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 4 * count));
    }

    public static function uniform4i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int, v3:Int):Void
    {
        context.uniform4i(location, v0, v1, v2, v3);
    }

    public static function uniform4iv(location:GLUniformLocation, count:Int, data:Data):Void
    {
        context.uniform4iv(location, data.int32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 4 * count));
    }

    public static function uniformMatrix2fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void
    {
        context.uniformMatrix2fv(   location,
                                    transpose,
                                    data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 2*2 * count));
    }


    public static function uniformMatrix3fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void
    {
        context.uniformMatrix3fv(location,
                                 transpose,
                                 data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 3*3 * count));
    }


    public static function uniformMatrix4fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void
    {
        context.uniformMatrix4fv(location,
                                 transpose,
                                 data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 4*4 * count));
    }

    public static function useProgram(program:GLProgram):Void
    {
        context.useProgram(program);
    }

    public static function validateProgram(program:GLProgram):Void
    {
        context.validateProgram(program);
    }


    public static function vertexAttrib1f(indx:Int, x:Float):Void
    {
        context.vertexAttrib1f(indx, x);
    }

    public static function vertexAttrib1fv(indx:Int, data:Data):Void
    {
        context.vertexAttrib1fv(indx, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 1));
    }

    public static function vertexAttrib2f(indx:Int, x:Float, y:Float):Void
    {
        context.vertexAttrib2f(indx, x, y);
    }

    public static function vertexAttrib2fv(indx:Int, data:Data):Void
    {
        context.vertexAttrib2fv(indx, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 2));
    }

    public static function vertexAttrib3f(indx:Int, x:Float, y:Float, z:Float):Void
    {
        context.vertexAttrib3f(indx, x, y, z);
    }

    public static function vertexAttrib3fv(indx:Int, data:Data):Void
    {
        context.vertexAttrib3fv(indx, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 3));
    }

    public static function vertexAttrib4f(indx:Int, x:Float, y:Float, z:Float, w:Float):Void
    {
        context.vertexAttrib4f(indx, x, y, z, w);
    }

    public static function vertexAttrib4fv(indx:Int, data:Data):Void
    {
        context.vertexAttrib4fv(indx, data.float32Array.subarray(cast data.offset / 4, cast data.offset / 4 + 4));
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

    public static function viewport(x:Int, y:Int, width:Int, height:Int):Void 
    {
		context.viewport(x, y, width, height);
    }

}