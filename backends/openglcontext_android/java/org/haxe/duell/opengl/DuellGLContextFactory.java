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

package org.haxe.duell.opengl;

import android.annotation.TargetApi;
import android.os.Build;
import android.util.Log;

import android.opengl.GLSurfaceView;

import org.haxe.duell.DuellActivity;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.egl.EGLContext;

@TargetApi(Build.VERSION_CODES.CUPCAKE)
final class DuellGLContextFactory implements GLSurfaceView.EGLContextFactory
{
    private static final String TAG = "DuellGLContextFactory";

    private static final int EGL_CONTEXT_CLIENT_VERSION = 0x3098;

//    private static final int EGL_SWAP_BEHAVIOR = 0x3093;
//    private static final int EGL_BUFFER_DESTROYED =	0x3095;
//
//    private static final int EGL_DRAW		=	0x3059;
//    private static final int EGL_READ		=	0x305A;

    public EGLContext createContext(EGL10 egl, EGLDisplay display, EGLConfig eglConfig)
    {
        int[] attrib_list = {
                EGL_CONTEXT_CLIENT_VERSION, 2,
                EGL10.EGL_NONE
        };

        EGLContext context = egl.eglCreateContext(display, eglConfig, EGL10.EGL_NO_CONTEXT, attrib_list);

        // TODO Update to EGL14?
        //egl.eglSurfaceAttrib(display, egl.eglGetCurrentSurface(EGL_DRAW), EGL_SWAP_BEHAVIOR, EGL_BUFFER_DESTROYED);

        return context;
    }

    public void destroyContext(EGL10 egl, EGLDisplay display, EGLContext context)
    {
        egl.eglDestroyContext(display, context);
    }
}
