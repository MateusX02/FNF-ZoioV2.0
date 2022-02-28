package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSubState;
import extension.webview.WebView;

using StringTools;

class VideoState extends MusicBeatState
{
	public static var daPath:String = 'file:///';

	public var nextState:FlxState;

	public function new(source:String, toTrans:FlxState)
	{
		super();

		nextState = toTrans;

		// FlxG.autoPause = false;

		WebView.onClose = onClose;
		WebView.onURLChanging = onURLChanging;

		WebView.open(androidPath + source + '.html', false, null, ['http://exitme(.*)']);
	}

	public override function update(dt:Float)
	{
		for (touch in FlxG.touches.list)
			if (touch.justReleased)
				onClose();

		super.update(dt);
	}

	function onClose()
	{ // not working
		// FlxG.autoPause = true;
		trace('close!');
		trace(nextState);
		FlxG.switchState(nextState);
	}

	function onURLChanging(url:String)
	{
		if (url == 'http://exitme/')
			onClose(); // drity hack lol
		trace("WebView is about to open: " + url);
	}
}