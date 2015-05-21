## Description

This library provides the OpenGL API. It works on iOS, Android and HTML5. It can also work on any cpp target, but we only currently provide backends for the creation of OpenGL contexts in iOS, Android and HTML5.
It currently has a very initial implementation of a initial opengl state xml configuration plugin. Currently you can only set the html5 windows size, but the idea is to add all the opengl state configurable this way with other opengl state things, e.g. depth test enable/disable.

## Usage:

Initialize the GLContext and call OpenGL methods.
