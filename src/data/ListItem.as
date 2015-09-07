/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 24.01.13
 * Time: 16:50
 * To change this template use File | Settings | File Templates.
 */
package data {
	import flash.utils.ByteArray;

	[Bindable]
	public class ListItem {
		protected var _type:int;
		protected var _date:Date;
		public function ListItem(type:int):void{
			super();
			this._type = type;
		}
		public function get type():int{
			return this._type;
		}
		public function get date():Date{
			return this._date;
		}
		public function getData():ByteArray{
			return null;
		}
	}
}
