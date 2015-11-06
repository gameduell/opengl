#import <Foundation/Foundation.h>

#include <hx/CFFI.h>

@interface DUELLDelegateOGL : NSObject

+ (DUELLDelegateOGL*)sharedDUELLDelegateOGL;
- (void)removeSplashScreen;
- (BOOL)splashScreenRemoved;

@end