/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 04/06/14
 * Time: 16:08
 */
package gl;

/// implemented in openglcontext_ios, openglcontext_android, openglcontext_html5, openglcontext_mac
extern class GLContext
{
    public function new(params:GLContextParameters):Void;

    public function bind():Void;

    public static function getCurrentContext():GLContext;

    public function destroy():Void;

    /// should be called when the application starts, so the initial context is created.
    public static function setupInitialContext():Void;
}