## Description

This library provides the OpenGL API. It works on iOS, Android and HTML5. It can also work on any cpp target, but we only currently provide backends for the creation of OpenGL contexts in iOS, Android and HTML5.
It currently has a very initial implementation of a initial opengl state xml configuration plugin. Currently you can only set the html5 windows size, but the idea is to add all the opengl state configurable this way with other opengl state things, e.g. depth test enable/disable.

## Usage:

Initialize the GLContext and call OpenGL methods.

= Release Log =

== v5.1.0 ==

=== OpenGL ===

- Added proguard support
- Added support to use OpenGL extensions 
- Added Vertex Array Objects and DiscardFramebuffer extensions

== v5.0.0 ==

=== OpenGL ===

- Added files for documentation generation.
- Refactored opengl backend for HTML5, that it just creates data views on the served data, when it is actually needed.
  This reduces GC activity a lot on HTML5.
- Implemented a webgl debugger to simulate losing the opengl context. Compile with -D webgldebug to activate it.