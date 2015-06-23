<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Issues
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Saturday, July 26, 2014, 05:14 PM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_Project_Issues extends CloneUI_Db
{
	protected $_db;
	protected $_tableName;
	
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issues';
	}
	
	/**
	 * Get by ID
	 *
	 * @param	int		$id
	 * @param	boolean	$withMetadata
	 * @return	array
	*/
	public function getById( $id, $withMetadata = false )
	{
		$id = (int)$id;
		$this->_db->where( 'id', $id );
		$data = $this->_db->getOne( $this->_tableName );
		
		if( $withMetadata ) {
			if( !empty( $data ) ) {
				$Jordon_Projects = new Jordon_Projects;
				$project = $Jordon_Projects->getById( $data['project_id'] );
				
				$Jordon_Issue_Type = new Jordon_Issue_Type;
				$type = $Jordon_Issue_Type->getById( $data['type'] ); 
				
				$Jordon_Issue_Status = new Jordon_Issue_Status;
				$status = $Jordon_Issue_Status->getById( $data['status'] );
				
				$Jordon_Issue_Priority = new Jordon_Issue_Priority;
				$priority = $Jordon_Issue_Priority->getById( $data['priority'] );
				
				$Jordon_Issue_State = new Jordon_Issue_State;
				$state = $Jordon_Issue_State->getById( $data['state'] );
				
				$Jordon_Issue_Resolution = new Jordon_Issue_Resolution;
				$resolution = $Jordon_Issue_Resolution->getById( $data['resolution'] );
				
				$CloneUI_Users = new CloneUI_Users;
				$reporter = $CloneUI_Users->getById( $data['reporter'] );
				if( !empty( $reporter ) ) {
					unset( $reporter['password'] );	
				}
				
				if( (int)$data['assignee'] > 0 ) {
					$assignee = $CloneUI_Users->getById( $data['assignee'] ); 
					if( !empty( $assignee ) ) {
						unset( $assignee['password'] );
					}	
				} else {
					$assignee = array();	
				}
				
				$data['metadata']							= array();
				$data['metadata']['issue']					= array();
				$data['metadata']['issue']['type']			= $type;
				$data['metadata']['issue']['status']		= $status;
				$data['metadata']['issue']['priority']		= $priority;
				$data['metadata']['issue']['state']			= $state;
				$data['metadata']['issue']['resolution']	= $resolution;
				$data['metadata']['issue']['reporter']		= $reporter;
				$data['metadata']['issue']['assignee']		= $assignee;
				$data['metadata']['project']				= $project; 	
			}	
		}
	
		return $data;
	}
	
	/**
	 * Get by Column & Value
	 *
	 * @param	string	$column
	 * @param	mixed	$value
	 * @param	int		$limit
	 * @param	array	$orderBy
	 * @return	array
	*/	
	public function getBy( $column, $value, $limit = 1, $orderBy = array( 'date_created' => 'DESC', 'date_updated' => 'DESC' ) )
	{
		$limit = (int)$limit;
		
		if( !empty( $orderBy ) ) {
			foreach( $orderBy AS $orderKey => $orderValue ) {
				$this->_db->orderBy( $orderKey, $orderValue );
			}
		}
		
		$this->_db->where( $column, $value );
		if( $limit > 0 ) {
			$data = $this->_db->get( $this->_tableName, $limit );
		} else {
			$data = $this->_db->get( $this->_tableName );
		}
		
		if( !empty( $data ) ) {
			
			$Jordon_Issue_Priority	= new Jordon_Issue_Priority;
			$Jordon_Issue_Status	= new Jordon_Issue_Status;
			
			foreach( $data AS $key => $value ) {
				$priority = $Jordon_Issue_Priority->getById( $value['priority'] );
				$data[$key]['priority_name'] = ( strlen( $priority['name'] ) ) ? $priority['name'] : '';
				
				$status = $Jordon_Issue_Status->getById( $value['status'] );
				$data[$key]['status_name'] = ( strlen( $status['name'] ) ) ? $status['name'] : '';
			}
		}
		
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data; 

		return $data;
	}	
}