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
import android.opengl.GLSurfaceView;
import android.os.Build;
import org.haxe.duell.DuellActivity;
import org.haxe.duell.MainHaxeThreadHandler;
import org.haxe.duell.opengl.DuellGLView;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

@TargetApi(Build.VERSION_CODES.GINGERBREAD)
class DuellGLRenderer implements GLSurfaceView.Renderer {

    public void onDrawFrame(GL10 gl)
    {
        DuellGLNativeInterface.onRender();
    }

    public void onSurfaceChanged(GL10 gl, int width, int height)
    {
        DuellGLNativeInterface.onSizeChanged(width, height);
    }

    public void onSurfaceCreated(GL10 gl, EGLConfig config)
    {
        DuellActivity.getInstance().setMainHaxeThreadHandler(
                new MainHaxeThreadHandler() {
                    @Override
                    public void queueRunnableOnMainHaxeThread(Runnable runObj)
                    {
                        DuellActivity activity = DuellActivity.getInstance();
                        if (activity == null)
                            return;

                        if (DuellActivity.getInstance().mainView == null)
                            return;

                        DuellGLView glview = (DuellGLView) DuellActivity.getInstance().mainView.get();

                        if (glview == null)
                            return;

                        glview.queueEvent(runObj);
                    }
                }
        );

        DuellGLNativeInterface.onContextRecreated();
    }
}
