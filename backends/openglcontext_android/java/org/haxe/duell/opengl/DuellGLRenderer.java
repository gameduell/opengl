package org.haxe.duell.opengl;

import java.lang.Override;
import java.util.ArrayDeque;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.opengl.GLSurfaceView;
import android.os.Handler;
import android.os.Looper;
import android.os.MessageQueue;
import android.util.Log;
import org.haxe.duell.DuellActivity;
import org.haxe.duell.opengl.DuellGLNativeInterface;
import org.haxe.duell.MainHaxeThreadHandler;

class DuellGLRenderer implements GLSurfaceView.Renderer{

    private final ArrayDeque<Runnable> queue = new ArrayDeque();

    public void onDrawFrame(GL10 gl) {
        while(!queue.isEmpty())
        {
            queue.remove().run();
        }

        DuellGLNativeInterface.onRender();
    }

    public void onSurfaceChanged(GL10 gl, int width, int height) {
        DuellGLNativeInterface.onSizeChanged(width, height);
    }

    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        DuellActivity.getInstance().setMainHaxeThreadHandler(
                new MainHaxeThreadHandler() {

                    @Override
                    public void queueRunnableOnMainHaxeThread(Runnable runObj) {
                        queue.add(runObj);
                    }

                }
        );
    }
}