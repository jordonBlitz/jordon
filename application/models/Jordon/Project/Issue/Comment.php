<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Issue\Comment
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Sunday, July 27, 2014, 03:26 AM GMT+1 mknox
 * @edited      $Date: 2014-08-03 11:03:35 +0200 (Sun, 03 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Comment.php 36 2014-08-03 09:03:35Z bizlogic $
*/

class Jordon_Project_Issue_Comment extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issue_comment';
	}
	
	/**
	 * Get comments by project ID
	 *  
	 * @param 	int		$projectId
	 * @param 	int		$limit
	 * @param 	string	$sortBy
	 * @param	string 	$sortOrder
	 * @return	array
	*/
	public function getByProjectId( $projectId, $limit = SITE_COMMENT_FETCH_LIMIT, $sortBy = 'date', $sortOrder = 'DESC' )
	{
		$data	= array();
		
		$sql	= "SELECT c.* FROM `".DB_TABLE_PREFIX."project_issue_comment` c ";
		$sql   .= "INNER JOIN `".DB_TABLE_PREFIX."project_issue` i ON c.issue_id = i.id ";
		$sql   .= "WHERE i.project_id = ".(int)$projectId." ";
		$sql   .= "ORDER BY c.".$sortBy." ".$sortOrder." ";
		$sql   .= "LIMIT ".(int)$limit;
				
		$res = mysql_query( $sql ) OR die( mysql_error() );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
		
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;

		return $data;
	}
	
	/**
	 * Insert data
	 *
	 * @param	array	$data
	 * @return	int
	*/
	public function insert( $data = array() )
	{
		if( empty( $data ) ) {
			return false;
		}
		
		if( (int)@$_SESSION['user']['id'] > 0 ) {
			$data['author_id'] = (int)$_SESSION['user']['id'];
		}
		
		$data['uuid']	= uuid();
		$data['date']	= $this->_NOW;
		$data['ip']		= $_SERVER['REMOTE_ADDR'];
	
		$id = (int)$this->_db->insert( $this->_tableName, $data );
	
		if( $id > 0 ) {
			return $id;
		}
	}
}