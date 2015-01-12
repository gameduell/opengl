package org.haxe.duell.opengl;

import android.annotation.TargetApi;
import android.opengl.GLSurfaceView;
import android.os.Build;
import org.haxe.duell.DuellActivity;
import org.haxe.duell.MainHaxeThreadHandler;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;
import java.util.ArrayDeque;

@TargetApi(Build.VERSION_CODES.GINGERBREAD)
class DuellGLRenderer implements GLSurfaceView.Renderer
{
    private final ArrayDeque<Runnable> queue = new ArrayDeque<Runnable>();

    public void onDrawFrame(GL10 gl)
    {
        while (!queue.isEmpty())
        {
            queue.remove().run();
        }

        DuellGLNativeInterface.onRender();
    }

    public void onSurfaceChanged(GL10 gl, int width, int height)
    {
        DuellGLNativeInterface.onSizeChanged(width, height);
    }

    public void onSurfaceCreated(GL10 gl, EGLConfig config)
    {
        DuellActivity.getInstance().setMainHaxeThreadHandler(
                new MainHaxeThreadHandler()
                {
                    @Override
                    public void queueRunnableOnMainHaxeThread(Runnable runObj)
                    {
                        queue.add(runObj);
                    }
                }
        );
    }
}