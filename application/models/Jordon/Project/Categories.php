<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Categories
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Friday, July 25, 2014, 02:38 AM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_Project_Categories extends CloneUI_Db
{
	protected $_db;
	protected $_tableName;
	
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_categories';
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