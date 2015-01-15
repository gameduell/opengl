#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#include <hx/CFFI.h>

#import "openglcontext_ios/OpenGLResponder.h"

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