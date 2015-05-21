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

import duell.build.objects.Configuration;

 import duell.objects.DuellLib;
 import duell.helpers.TemplateHelper;

 import sys.io.Process;

 import haxe.io.Path;

class LibraryBuild
{
    public function new ()
    {
    }

	public function postParse() : Void
	{
		/// if no parsing is made we need to add the default state.
		if (Configuration.getData().LIBRARY.OPENGL == null)
		{
			Configuration.getData().LIBRARY.OPENGL = LibraryConfiguration.getData();
		}

		var haxeExtraSources = Path.join([Configuration.getData().OUTPUT,"haxe"]);
		if (Configuration.getData().SOURCES.indexOf(haxeExtraSources) == -1)
		{
			Configuration.getData().SOURCES.push(haxeExtraSources);
		}
	}

	public function preBuild() : Void
	{
        var libPath : String = DuellLib.getDuellLib("opengl").getPath();

        var exportPath : String = Path.join([Configuration.getData().OUTPUT,"haxe","gl"]);

        var classSourcePath : String = Path.join([libPath,"template","gl"]);

        TemplateHelper.recursiveCopyTemplatedFiles(classSourcePath, exportPath, Configuration.getData(), Configuration.getData().TEMPLATE_FUNCTIONS);
	}

	public function postBuild() : Void
	{
	}
}
