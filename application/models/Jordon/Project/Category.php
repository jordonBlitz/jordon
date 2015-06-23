<?php
/**
 * Jordon
 * Jordon\Project\Categories
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License
 *
 * @since       Friday, July 25, 2014, 02:38 AM GMT+1 mknox
 * @edited      $Date: 2014-08-03 02:43:56 +0200 (Sun, 03 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Category.php 34 2014-08-03 00:43:56Z bizlogic $
*/

class Jordon_Project_Category extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_category';
	}
	
	/**
	 * Get all records 
	 * 
	 * @param	array	$orderBy
	 * @param	int		$limit
	 * @return	array
	*/
	public function getAll( $orderBy = array( 'sort_order' => 'ASC', 'title' => 'ASC' ), $limit = 0 )
	{
		if( !empty( $orderBy ) ) {
			foreach( $orderBy AS $key => $value ) {
				$this->_db->orderBy( $key, $value );
			}	
		}
		
		$limit = (int)$limit;
		if( $limit > 0 ) {
			$projects = $this->_db->get( $this->_tableName, $limit );
		} else {
			$projects = $this->_db->get( $this->_tableName );
		}
		
		return $projects;	
	}	
}