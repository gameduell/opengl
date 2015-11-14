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

#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#include <hx/CFFI.h>

#import "openglcontext_ios/OpenGLResponder.h"
#import "openglcontext_ios/DUELLDelegateOGL.h"

DEFINE_KIND(k_Context)

value *__onMainRenderCallback = NULL;
value *__onSizeChangedCallback = NULL;

static value openglcontextios_initialize_main_context(value onMainRenderCallback, value onSizeChangedCallback)
{
	val_check_function(onMainRenderCallback, 0); // Is Func ?

	if (__onMainRenderCallback == NULL)
	{
		__onMainRenderCallback = alloc_root();
	}
	*__onMainRenderCallback = onMainRenderCallback;

	val_check_function(onSizeChangedCallback, 0); // Is Func ?

	if (__onSizeChangedCallback == NULL)
	{
		__onSizeChangedCallback = alloc_root();
	}
	*__onSizeChangedCallback = onSizeChangedCallback;

	EAGLContext *context = [OpenGLResponder initializeMainContext];

	return alloc_abstract(k_Context, context);
}
DEFINE_PRIM (openglcontextios_initialize_main_context, 2);

static value openglcontextios_removeSplashScreen (value delay, value duration)
{
    [[DUELLDelegateOGL sharedDUELLDelegateOGL] removeSplashScreen:val_float(delay) withFadeOutAnimation:val_float(duration)];
	return alloc_null();
}
DEFINE_PRIM (openglcontextios_removeSplashScreen, 2);

static value openglcontextios_get_splashScreenRemoved()
{
    return alloc_bool([[DUELLDelegateOGL sharedDUELLDelegateOGL] splashScreenRemoved]);
}
DEFINE_PRIM(openglcontextios_get_splashScreenRemoved,0);

static value openglcontextios_get_main_context_width()
{
	return alloc_int([OpenGLResponder contextWidth]);
}
DEFINE_PRIM (openglcontextios_get_main_context_width, 0);

static value openglcontextios_get_main_context_height()
{
	return alloc_int([OpenGLResponder contextHeight]);
}
DEFINE_PRIM (openglcontextios_get_main_context_height, 0);

void callHaxeMainRenderCallback()
{
	val_call0(*__onMainRenderCallback);
}

void callHaxeOnSizeChangedCallback()
{
	val_call0(*__onSizeChangedCallback);
}

extern "C" int openglcontextios_register_prims () { return 0; }
