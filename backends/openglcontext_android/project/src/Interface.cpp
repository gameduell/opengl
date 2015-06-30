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
value *__onContextRecreatedCallback = NULL;

static value openglcontextandroid_assign_native_callbacks(value onMainRenderCallback, value onSizeChangedCallback, value onContextRecreatedCallback)
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

	val_check_function(onContextRecreatedCallback, 0); // Is Func ?

    	if (__onContextRecreatedCallback == NULL)
    	{
    		__onContextRecreatedCallback = alloc_root();
    	}
    	*__onContextRecreatedCallback = onContextRecreatedCallback;

	return alloc_null();
}
DEFINE_PRIM (openglcontextandroid_assign_native_callbacks, 3);


extern "C" {
	JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onSizeChanged(JNIEnv * env, jobject obj, jint width, jint height);
	JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onRender(JNIEnv * env, jobject obj);
	JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onContextRecreated(JNIEnv * env, jobject obj);
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

JAVA_EXPORT void JNICALL Java_org_haxe_duell_opengl_DuellGLNativeInterface_onContextRecreated(JNIEnv * env, jobject obj)
{
    __android_log_print(ANDROID_LOG_VERBOSE, "OpenGL", "ContextRecreated");
	AutoHaxe haxe("onContextRecreated");
	val_call0(*__onContextRecreatedCallback);
}

extern "C" int openglcontextandroid_register_prims () { return 0; }
