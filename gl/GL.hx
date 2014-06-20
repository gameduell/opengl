package gl;

import types.Data;

import gl.GLActiveInfo;
import gl.GLShaderPrecisionFormat;

extern class GLShader {}
extern class GLFramebuffer {}
extern class GLRenderbuffer {}
extern class GLBuffer {}
extern class GLProgram {}
extern class GLUniformLocation {}
extern class GLTexture {}

extern class GL {

    public static var nullShader : GLShader;
    public static var nullBuffer : GLBuffer;
    public static var nullFramebuffer : GLFramebuffer;
    public static var nullRenderbuffer : GLRenderbuffer;
    public static var nullProgram : GLProgram;
    public static var nullUniformLocation : GLUniformLocation;
    public static var nullTexture : GLTexture;

    ///============ GL API ==============

    public static function activeTexture(position : Int):Void;

    public static function attachShader(program:GLProgram, shader:GLShader):Void;

    public static function bindAttribLocation(program:GLProgram, index:Int, name:String):Void;

    public static function bindBuffer(target:Int, buffer:GLBuffer):Void;

    public static function bindFramebuffer(target:Int, framebuffer:GLFramebuffer):Void;

    public static function bindRenderbuffer(target:Int, renderbuffer:GLRenderbuffer):Void;

    public static function bindTexture(target:Int, texture:GLTexture):Void;

    public static function blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void;

    public static function blendEquation(mode:Int):Void;

    public static function blendEquationSeparate(modeRGB:Int, modeAlpha:Int):Void;

    public static function blendFunc(sfactor:Int, dfactor:Int):Void;

    public static function blendFuncSeparate(srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void;

    public static function bufferData(target:Int, data:Data, usage:Int):Void;

    public static function bufferSubData(target:Int, offsetInBuffer:Int, data:Data):Void;

    public static function checkFramebufferStatus(target:Int):Int;

    public static function clear(mask:Int):Void;

    public static function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;

    public static function clearDepth(depth:Float):Void;

    public static function clearStencil(s:Int):Void;

    public static function colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void;

    public static function compileShader(shader:GLShader):Void;

    public static function compressedTexImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, data:Data):Void;

    public static function compressedTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, data:Data):Void;

    public static function copyTexImage2D(target:Int, level:Int, internalFormat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void;

    public static function copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void;

    public static function createBuffer():GLBuffer;

    public static function createFramebuffer():GLFramebuffer;

    public static function createProgram():GLProgram;

    public static function createRenderbuffer():GLRenderbuffer;

    public static function createShader(type:Int):GLShader;

    public static function createTexture():GLTexture;

    public static function cullFace(mode:Int):Void;

    public static function deleteBuffer(shader:GLBuffer):Void;

    public static function deleteFramebuffer(framebuffer:GLFramebuffer):Void;

    public static function deleteRenderbuffer(renderbuffer:GLRenderbuffer):Void;

    public static function deleteProgram(program:GLProgram):Void;

    public static function deleteShader(shader:GLShader):Void;

    public static function deleteTexture(texture:GLTexture):Void;

    public static function depthFunc(func:Int):Void;

    public static function depthMask(flag:Bool):Void;

    public static function depthRange(zNear:Float, zFar:Float):Void;

    public static function detachShader(program:GLProgram, shader:GLShader):Void;

    public static function disable(cap:Int):Void;

    public static function disableVertexAttribArray(index:Int):Void;

    public static function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void;

    public static function drawArrays(mode:Int, first:Int, count:Int):Void;

    public static function enable(cap:Int):Void;

    public static function enableVertexAttribArray(index:Int):Void;

    public static function finish():Void;

    public static function flush():Void;

    public static function framebufferRenderbuffer(target:Int, attachment:Int, renderbuffertarget:Int, renderbuffer:GLRenderbuffer):Void;

    public static function framebufferTexture2D(target:Int, attachment:Int, textarget:Int, texture:GLTexture, level:Int):Void;

    public static function frontFace(mode:Int):Void;

    public static function generateMipmap(target:Int):Void;

    public static function getActiveAttrib(program:GLProgram, index:Int):GLActiveInfo;

    public static function getActiveUniform(program:GLProgram, index:Int):GLActiveInfo;

    public static function getAttachedShaders(program:GLProgram):Array<GLShader>;

    public static function getAttribLocation(program:GLProgram, name:String):Int;

    public static function getBufferParameter(target:Int, pname:Int):Dynamic;

    public static function getParameter(pname:Int):Dynamic;

    public static function getError():Int;

    public static function getFramebufferAttachmentParameter(target:Int, attachment:Int, pname:Int):Dynamic;

    public static function getProgramInfoLog(program:GLProgram):String;

    public static function getProgramParameter(program:GLProgram, pname:Int):Int;

    public static function getRenderBufferParameter(target:Int, pname:Int):Dynamic;

    public static function getShaderInfoLog(shader:GLShader):String;

    public static function getShaderParameter(shader:GLShader, pname:Int):Int;

    public static function getShaderPrecisionFormat(shadertype:Int, precisiontype:Int):GLShaderPrecisionFormat;

    public static function getShaderSource(shader:GLShader):String;

    public static function getTexParameter(target:Int, pname:Int):Dynamic;

    public static function getUniform(program:GLProgram, location:GLUniformLocation);

    public static function getUniformLocation(program:GLProgram, name:String):GLUniformLocation;

    public static function getVertexAttrib(index:Int, pname:Int):Dynamic;

    public static function getVertexAttribOffset(index:Int, pname:Int):Int;

    public static function hint(target : Int, mode : Int);

    public static function isBuffer(buffer:GLBuffer):Bool;

    public static function isEnabled(cap:Int):Bool;

    public static function isFramebuffer(framebuffer:GLFramebuffer):Bool;

    public static function isProgram(program:GLProgram):Bool;

    public static function isRenderbuffer(renderbuffer:GLRenderbuffer):Bool;

    public static function isShader(shader:GLShader):Bool;

    public static function isTexture(texture:GLTexture):Bool;

    public static function lineWidth(width:Float):Void;

    public static function linkProgram(program:GLProgram):Void;

    public static function pixelStorei(pname:Int, param:Int):Void;

    public static function polygonOffset(factor:Float, units:Float):Void;

    public static function readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int, outputData:Data):Void;

    public static function renderbufferStorage(target:Int, internalFormat:Int, width:Int, height:Int):Void;

    public static function sampleCoverage(value:Float, invert:Bool):Void;

    public static function scissor(x:Int, y:Int, width:Int, height:Int):Void;

    public static function shaderSource(shader:GLShader, source:String):Void;

    public static function stencilFunc(func:Int, ref:Int, mask:Int):Void;

    public static function stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int):Void;

    public static function stencilMask(mask:Int):Void;

    public static function stencilMaskSeparate(face:Int, mask:Int):Void;

    public static function stencilOp(fail:Int, zfail:Int, zpass:Int):Void;

    public static function stencilOpSeparate(face:Int, fail:Int, zfail:Int, zpass:Int):Void;

    public static function texImage2D(  target:Int,
                                        level:Int,
                                        internalFormat:Int,
                                        width:Int,
                                        height:Int,
                                        border:Int,
                                        format:Int,
                                        type:Int,
                                        pixels:Data):Void;

    public static function texParameteri(target:Int, pname:Int, param:Int):Void;

    public static function texParameterf(target:Int, pname:Int, param:Float):Void;

    public static function texSubImage2D(   target:Int,
                                            level:Int,
                                            xoffset:Int,
                                            yoffset:Int,
                                            width:Int,
                                            height:Int,
                                            format:Int,
                                            type:Int,
                                            pixels:Data):Void;

    public static function uniform1f(location:GLUniformLocation, v0:Float):Void;

    public static function uniform1fv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniform1iv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniform1i(location:GLUniformLocation, v0:Int):Void;

    public static function uniform2f(location:GLUniformLocation, v0:Float, v1:Float):Void;

    public static function uniform2fv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniform2i(location:GLUniformLocation, v0:Int, v1:Int):Void;

    public static function uniform2iv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniform3f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float):Void;

    public static function uniform3fv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniform3i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int):Void;

    public static function uniform3iv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniform4f(location:GLUniformLocation, v0:Float, v1:Float, v2:Float, v3:Float):Void;

    public static function uniform4fv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniform4i(location:GLUniformLocation, v0:Int, v1:Int, v2:Int, v3:Int):Void;

    public static function uniform4iv(location:GLUniformLocation, count:Int, data:Data):Void;

    public static function uniformMatrix2fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void;

    public static function uniformMatrix3fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void;

    public static function uniformMatrix4fv(location:GLUniformLocation, count:Int, transpose:Bool, data:Data):Void;

    public static function useProgram(program:GLProgram):Void;

    public static function validateProgram(program:GLProgram):Void;

    public static function vertexAttrib1f(indx:Int, x:Float):Void;

    public static function vertexAttrib1fv(indx:Int, data:Data):Void;

    public static function vertexAttrib2f(indx:Int, x:Float, y:Float):Void;

    public static function vertexAttrib2fv(indx:Int, data:Data):Void;

    public static function vertexAttrib3f(indx:Int, x:Float, y:Float, z:Float):Void;

    public static function vertexAttrib3fv(indx:Int, data:Data):Void;

    public static function vertexAttrib4f(indx:Int, x:Float, y:Float, z:Float, w:Float):Void;

    public static function vertexAttrib4fv(indx:Int, data:Data):Void;

    public static function vertexAttribPointer(indx:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void;

    public static function viewport(x:Int, y:Int, width:Int, height:Int):Void;

}