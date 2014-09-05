#ifndef __OPENGL_CONTEXT_IOS_TOUCH__
#define __OPENGL_CONTEXT_IOS_TOUCH__

#include <hx/CFFI.h>

namespace openglcontext_ios
{

DECLARE_KIND(k_GLTouch) 


class GLTouch
{
	public: 
		int x;
		int y;
		int id;
		int state; ///0 began, 1 moved, 2 stationary, 3 ended
		double timestamp;

	static value createHaxePointer();
};

}

#endif //__OPENGL_CONTEXT_IOS_TOUCH__