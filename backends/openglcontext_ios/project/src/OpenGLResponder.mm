#import <UIKit/UIKit.h>

#import "openglcontext_ios/OpenGLResponder.h"

#import "openglcontext_ios/GLViewController.h"


@implementation OpenGLResponder

+ (EAGLContext *)initializeMainContext
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

     GLViewController* controller = [[GLViewController alloc] init];
     window.rootViewController = controller;

    [window makeKeyAndVisible];

    return controller.context;
}

+ (int)contextWidth 
{   
    return self.glViewcontroller.contextWidth;
}

+ (int)contextHeight
{
    return self.glViewcontroller.contextHeight;
}

+ (GLViewController *)glViewcontroller
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return (GLViewController*) window.rootViewController;
}

@end
