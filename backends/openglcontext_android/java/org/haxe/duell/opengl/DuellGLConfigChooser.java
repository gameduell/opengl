package org.haxe.duell.opengl;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.egl.EGLDisplay;

import android.graphics.Bitmap;
import android.opengl.GLSurfaceView;
import android.util.Log;

/**
 * EGLConfigChooser implementation for GLES 2.0. Let's hope this really works for all devices with GLES 2.0. Includes
 * MSAA/CSAA config selection if requested. Taken from GLSurfaceView20, heavily modified to accommodate MSAA/CSAA.
 * <p/>
 * Implementation based in LibGDX, with the source code available at https://github.com/libgdx/libgdx under the Apache
 * 2.0 License.
 */
final class DuellGLConfigChooser implements GLSurfaceView.EGLConfigChooser {

    private static final String TAG = "GdxEglConfigChooser";

    private static final int EGL_COVERAGE_BUFFERS_NV = 0x30E0;
    private static final int EGL_COVERAGE_SAMPLES_NV = 0x30E1;
    private static final int EGL_OPENGL_ES2_BIT = 4;

    private final int redSize;
    private final int greenSize;
    private final int blueSize;
    private final int alphaSize;
    private final int depthSize;
    private final int stencilSize;
    private final int numSamples;

    private final int[] configAttribs;
    private final int[] value;

    private boolean coverageSamplingAAEnabled;
    private boolean antiAliasingEnabled;

    /**
     * Creates an EglConfigChooser with the color configuration, depth buffer size, stencil buffer size, requested
     * number of samples and supports only GLES 2.0.
     *
     * @param _config     the required color configuration
     * @param _depth      the required depth buffer size in bits
     * @param _stencil    the required stencil buffer size in bits
     * @param _numSamples the requested number of samples
     */
    public DuellGLConfigChooser(Bitmap.Config _config, int _depth, int _stencil, int _numSamples) {
        // select color size based on config
        switch (_config) {
            case ARGB_8888:
                redSize = 8;
                greenSize = 8;
                blueSize = 8;
                alphaSize = 8;
                break;

            case ARGB_4444:
                redSize = 4;
                greenSize = 4;
                blueSize = 4;
                alphaSize = 4;
                break;

            default:
                redSize = 5;
                greenSize = 6;
                blueSize = 5;
                alphaSize = 0;
                break;
        }

        depthSize = _depth;
        stencilSize = _stencil;
        numSamples = _numSamples;

        configAttribs = new int[]{EGL10.EGL_RED_SIZE, 4, EGL10.EGL_GREEN_SIZE, 4, EGL10.EGL_BLUE_SIZE, 4,
                EGL10.EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT, EGL10.EGL_NONE};

        value = new int[1];
    }

    /**
     * Retrieves whether NVidia CSAA (Coverage Sampling Anti-Aliasing) is enabled.
     *
     * @return true if CSAA is enabled, false otherwise
     */
    public boolean isCSAAEnabled() {
        return coverageSamplingAAEnabled;
    }

    /**
     * Retrieves whether AA (Anti-Aliasing) is enabled.
     *
     * @return true if AA is enabled, false otherwise
     */
    public boolean isAAEnabled() {
        return antiAliasingEnabled;
    }

    @Override
    public EGLConfig chooseConfig(EGL10 _egl, EGLDisplay _display) {
        // get (almost) all configs available by using r=g=b=4 so we can choose with big confidence :)
        int[] numConfig = new int[1];
        _egl.eglChooseConfig(_display, configAttribs, null, 0, numConfig);
        int numConfigs = numConfig[0];

        if (numConfigs <= 0) {
            throw new IllegalArgumentException("No configs match configSpec");
        }

        // now actually read the configurations
        EGLConfig[] configs = new EGLConfig[numConfigs];
        _egl.eglChooseConfig(_display, configAttribs, configs, numConfigs, numConfig);

        // choose the best one, taking into account multisampling
        // EGLConfig config = chooseConfig(_egl, _display, configs);
        // printConfig(_egl, _display, config);
        // return config;

        return chooseConfig(_egl, _display, configs);
    }

