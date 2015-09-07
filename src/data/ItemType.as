/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 24.01.13
 * Time: 16:51
 * To change this template use File | Settings | File Templates.
 */
package data {
	public class ItemType {
		static public const TEXT:int = 1;
		static public const TEXT_PROTECTED:int = 2;
		static public const FILE:int = 16;
		static public const FILE_PROTECTED:int = 32;
		static public function isValid(type:int):Boolean{
			switch(type){
				case TEXT:
				case FILE:
				case TEXT_PROTECTED:
				case FILE_PROTECTED:
					return true;
				default:
					return false;
			}
		}
		static public function isProtected(type:int):Boolean{
			return type==TEXT_PROTECTED || type==FILE_PROTECTED;
		}
		static public function isText(type:int):Boolean{
			return type==TEXT || type==TEXT_PROTECTED;
		}
		static public function isFile(type:int):Boolean{
			return type==FILE || type==FILE_PROTECTED;
		}
	}
}
