
package data.bin{
	import flash.utils.ByteArray;

	public class BinUtils{
		static public function stringToByteArray(string:String):ByteArray{
			const byteArray:ByteArray = new ByteArray();
			byteArray.writeUTFBytes(string);
			return byteArray;
		}
		static public function xorByPassPhrase(byteArray:ByteArray, string:String):void{
			const pass:ByteArray = stringToByteArray(string);
			const passPast:int = pass.length-1;
			const length:int = byteArray.length;
			for(var index:int = 0, passIndex:int = 0; index<length; index++, passIndex++){
				if(passIndex>passPast) passIndex = 0;
				byteArray[index] ^= pass[passIndex];
			}
		}
	}
}