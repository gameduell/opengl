#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#include <hx/CFFI.h>

#import "openglcontext_ios/OpenGLResponder.h"

value *__onMainRenderCallback = NULL;
value *__onSizeChangedCallback = NULL;
value *__onTouchesCallback = NULL;

static value openglcontextios_initialize_main_context(value onMainRenderCallback, value onSizeChangedCallback, value onTouchesCallback)
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

	val_check_function(onTouchesCallback, 1); // Is Func ?

	if (__onTouchesCallback == NULL)
	{
		__onTouchesCallback = alloc_root();
	}
	*__onTouchesCallback = onTouchesCallback;

	EAGLContext *context = [OpenGLResponder initializeMainContext];

	return (value)context;
}
DEFINE_PRIM (openglcontextios_initialize_main_context, 3);

static value openglcontextios_get_main_context_width()
{
	return alloc_int([OpenGLResponder getContextWidth]);
}
DEFINE_PRIM (openglcontextios_get_main_context_width, 0);

static value openglcontextios_get_main_context_height()
{
	return alloc_int([OpenGLResponder getContextHeight]);
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

void callHaxeOnTouchesCallback(value touchList)
{
	val_call1(*__onTouchesCallback, touchList);
}

extern "C" int openglcontextios_register_prims () { return 0; }