    private EGLConfig chooseConfig(EGL10 _egl, EGLDisplay _display, EGLConfig[] _configs) {
        EGLConfig best = null;
        EGLConfig bestAA = null;
        EGLConfig safe = null; //default back to 565 when no exact match found

        for (EGLConfig config : _configs) {
            int d = findConfigAttrib(_egl, _display, config, EGL10.EGL_DEPTH_SIZE, 0);
            int s = findConfigAttrib(_egl, _display, config, EGL10.EGL_STENCIL_SIZE, 0);

            // We need at least depthSize and stencilSize bits
            if (d < depthSize || s < stencilSize) {
                continue;
            }

            // We want an *exact* match for red/green/blue/alpha
            int r = findConfigAttrib(_egl, _display, config, EGL10.EGL_RED_SIZE, 0);
            int g = findConfigAttrib(_egl, _display, config, EGL10.EGL_GREEN_SIZE, 0);
            int b = findConfigAttrib(_egl, _display, config, EGL10.EGL_BLUE_SIZE, 0);
            int a = findConfigAttrib(_egl, _display, config, EGL10.EGL_ALPHA_SIZE, 0);

            // Match RGB565 as a fallback
            if (safe == null && isMatchingColor(5, 6, 5, 0)) {
                safe = config;
            }
            // if we have a match, we chose this as our non AA fallback if that one
            // isn't set already.
            if (best == null && isMatchingColor(r, g, b, a)) {
                best = config;

                // if no AA is requested we can bail out here.
                if (numSamples == 0) {
                    break;
                }
            }

            // now check for MSAA support
            int hasSampleBuffers = findConfigAttrib(_egl, _display, config, EGL10.EGL_SAMPLE_BUFFERS, 0);
            int samples = findConfigAttrib(_egl, _display, config, EGL10.EGL_SAMPLES, 0);

            // We take the first sort of matching config, thank you.
            if (bestAA == null && isMultisample(hasSampleBuffers, samples) && isMatchingColor(r, g, b, a)) {
                bestAA = config;
                antiAliasingEnabled = true;
                continue;
            }

            // for this to work we need to call the extension glCoverageMaskNV which is not
            // exposed in the Android bindings. We'd have to link agains the NVidia SDK and
            // that is simply not going to happen.
            // still no luck, let's try CSAA support
            hasSampleBuffers = findConfigAttrib(_egl, _display, config, EGL_COVERAGE_BUFFERS_NV, 0);
            samples = findConfigAttrib(_egl, _display, config, EGL_COVERAGE_SAMPLES_NV, 0);

            // We take the first sort of matching config, thank you.
            if (bestAA == null && isMultisample(hasSampleBuffers, samples) && isMatchingColor(r, g, b, a)) {
                bestAA = config;
                coverageSamplingAAEnabled = true;
            }
        }

        if (bestAA != null) {
            return bestAA;
        } else if (best != null) {
            return best;
        } else {
            return safe;
        }
    }

    private boolean isMatchingColor(int _r, int _g, int _b, int _a) {
        return _r == redSize && _g == greenSize && _b == blueSize && _a == alphaSize;
    }

    private boolean isMultisample(int _hasSampleBuffers, int _numSamples) {
        return _hasSampleBuffers == 1 && _numSamples >= numSamples;
    }

    private int findConfigAttrib(EGL10 _egl, EGLDisplay _display, EGLConfig _config, int _attrib, int _defaultValue) {
        if (_egl.eglGetConfigAttrib(_display, _config, _attrib, value)) {
            return value[0];
        }
        return _defaultValue;
    }

    private void printConfigs(EGL10 _egl, EGLDisplay _display, EGLConfig[] _configs) {
        int numConfigs = _configs.length;
        Log.w(TAG, String.format("%d configurations", numConfigs));
        for (int i = 0; i < numConfigs; i++) {
            Log.w(TAG, String.format("Configuration %d:\n", i));
            printConfig(_egl, _display, _configs[i]);
        }
    }

