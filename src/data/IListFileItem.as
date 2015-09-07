package data
{
	import flash.utils.ByteArray;

	/**
	 * IListFileItem.as
	 * @author: ${AUTHOR_NAME} on 29.01.13
	 */
	public interface IListFileItem extends IListItem
	{
		function get comment():String;
		function get attributes():FileAttributes;
		function getFileData():ByteArray;
	}
}
