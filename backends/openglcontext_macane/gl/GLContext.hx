/**
 * @autor kgar
 * @date 05.09.2014.
 * @company Gameduell GmbH
 */
package gl;
import msignal.Signal;

class GLContext
{
	/// STATIC
	public static var onRenderOnMainContext : Signal0;

	private static var mainContext : GLContext;

    public static function getMainContext() : GLContext
    {
    	return mainContext;
    }

    
    public static function setupMainContext(finishedCallback : Void->Void) : Void
    {
    	onRenderOnMainContext = new Signal0();
    	mainContext = new GLContext(null);
    	mainContext.contextWidth = 1024;
    	mainContext.contextHeight = 768;
        mainContext.onContextSizeChanged = new Signal0();

        finishedCallback();
    }

    public static function mainContextSizeChangedCallback()
    {
    	mainContext.contextWidth = 1024;
    	mainContext.contextHeight = 768;
    	mainContext.onContextSizeChanged.dispatch();
    }

    /// INSTANCE
    private var nativeContext : Dynamic; 

    public var onContextSizeChanged : Signal0;
    public var contextWidth : Int;
    public var contextHeight : Int;

    private function new(params : GLContextParameters) : Void
    {
    	onContextSizeChanged = new Signal0();
    }

    public function bind() : Void
    {

    }

    public function destroy() : Void
    {

    }
}