    private void printConfig(EGL10 _egl, EGLDisplay _display, EGLConfig _config) {
        int[] attributes = {EGL10.EGL_BUFFER_SIZE, EGL10.EGL_ALPHA_SIZE, EGL10.EGL_BLUE_SIZE, EGL10.EGL_GREEN_SIZE,
                EGL10.EGL_RED_SIZE, EGL10.EGL_DEPTH_SIZE, EGL10.EGL_STENCIL_SIZE, EGL10.EGL_CONFIG_CAVEAT, EGL10.EGL_CONFIG_ID,
                EGL10.EGL_LEVEL, EGL10.EGL_MAX_PBUFFER_HEIGHT, EGL10.EGL_MAX_PBUFFER_PIXELS, EGL10.EGL_MAX_PBUFFER_WIDTH,
                EGL10.EGL_NATIVE_RENDERABLE, EGL10.EGL_NATIVE_VISUAL_ID, EGL10.EGL_NATIVE_VISUAL_TYPE,
                0x3030, // EGL10.EGL_PRESERVED_RESOURCES,
                EGL10.EGL_SAMPLES, EGL10.EGL_SAMPLE_BUFFERS, EGL10.EGL_SURFACE_TYPE, EGL10.EGL_TRANSPARENT_TYPE,
                EGL10.EGL_TRANSPARENT_RED_VALUE, EGL10.EGL_TRANSPARENT_GREEN_VALUE, EGL10.EGL_TRANSPARENT_BLUE_VALUE, 0x3039, // EGL10.EGL_BIND_TO_TEXTURE_RGB,
                0x303A, // EGL10.EGL_BIND_TO_TEXTURE_RGBA,
                0x303B, // EGL10.EGL_MIN_SWAP_INTERVAL,
                0x303C, // EGL10.EGL_MAX_SWAP_INTERVAL,
                EGL10.EGL_LUMINANCE_SIZE, EGL10.EGL_ALPHA_MASK_SIZE, EGL10.EGL_COLOR_BUFFER_TYPE, EGL10.EGL_RENDERABLE_TYPE, 0x3042,
                // EGL10.EGL_CONFORMANT
                EGL_COVERAGE_BUFFERS_NV, /* true */
                EGL_COVERAGE_SAMPLES_NV};
        String[] names = {"EGL_BUFFER_SIZE", "EGL_ALPHA_SIZE", "EGL_BLUE_SIZE", "EGL_GREEN_SIZE", "EGL_RED_SIZE", "EGL_DEPTH_SIZE",
                "EGL_STENCIL_SIZE", "EGL_CONFIG_CAVEAT", "EGL_CONFIG_ID", "EGL_LEVEL", "EGL_MAX_PBUFFER_HEIGHT",
                "EGL_MAX_PBUFFER_PIXELS", "EGL_MAX_PBUFFER_WIDTH", "EGL_NATIVE_RENDERABLE", "EGL_NATIVE_VISUAL_ID",
                "EGL_NATIVE_VISUAL_TYPE", "EGL_PRESERVED_RESOURCES", "EGL_SAMPLES", "EGL_SAMPLE_BUFFERS", "EGL_SURFACE_TYPE",
                "EGL_TRANSPARENT_TYPE", "EGL_TRANSPARENT_RED_VALUE", "EGL_TRANSPARENT_GREEN_VALUE", "EGL_TRANSPARENT_BLUE_VALUE",
                "EGL_BIND_TO_TEXTURE_RGB", "EGL_BIND_TO_TEXTURE_RGBA", "EGL_MIN_SWAP_INTERVAL", "EGL_MAX_SWAP_INTERVAL",
                "EGL_LUMINANCE_SIZE", "EGL_ALPHA_MASK_SIZE", "EGL_COLOR_BUFFER_TYPE", "EGL_RENDERABLE_TYPE", "EGL_CONFORMANT",
                "EGL_COVERAGE_BUFFERS_NV", "EGL_COVERAGE_SAMPLES_NV"};

        for (int i = 0; i < attributes.length; i++) {
            int attribute = attributes[i];
            String name = names[i];
            if (_egl.eglGetConfigAttrib(_display, _config, attribute, value)) {
                Log.w(TAG, String.format("  %s: %d\n", name, value[0]));
            } else {
                _egl.eglGetError();
            }
        }
    }
}