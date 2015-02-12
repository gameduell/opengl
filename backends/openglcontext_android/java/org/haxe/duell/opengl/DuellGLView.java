package org.haxe.duell.opengl;

import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Bitmap;
import android.opengl.GLSurfaceView;
import android.os.Build;

@TargetApi(Build.VERSION_CODES.HONEYCOMB)
public final class DuellGLView extends GLSurfaceView
{
    public DuellGLView(Context context)
    {
        super(context);

        // Create an OpenGL ES 2.0 context.
        setEGLContextClientVersion(2);

        setEGLConfigChooser(new DuellGLConfigChooser(Bitmap.Config.ARGB_8888, 16, 8, 0));

        DuellGLRenderer renderer = new DuellGLRenderer();
        setRenderer(renderer);

        setPreserveEGLContextOnPause(true);
    }
}

