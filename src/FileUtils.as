/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 28.01.13
 * Time: 13:45
 * To change this template use File | Settings | File Templates.
 */
package {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.ByteArray;

	public class FileUtils {
		static public function read(file:File):ByteArray{
			const stream:FileStream = new FileStream();
			stream.open(file, FileMode.READ);
			const bytes:ByteArray =  new ByteArray();
			stream.readBytes(bytes, 0, stream.bytesAvailable);
			stream.close();
			return bytes;
		}
		static public function write(bytes:ByteArray, file:File):void{
			const stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeBytes(bytes, 0, bytes.length);
			stream.close();
		}
	}
}
