#import <Foundation/Foundation.h>

#include <hx/CFFI.h>

@interface DUELLDelegateOGL : NSObject

+ (DUELLDelegateOGL*)sharedDUELLDelegateOGL;
- (void)removeSplashScreen:(float)delay withFadeOutAnimation:(float)duration;
- (BOOL)splashScreenRemoved;

@end