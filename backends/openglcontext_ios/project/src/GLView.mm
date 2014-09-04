#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

#import "GLView.h"

static double GetTimeMS()
{
	return (CACurrentMediaTime()*1000.0);
}

@interface GLView ()
{
    NSInteger _animationFrameInterval;
	CADisplayLink *_displayLink;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint _defaultFramebuffer, _colorRenderbuffer;
    
    // The OpenGL frame for the depth buffer
    GLuint _depthRenderbuffer;
    
    double _renderTime;
    BOOL _zeroDeltaTime;


    // HAXE
    //AutoGCRoot *_drawCallback;
}

@end


@implementation GLView

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        
        if (!_context || ![EAGLContext setCurrentContext:_context])
		{
            return nil;
        }
        
        [self setupGL];
        
		_animating = FALSE;
        _animationFrameInterval = 1;
		_displayLink = nil;
        
        _zeroDeltaTime = TRUE;
    }
    
    return self;
}

- (void)setupGL
{
    // Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
    glGenFramebuffers(1, &_defaultFramebuffer);
    glGenRenderbuffers(1, &_colorRenderbuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _defaultFramebuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderbuffer);
    
    // Create a depth buffer as we want to enable GL_DEPTH_TEST in this sample
    glGenRenderbuffers(1, &_depthRenderbuffer);

    glEnable(GL_DEPTH_TEST);
}

extern void callHaxeMainRenderCallback();
- (void)drawView:(id)sender
{
    double currentTime = GetTimeMS();
    double deltaTime = _zeroDeltaTime ? 0.0 : currentTime - _renderTime;
    _renderTime = currentTime;
    
    if (_zeroDeltaTime)
        _zeroDeltaTime = FALSE;

    [EAGLContext setCurrentContext:_context];


    // ourRendering here

    glBindFramebuffer(GL_FRAMEBUFFER, _defaultFramebuffer);
    glViewport(0, 0, _contextWidth, _contextHeight);

    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    callHaxeMainRenderCallback();

    [_context presentRenderbuffer:GL_RENDERBUFFER];

    // ourrending ends here
}

- (BOOL)resizeFromLayer
{
    CAEAGLLayer *layer = (CAEAGLLayer*)self.layer;
    
	// Allocate color buffer backing based on the current layer size
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_contextWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_contextHeight);
    
    // Allocate storage for the depth buffer, and attach it to the framebuffer’s depth attachment point
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderbuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, _contextWidth, _contextHeight);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderbuffer);

    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
        return NO;
    }
        
    return YES;
}

- (void)layoutSubviews
{
	if ([self resizeFromLayer])
    {
        // An external display might just have been connected/disconnected. We do not want to
        // consider time spent in the connection/disconnection in the animation.
        _zeroDeltaTime = TRUE;
        [self drawView:nil];
    }
}

#pragma Display Link 

- (NSInteger)animationFrameInterval
{
	return _animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		_animationFrameInterval = frameInterval;
		
		if (_animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void)startAnimation
{
	if (!_animating)
	{
	    // A CADisplayLink created using the class method is always bound to the internal display.
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView:)];

        [_displayLink setFrameInterval:self.animationFrameInterval];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

        _zeroDeltaTime = TRUE;
		_animating = TRUE;
	}
}

- (void)stopAnimation
{
	if (_animating)
	{
        [_displayLink invalidate];
		_animating = FALSE;
	}
}



- (void)dealloc
{
    // tear down OpenGL
	if (_defaultFramebuffer)
	{
		glDeleteFramebuffers(1, &_defaultFramebuffer);
		_defaultFramebuffer = 0;
	}
	
	if (_colorRenderbuffer)
	{
		glDeleteRenderbuffers(1, &_colorRenderbuffer);
		_colorRenderbuffer = 0;
	}
    
    // tear down context
	if ([EAGLContext currentContext] == _context)
        [EAGLContext setCurrentContext:nil];


    if (_displayLink != nil)
    {
        [_displayLink invalidate];
    }

    if (_context != nil)
    {
        [_context release];
    }

    [super dealloc];
}

@end
