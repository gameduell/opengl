/**
 * @autor kgar
 * @date 05.09.2014.
 * @company Gameduell GmbH
 */
package duell.build.plugin.library.opengl;

import haxe.io.Path;

typedef KeyValueArray = Array<{NAME : String, VALUE : String}>;


typedef LibraryConfigurationData = {
	HTML5_WIDTH : Int,
	HTML5_HEIGHT : Int
}

class LibraryConfiguration
{
	public static var _configuration : LibraryConfigurationData = null;
	private static var _parsingDefines : Array<String> = ["opengl"];
	public static function getData() : LibraryConfigurationData
	{
		if (_configuration == null)
			initConfig();
		return _configuration;
	}

	public static function getConfigParsingDefines() : Array<String>
	{
		return _parsingDefines;
	}

	public static function addParsingDefine(str : String)
	{
		_parsingDefines.push(str);
	}

	private static function initConfig()
	{
		_configuration = 
		{
			HTML5_WIDTH : 1024,
			HTML5_HEIGHT : 768
		};
		trace(_configuration);

	}
}