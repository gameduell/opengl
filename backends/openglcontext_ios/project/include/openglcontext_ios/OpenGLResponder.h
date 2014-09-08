#import <Foundation/Foundation.h>

@class EAGLContext;

@interface OpenGLResponder : NSObject

+ (EAGLContext *) initializeMainContext;
+ (int)getContextWidth;
+ (int)getContextHeight;

@end