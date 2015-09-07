/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 17:29
 * To change this template use File | Settings | File Templates.
 */
package events {
	import data.ListItem;

	import flash.events.Event;

	public class ItemEvent extends Event{
		static public const ITEM_ADD:String = "itemAdd";
		static public const ITEM_REMOVE:String = "itemRemove";
		private var _item:ListItem;
		public function ItemEvent(type:String, bubbles:Boolean=false, cancellable:Boolean=false, item:ListItem=null):void
		{
			super(type, bubbles, cancellable);
			_item = item;
		}
		public function get item():ListItem{
			return this._item;
		}
		override public function clone():Event{
			return new ItemEvent(this.type,  this.bubbles, this.cancelable, this._item);
		}
	}
}
