package data.bin{
	import data.bin.PNGFile;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class PNGUtil extends Object{
		static public function readFile(file:File):PNGFile{
			const stream:FileStream = new FileStream();
			stream.open(file, FileMode.READ);
			const bytes:ByteArray = new ByteArray();
			stream.readBytes(bytes, 0, stream.bytesAvailable);
			stream.close();
			return PNGFile.read(bytes);
		}
		static public function save(data:PNGFile):void{
		}
		static public function saveFile(file:File, data:PNGFile):void{
		}
	}
}