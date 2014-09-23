package org.haxe.duell.opengl;

import android.content.Context;
import android.graphics.Bitmap;
import android.opengl.GLSurfaceView;

public final class DuellGLView extends GLSurfaceView {

    private final DuellGLRenderer renderer;

    public DuellGLView(Context _context) {
        super(_context);

        // Create an OpenGL ES 2.0 context.
        setEGLContextClientVersion(2);

        setEGLConfigChooser(new DuellGLConfigChooser(Bitmap.Config.ARGB_8888, 0, 8, 0));

        renderer = new DuellGLRenderer();
        setRenderer(renderer);

        setPreserveEGLContextOnPause(true);
    }

}

