#include <openglcontext_ios/GLTouch.h>
#include <string>

#include <hx/CFFI.h>

class GLTouch_Impl : public openglcontext_ios::GLTouch
{
	public:
		static value createHaxePointer();

		~GLTouch_Impl();
		GLTouch_Impl();

		int get_x();
};

GLTouch_Impl::GLTouch_Impl()
{
	x = 0;
	y = 0;
	id = 0;
	state = 0;
	timestamp = false;
}

GLTouch_Impl::~GLTouch_Impl()
{

}

DEFINE_KIND(k_GLTouch) 

value openglcontext_ios::GLTouch::createHaxePointer()
{
	value v;
	v = alloc_abstract(k_GLTouch, new GLTouch_Impl());
	return v;
}


