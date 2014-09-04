#import "OpenGLResponder.h"
#import "GLViewController.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface OpenGLResponder ()
{
    //AutoGCRoot *_memoryWarningCallback;
}

@end

static UIWindow *__window;

@implementation OpenGLResponder

+ (EAGLContext *) initializeMainContext
{
    __window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    GLViewController *controller = [[GLViewController alloc] init];
    __window.rootViewController = controller;

    [__window makeKeyAndVisible];

    return [controller getOGLContext];
}

+ (int)getContextWidth
{
	return [((GLViewController *)__window.rootViewController) getContextWidth];
}

+ (int)getContextHeight
{
	return [((GLViewController *)__window.rootViewController) getContextHeight];
}

@end
