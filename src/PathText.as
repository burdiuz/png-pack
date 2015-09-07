/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 19:53
 * To change this template use File | Settings | File Templates.
 */
package {
	import spark.components.TextInput;
	public class PathText extends TextInput{
		public function PathText():void{
			super();
			this.editable = false;
		}
		override public function set text(value:String):void{
			super.text = value;
			const length:int = value.length;
			this.textDisplay.scrollToRange(length, length);
		}
	}
}
