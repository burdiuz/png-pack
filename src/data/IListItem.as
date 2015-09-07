package data
{
	import flash.utils.ByteArray;

	/**
	 * IListItem.as
	 * @author: ${AUTHOR_NAME} on 29.01.13
	 */
	public interface IListItem
	{
		function get type():int;
		function get date():Date;
		function getData():ByteArray;
	}
}
