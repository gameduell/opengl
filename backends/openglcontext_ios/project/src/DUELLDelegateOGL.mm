
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "openglcontext_ios/DUELLDelegateOGL.h"

#import "DUELLAppDelegate.h"
#import "DUELLDelegate.h"

@interface DUELLDelegateOGL () <DUELLDelegate>

@property (nonatomic, readwrite, strong) UIImageView *splashView;

@end

@implementation DUELLDelegateOGL

+ (DUELLDelegateOGL*)sharedDUELLDelegateOGL
{
    static DUELLDelegateOGL* sDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sDelegate = [[self alloc] init];
                  });

    return sDelegate;
}

+ (void)load
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];

    [center
     addObserverForName:UIApplicationDidFinishLaunchingNotification
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note)
     {
         [DUELLDelegateOGL sharedDUELLDelegateOGL];
     }];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        DUELLAppDelegate *appDelegate = (DUELLAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate addDuellDelegate:self];
    }

    DUELLAppDelegate *sharedDelegate = (DUELLAppDelegate*)[[UIApplication sharedApplication] delegate];

    self.splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sharedDelegate.rootView.frame.size.width, sharedDelegate.rootView.frame.size.height)];
    self.splashView.image = [UIImage imageNamed:[self getLaunchImageName]];
    [sharedDelegate.rootView addSubview:self.splashView];
    [sharedDelegate.window bringSubviewToFront:self.splashView];

    return self;
}

- (void)removeSplashScreen
{
    if ([self splashScreenRemoved])
    {
        return;
    }

    /// FadeOut animation optional
    [UIView animateWithDuration:1.0 delay:0.0 options:0 animations:^{
        self.splashView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.splashView removeFromSuperview];
        [self.splashView release];
        self.splashView = NULL;
    }];
}

- (BOOL)splashScreenRemoved
{
    return self.splashView == NULL;
}

- (NSString *)getLaunchImageName
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    NSString *LINameExtension = @"";
    NSString *LIScale = @"";
    NSString *deviceModel = [UIDevice currentDevice].model;

    if ([deviceModel rangeOfString:@"iPod"].location != NSNotFound || [deviceModel rangeOfString:@"iPhone"].location != NSNotFound)
    {
        if ([[UIScreen mainScreen] bounds].size.width == 568 || [[UIScreen mainScreen] bounds].size.height == 568)
        {
            LINameExtension = @"-568h";
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
        {
            LINameExtension = @"-Landscape";
        }
        else
        {
            LINameExtension = @"-Portrait";
        }
    }

    if ([[UIScreen mainScreen] scale] == 1.0)
    {
        LIScale = @"";
    }
    else
    {
        LIScale = @"@2x";
    }

    NSString *combined = [NSString stringWithFormat:@"Default%@%@.png", LINameExtension, LIScale];

    return combined;
}

@end