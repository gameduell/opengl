/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

#import "openglcontext_ios/GLView.h"

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

    // The OpenGL name for the depth buffer
    GLuint _depthStencilRenderbuffer; // Combined depthAndStencil

    double _renderTime;
    BOOL _zeroDeltaTime;
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

		eaglLayer.contentsScale = [[UIScreen mainScreen] scale];  // Here we could add a multiplier to support custom pixel scaling. This may improve performance on older devices.

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

    // Create a depth&stencil buffer as we want to enable DEPTH_TEST and STENCIL_TEST
    glGenRenderbuffers(1, &_depthStencilRenderbuffer);
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

    glBindFramebuffer(GL_FRAMEBUFFER, _defaultFramebuffer);
    glViewport(0, 0, _contextWidth, _contextHeight);

    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);

    // ourRendering here
    callHaxeMainRenderCallback();
    // ourrending ends here

    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

extern void callHaxeOnSizeChangedCallback();
- (BOOL)resizeFromLayer
{
    CAEAGLLayer *layer = (CAEAGLLayer*)self.layer;

	// Allocate color buffer backing based on the current layer size
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_contextWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_contextHeight);

    // Allocate storage for the depth buffer and stencil buffer, and attach it to the framebuffer’s depth attachment point
    glBindRenderbuffer(GL_RENDERBUFFER, _depthStencilRenderbuffer);
    glRenderbufferStorage( GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, _contextWidth, _contextHeight );
    glFramebufferRenderbuffer( GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthStencilRenderbuffer );
    glFramebufferRenderbuffer( GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _depthStencilRenderbuffer );

    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
        return NO;
    }

    callHaxeOnSizeChangedCallback();

    return YES;
}

- (void)layoutSubviews
{
    CGSize size = self.bounds.size;

    if (!CGSizeEqualToSize(size, self.previousSize))
    {
        //rebuild framebuffer
        if ([self resizeFromLayer])
        {
            // An external display might just have been connected/disconnected. We do not want to
            // consider time spent in the connection/disconnection in the animation.
            _zeroDeltaTime = TRUE;
            [self drawView:nil];
        }

        //update size
        _previousSize = size;
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
