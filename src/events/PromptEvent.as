/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 16:10
 * To change this template use File | Settings | File Templates.
 */
package events {
	import flash.events.Event;

	public class PromptEvent  extends Event{
		static public const PROMPT_RECEIVED:String = "promptReceived";
		private var _prompt:String;
		public function PromptEvent(type:String,  bubbles:Boolean=false,cancelable:Boolean=false, prompt:String=null):void{
			super(type,  bubbles, cancelable);
			_prompt = prompt;
		}
		public function get prompt():String
		{
			return this._prompt;
		}
		override public function clone():Event{
			return new PromptEvent(this.type,  this.bubbles, this.cancelable, this._prompt);
		}
	}
}
