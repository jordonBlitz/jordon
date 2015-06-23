<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Issue\Revision
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Sunday, August 03, 2014, 06:52 PM GMT+2 mknox
 * @edited      $Date: 2014-08-04 01:35:29 +0200 (Mon, 04 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Revision.php 47 2014-08-03 23:35:29Z bizlogic $
*/

class Jordon_Project_Issue_Revision extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issue_revision';
	}

	/**
	 * Get latest revision of an issue
	 * by UUID
	 *
	 * @param	int		$uuid
	 * @return	array
	*/
	public function getLatestRevisionByUUID( $uuid )
	{
		$data = array();
	
		$this->_db->where( 'uuid', $uuid );
		$this->_db->orderBy( 'id', 'DESC' );
		return $this->_db->getOne( $this->_tableName );
	}
	
	/**
	 * Get latest Revision UUID by
	 * by UUID
	 *
	 * @param	int		$uuid
	 * @return	string
	*/
	public function getLatestRevisionUUIDByUUID( $uuid )
	{
		$data = array();
	
		$this->_db->where( 'uuid', $uuid );
		$this->_db->orderBy( 'id', 'DESC' );
		$data = $this->_db->getOne( $this->_tableName );
		
		if( !empty( $data ) ) {
			return $data['revision_uuid'];	
		}
	}
	
	/**
	 * Get latest revision of an issue 
	 * by Project ID & Issue ID
	 *
	 * @param	int		$projectId
	 * @param	int		$issueId
	 * @return	array
	*/
	public function getLatestRevision( $projectId, $issueId )
	{
		$args = array_map_recursive( 'typeCastToInteger', func_get_args() );
		$data = array();
	
		$this->_db->where( 'project_id', $args[0] );
		$this->_db->where( 'project_issue_id', $args[1] );
		$this->_db->orderBy( 'id', 'DESC' );
		
		return $this->_db->getOne( $this->_tableName );
	}
	
	/**
	 * Get last issue ID
	 * by Project ID
	 *
	 * @param	int		$projectId
	 * @return	Int
	*/
	public function getLastIssueIdByProjectId( $projectId )
	{	
		$this->_db->where( 'project_id', (int)$projectId );
		$this->_db->orderBy( 'project_issue_id', 'DESC' );
		$data = $this->_db->getOne( $this->_tableName );
		
		if( !empty( $data ) ) {
			return $data['project_issue_id'];	
		}
	}
	
	/**
	 * Get by Revision UUID
	 *
	 * @param	string	$uuid
	 * @return	array
	*/
	public function getByRevisionUUID( $uuid )
	{
		$data = array();
	
		$this->_db->where( 'revision_uuid', $uuid );
		return $this->_db->getOne( $this->_tableName );
	}
}