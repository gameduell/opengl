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

package duell.build.plugin.library.opengl;

import duell.build.objects.DuellProjectXML;
import duell.build.objects.Configuration;

import duell.build.plugin.library.opengl.LibraryConfiguration;

import duell.helpers.XMLHelper;
import duell.helpers.LogHelper;

import haxe.xml.Fast;

class LibraryXMLParser
{
	public static function parse(xml : Fast) : Void
	{
		Configuration.getData().LIBRARY.OPENGL = LibraryConfiguration.getData();

		for (element in xml.elements)
		{
			if (!XMLHelper.isValidElement(element, DuellProjectXML.getConfig().parsingConditions))
				continue;

			switch(element.name)
			{
				case 'html5-window-size':
					parseHTML5WindowSizeElement(element);

				case 'html5-container-id':
					parseHTML5ContainerIDElement(element);

				case 'ios-show-splashscreen':
					parseIOSShowSplashScreenElement(element);
			}
		}
	}

	private static function parseHTML5WindowSizeElement(element : Fast)
	{
		if (element.has.width)
		{
			LibraryConfiguration.getData().HTML5_WIDTH = Std.parseInt(element.att.width);
		}
		if(element.has.height)
		{
		    LibraryConfiguration.getData().HTML5_HEIGHT = Std.parseInt(element.att.height);
		}
	}

	private static function parseHTML5ContainerIDElement(element : Fast)
	{
		if (element.has.name)
		{
			LibraryConfiguration.getData().HTML5_CONTAINER_ID = element.att.name;
		}
	}

	private static function parseIOSShowSplashScreenElement(element : Fast)
	{
		if (element.has.value)
		{
			LibraryConfiguration.getData().IOS_SHOW_SPLASHSCREEN = if (element.att.value == "true") true else false;
		}
	}

	/// HELPERS
	private static function addUniqueKeyValueToKeyValueArray(keyValueArray : KeyValueArray, key : String, value : String)
	{
		for (keyValuePair in keyValueArray)
		{
			if (keyValuePair.NAME == key)
			{
				LogHelper.println('Overriting key $key value ${keyValuePair.VALUE} with value $value');
				keyValuePair.VALUE = value;
			}
		}

		keyValueArray.push({NAME : key, VALUE : value});
	}

	private static function resolvePath(string : String) : String /// convenience method
	{
		return DuellProjectXML.getConfig().resolvePath(string);
	}
}
