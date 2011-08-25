package org.jr.comp.ace
{	
	/**
	 * author: Jonathan Rowny (jrowny.com)
	 * created: 8/24/2011
	 * description: This is the main class for the Ace component, a code editor written in javascript.
	 */
	
	
	import flash.events.Event;	
	import mx.controls.HTML;	
	import spark.components.supportClasses.SkinnableComponent;
	
	public class Ace extends SkinnableComponent
	{
		[SkinPart(required="true")]
		public var htmlComp:HTML;
		
		private var _theme:String = AceThemes.TEXTMATE;
		private var _text:String = "";
		private var _tabSize:int = 2;
		private var _useSoftTabs:Boolean = true;
		private var _wrapMode:String = "80";
		private var _mode:String = AceModes.JAVASCRIPT;
		private var _readOnly:Boolean = false;
		private var _fontSize:Number = 12; //TODO: make into CSS style
		private var _highlightActiveLine:Boolean = true;
		private var _showGutter:Boolean = true;
		
		private var _domReady:Boolean = false;
		
		
		/**
		 * Accessor function returns a reference to the browser window	
		 *
		 * @return Reference to browswer window, HTML Object
		 */		
		private function get window():Object{
			//pure laziness
			return htmlComp.htmlLoader.window;
		}
		
		/**
		 * Handles event when the HTML component is completey done loading (after DOM ready and scripts execute)
		 * 
		 * @param event The complete event
		 * 
		 */
		private function onLoaded(event:Event):void{
			_domReady = true;
			//Set initial properties
			window.setShowGutter(_showGutter);
			window.setContent(_text);
			window.setTheme(_theme);
			window.setTabSize(_tabSize);
			window.setUseSoftTabs(_useSoftTabs);
			window.setFontSize(_fontSize);
			window.setWrapMode(_wrapMode);
			window.setHighlightActiveLine(_highlightActiveLine);
			window.setReadOnly(_readOnly);
			window.setMode(_mode);			
			//Add listener to editor
			window.editor.getSession().on('change', onTextChange);
		}
		
		/**
		 * Handles text change event.
		 * 
		 * @param event The event dispatched by javascript when the text changes
		 */
		private function onTextChange(event:Object):void{
			_text = window.getContent();
			dispatchEvent(new Event("textChange"));
		} 
		
		
		
		/**
		 * @private 
		 */
		public function get theme():String
		{
			return _theme;
		}
		
		[Inspectable(defaultValue="textmate", type="String", enumeration="clouds,clouds_midnight,cobalt,crimson_editor,dawn,eclipse,idle_fingers,kr_theme,merbivore_soft,merbivore,mono_industrial,monokai,pastel_on_dark,solarized_dark,solarized_light,textmate,twilight,vibrant_ink")]
		public function set theme(value:String):void
		{
			if(value!=_theme){
				_theme = value;
				_themeChanged=true;
				invalidateProperties();
			}
		}

		
		
		/**
		 * @private 
		 */
		public function get tabSize():int
		{
			return _tabSize;
		}

		public function set tabSize(value:int):void
		{
			if(value!=_tabSize){
				_tabSize = value;
				_tabSizeChanged=true;
				invalidateProperties();
			}
		}

		
		/**
		 * @private 
		 */
		public function get useSoftTabs():Boolean
		{
			return _useSoftTabs;
		}
		
		/**
		 * When useSoftTabs is true, spaces are used instead of the tab character.
		 * 
		 * @param True/False
		 * 
		 * @see tabSize
		 */
		public function set useSoftTabs(value:Boolean):void
		{
			if(_useSoftTabs!=value){
				_useSoftTabsChanged=true;
				_useSoftTabs = value;
				invalidateProperties();
			}
		}
		
		/**
		 * @private 
		 */
		public function get wrapMode():String
		{
			return _wrapMode;
		}

		/**
		 * Set the wrap mode to a number (int), "free", or "off." The default is 80. 
		 * 
		 * @param value Set wrap mode. Valid values: Integer, "free", or "off". Default: 80
		 */
		public function set wrapMode(value:String):void
		{
			if(_wrapMode!=value){
				_wrapMode = value;
				_wrapModeChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * @private 
		 */
		public function get mode():String
		{
			return _mode;
		}
		
		/**
		 * Code editing mode.  
		 * 
		 * @param value Set mode to any mode supported by ACE.
		 */
		[Inspectable(defaultValue="javascript", type="String", enumeration="c_cpp,clojure,coffee,csharp,css,groovy,html,java,javascript,json,lua,markdown,ocaml,perl,php,python,ruby,scad,scala,scss,svg,textile,xml")]
		public function set mode(value:String):void
		{
			if(_mode!=value){
				_mode = value;
				_modeChanged=true;
				invalidateProperties();
			}
		}
		
		/**
		 * @private 
		 */
		public function get readOnly():Boolean
		{
			return _readOnly;
		}

		public function set readOnly(value:Boolean):void
		{
			if(_readOnly!=value){
				_readOnly = value;
				_readOnlyChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * @private 
		 */
		public function get fontSize():Number
		{
			return _fontSize;
		}

		public function set fontSize(value:Number):void
		{
			if(_fontSize!=value){
				_fontSize = value;
				_fontSizeChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * @private 
		 */
		public function get highlightActiveLine():Boolean
		{
			return _highlightActiveLine;
		}
		
		/**
		 * Whether or not to highlight the active line. Defualt is true.
		 * 
		 * @param value True/False
		 */
		public function set highlightActiveLine(value:Boolean):void
		{
			if(_highlightActiveLine!=value){
				_highlightActiveLine = value;
				_highlightActiveLineChanged = true;
				invalidateProperties();
			}
		}
		
		/**
		 * @private 
		 */
		public function get showGutter():Boolean
		{
			return _showGutter;
		}

		/**
		 * Whether or not to show the "gutter." The area to the left of the code with line numbers.
		 * 
		 * @param value True/False
		 */
		public function set showGutter(value:Boolean):void
		{
			if(_showGutter!=value){
				_showGutterChanged = true;
				_showGutter = value;
				invalidateProperties();
			}
		}
		
		/**
		 * @private 
		 */
		[Bindable(event="textChange")]
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			if( _text !== value)
			{
				_text = value;
				_textChanged=true;
				invalidateProperties();
				dispatchEvent(new Event("textChange"));
			}
		}

		/**
		 * Override partAdded(partName:String, instance:Object) to add the "complete" event listner for the html component.
		 * 
		 * @see onLoaded
		 */
		override protected function partAdded(partName:String, instance:Object):void{
			if(instance == htmlComp){
				htmlComp.addEventListener(Event.COMPLETE,onLoaded);
			}
		}
		/**
		 * Vars used to track changes to properties and whether they need to be comitted
		 */
		private var _themeChanged:Boolean = false;
		private var _tabSizeChanged:Boolean = false;
		private var _useSoftTabsChanged:Boolean = false;
		private var _wrapModeChanged:Boolean = false;
		private var _modeChanged:Boolean = false;
		private var _readOnlyChanged:Boolean = false;
		private var _fontSizeChanged:Boolean = false;
		private var _highlightActiveLineChanged:Boolean = false;
		private var _showGutterChanged:Boolean = false;
		private var _textChanged:Boolean = false;
		
		/**
		 * Override the commit properties function, if the dom is ready this will change the properties of the editor.
		 */
		override protected function commitProperties():void{
			super.commitProperties();
			if(_domReady){
				if(_textChanged){
					_textChanged = false;
					window.setContent(_text);
				}
				if(_themeChanged){
					_themeChanged = false;
					window.setTheme(_theme);
				}
				if(_tabSizeChanged){
					_tabSizeChanged = false;
					window.setTabSize(_tabSize);
				}
				if(_useSoftTabsChanged){
					_useSoftTabsChanged = false;
					window.setUseSoftTabs(_useSoftTabs);
				}
				if(_fontSizeChanged){
					_fontSizeChanged = false;
					window.setFontSize(_fontSize);
				}
				if(_wrapModeChanged){
					_wrapModeChanged = false;
					window.setWrapMode(_wrapMode);
				}
				if(_modeChanged){
					_modeChanged = false;
					window.setMode(_mode);
				}
				if(_highlightActiveLineChanged){
					_highlightActiveLineChanged = false;
					window.setHighlightActiveLine(_highlightActiveLine);
				}
				if(_readOnlyChanged){
					_readOnlyChanged = false;
					window.setReadOnly(_readOnly);
				}
				if(_showGutterChanged){
					_showGutterChanged = false;
					window.setShowGutter(_showGutter);
				}
			}
		}
		
		/**
		 * Constructor method, attaches default skin
		 */
		public function Ace():void{
			super();
			setStyle("skinClass",AceSkin);
		}
	}
}