#import <Foundation/Foundation.h>

@class EAGLContext;


@interface OpenGLResponder : NSObject

+ (EAGLContext *)initializeMainContext;
+ (int)contextWidth;
+ (int)contextHeight;

@end
