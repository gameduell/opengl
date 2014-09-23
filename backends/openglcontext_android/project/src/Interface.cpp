
#include <jni.h>
#include <android/log.h>
#include <pthread.h>


#ifdef __GNUC__
  #define JAVA_EXPORT __attribute__ ((visibility("default"))) JNIEXPORT
#else
  #define JAVA_EXPORT JNIEXPORT
#endif

#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#include <hx/CFFI.h>

struct AutoHaxe
{
   int base;
   const char *message;
   AutoHaxe(const char *inMessage)
   {  
      base = 0;
      message = inMessage;
      gc_set_top_of_stack(&base,true);
      //__android_log_print(ANDROID_LOG_VERBOSE, "OpenGL", "Enter %s %p", message, pthread_self());
   }
   ~AutoHaxe()
   {
      //__android_log_print(ANDROID_LOG_VERBOSE, "OpenGL", "Leave %s %p", message, pthread_self());
      gc_set_top_of_stack(0,true);
   }
};

value *__onMainRenderCallback = NULL;
value *__onSizeChangedCallback = NULL;

static value openglcontextandroid_assign_native_callbacks(value onMainRenderCallback, value onSizeChangedCallback)
{
	val_check_function(onMainRenderCallback, 0); // Is Func ?

	if (__onMainRenderCallback == NULL)
	{
		__onMainRenderCallback = alloc_root();
	}
	*__onMainRenderCallback = onMainRenderCallback;

	val_check_function(onSizeChangedCallback, 2); // Is Func ?

	if (__onSizeChangedCallback == NULL)
	{
		__onSizeChangedCallback = alloc_root();
	}
	*__onSizeChangedCallback = onSizeChangedCallback;

	return alloc_null();
}
DEFINE_PRIM (openglcontextandroid_assign_native_callbacks, 2);


extern "C" {
	JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onSizeChanged(JNIEnv * env, jobject obj, jint width, jint height);
	JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onRender(JNIEnv * env, jobject obj);
};

JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onSizeChanged(JNIEnv * env, jobject obj, jint width, jint height)
{
	AutoHaxe haxe("onSizeChanged");
	val_call2(*__onSizeChangedCallback, alloc_int(width), alloc_int(height));
}

JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onRender(JNIEnv * env, jobject obj)
{
	AutoHaxe haxe("onRender");
	val_call0(*__onMainRenderCallback);
}

extern "C" int openglcontextandroid_register_prims () { return 0; }