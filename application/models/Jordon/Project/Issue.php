<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Issue
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Saturday, July 26, 2014, 05:14 PM GMT+1 mknox
 * @edited      $Date: 2014-08-07 04:36:13 +0200 (Thu, 07 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Issue.php 52 2014-08-07 02:36:13Z bizlogic $
*/

class Jordon_Project_Issue extends CloneUI_Db
{	
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issue';
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
				$Jordon_Project = new Jordon_Project;
				$project = $Jordon_Project->getById( $data['project_id'] );
				
				$Jordon_Project_Issue_Type = new Jordon_Project_Issue_Type;
				$type = $Jordon_Project_Issue_Type->getById( $data['type'] ); 
				
				$Jordon_Project_Issue_Status = new Jordon_Project_Issue_Status;
				$status = $Jordon_Project_Issue_Status->getById( $data['status'] );
				
				$Jordon_Project_Issue_Priority = new Jordon_Project_Issue_Priority;
				$priority = $Jordon_Project_Issue_Priority->getById( $data['priority'] );
				
				$Jordon_Project_Issue_State = new Jordon_Project_Issue_State;
				$state = $Jordon_Project_Issue_State->getById( $data['state'] );
				
				$Jordon_Project_Issue_Resolution = new Jordon_Project_Issue_Resolution;
				$resolution = $Jordon_Project_Issue_Resolution->getById( $data['resolution'] );
				
				$CloneUI_User = new CloneUI_User;
				$reporter = $CloneUI_User->getById( $data['reporter'] );
				if( !empty( $reporter ) ) {
					unset( $reporter['password'] );	
				}
				
				if( (int)$data['assignee'] > 0 ) {
					$assignee = $CloneUI_User->getById( $data['assignee'] ); 
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
	 * Get by Project ID & 
	 * Issue ID
	 *
	 * @param	int		$projectid
	 * @param	int		$issueId
	 * @param	boolean	$withMetadata
	 * @return	array
	*/
	public function getByProjectIdAndIssueId( $projectId, $issueId, $withMetadata = false )
	{
		// get in use revision
		$data = $this->getInUseRevision( $projectId, $issueId );
	
		if( $withMetadata ) {
			if( !empty( $data ) ) {
				$Jordon_Project = new Jordon_Project;
				$project = $Jordon_Project->getById( $data['project_id'] );
	
				$Jordon_Project_Issue_Type = new Jordon_Project_Issue_Type;
				$type = $Jordon_Project_Issue_Type->getById( $data['type'] );
	
				$Jordon_Project_Issue_Status = new Jordon_Project_Issue_Status;
				$status = $Jordon_Project_Issue_Status->getById( $data['status'] );
	
				$Jordon_Project_Issue_Priority = new Jordon_Project_Issue_Priority;
				$priority = $Jordon_Project_Issue_Priority->getById( $data['priority'] );
	
				$Jordon_Project_Issue_State = new Jordon_Project_Issue_State;
				$state = $Jordon_Project_Issue_State->getById( $data['state'] );
	
				$Jordon_Project_Issue_Resolution = new Jordon_Project_Issue_Resolution;
				$resolution = $Jordon_Project_Issue_Resolution->getById( $data['resolution'] );
	
				$CloneUI_User = new CloneUI_User;
				$reporter = $CloneUI_User->getById( $data['reporter'] );
				if( !empty( $reporter ) ) {
					unset( $reporter['password'] );
				}
	
				if( (int)$data['assignee'] > 0 ) {
					$assignee = $CloneUI_User->getById( $data['assignee'] );
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
	 * Get by Columns & Values
	 *
	 * @param	array	$attributes
	 * @param	int		$limit
	 * @param	int		$offset
	 * @param	array	$orderBy
	 * @param	boolean	$returnOriginal
	 * @return	array
	*/	
	public function getBy( $attributes = array(), $limit = 1, $offset = null, $orderBy = array( 'date_created' => 'DESC', 'date_updated' => 'DESC' ), $returnOriginal = false )
	{
		if( empty( $attributes ) ) {
			return false;	
		}
		
		// escape
		$attributes = array_map_recursive( 'mysql_real_escape_string', $attributes );
		
		$i 			= 0;
		$count		= count( $attributes );
		
		$query = "SELECT * FROM `".mysql_real_escape_string( DB_TABLE_PREFIX.$this->_tableName )."` ";
		$query .= "WHERE ";
		foreach( $attributes AS $key => $value ) {
			$i++;
			$query .= "`".$key."` = '".$value."' ";
			if( $i < $count ) {
				$query .= " AND ";	
			}
		}
		
		if( !empty( $orderBy ) ) {
			$count 	= count( $orderBy );
			$i		= 0;
				
			$query .= "ORDER BY ";
			foreach( $orderBy AS $orderKey => $orderValue ) {
				$i++;
				$query .= "`".mysql_real_escape_string( $orderKey )."` ".mysql_real_escape_string( $orderValue )." ";
		
				if( $i < $count ) {
					$query .= ", ";
				}
			}
		}
		
		$limit	= (int)$limit;
		$offset = (int)$offset;
		$data	= array();
		
		if( ( $limit > 0 ) AND ( $offset >= 0 ) ) {
			$query .= "LIMIT ".$offset.", ".$limit;
		} elseif ( $limit == 1 ) {
			$query .= "LIMIT 1 ";
		}
		
		$res = mysql_query( $query ) OR die( mysql_error()."\nSQL: ".$sql."\nLine:  ".__LINE__."\nFile:  ".__FILE__  );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;	
			}	
		}
		
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;
		
		if( !empty( $data ) ) {
			$Jordon_Project_Issue_Priority	= new Jordon_Project_Issue_Priority;
			$Jordon_Project_Issue_Status	= new Jordon_Project_Issue_Status;
			
			if( $limit == 1 ) {
				if( !$returnOriginal ) {
					// get latest revision
					$data = $this->getLatestRevisionByUUID( $data['uuid'] );

					$priority = $Jordon_Project_Issue_Priority->getById( $data['priority'] );
					$data['priority_name'] = ( strlen( $priority['name'] ) ) ? $priority['name'] : '';
					
					$status = $Jordon_Project_Issue_Status->getById( $data['status'] );
					$data['status_name'] = ( strlen( $status['name'] ) ) ? $status['name'] : '';
				}				
			} else {
				if( !$returnOriginal ) {
					// get latest revision
					foreach( $data AS $key => $value ) {
						$data[$key] = $this->getLatestRevisionByUUID( $value['uuid'] );
					}
					
					// process
					foreach( $data AS $key => $value ) {
						$priority = $Jordon_Project_Issue_Priority->getById( $value['priority'] );
						$data[$key]['priority_name'] = ( strlen( $priority['name'] ) ) ? $priority['name'] : '';
					
						$status = $Jordon_Project_Issue_Status->getById( $value['status'] );
						$data[$key]['status_name'] = ( strlen( $status['name'] ) ) ? $status['name'] : '';
					}
				}	
			}
		}

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
		
		// get last record for this project
		$Jordon_Project_Issue_Revision = new Jordon_Project_Issue_Revision();
		$lastRecordId = (int)$Jordon_Project_Issue_Revision->getLastIssueIdByProjectId( $data['project_id'] );
				
		$data['uuid']				= uuid();
		$data['revision']			= 1;
		$data['revision_uuid']		= uuid();
		$data['reporter']			= (int)@$_SESSION['user']['id'];
		$data['revised_by']			= $data['reporter'];
		$data['date_created']		= time();
		$data['project_issue_id']	= ( $lastRecordId > 0 ) ? ( $lastRecordId + 1 ) : 1;
		$data['state']				= SITE_DEFAULT_ISSUE_STATE;
		$data['status']				= SITE_DEFAULT_ISSUE_STATUS;
		$data['resolution']			= SITE_DEFAULT_ISSUE_RESOLUTION;
		$data['ip']					= $_SERVER['REMOTE_ADDR'];
		
		// insert revision
		$revisionId = (int)$Jordon_Project_Issue_Revision->insert( $data );
		if( $revisionId > 0 ) {
			$columns = fetchColumnNames( DB_TABLE_PREFIX.'project_issue' );
			$columns = array_flip( $columns );
			
			// unset ID column, as it is auto-incremented
			unset( $columns['id'] );
			
			$intersect = array_intersect_key( $columns, $data );
			if( !empty( $intersect ) ) {
				$intersect = array_intersect_key( $data, $intersect );		
			} else {
				// error; delete the revision
				$Jordon_Project_Issue_Revision->deleteById( $revisionId );
				return false;
			}

			// insert into 'project_issue' table
			try {
				$id = (int)$this->_db->insert( $this->_tableName, $intersect );
			} catch (Exception $e) {
				// delete revision; insert failed	
				$Jordon_Project_Issue_Revision->deleteById( $revisionId );
				return false;
			}
			
			if( $id > 0 ) {
				// record was successfully inserted...
				return $id;
			} else {
				// delete revision; insert failed	
				$Jordon_Project_Issue_Revision->deleteById( $revisionId );
				return false;
			}
		}
	}
	
	/**
	 * Get records created within a 
	 * specific date range
	 *
	 * @param	int		$projectid
	 * @param	int		$startDate
	 * @param	int 	$endDate
	 * @return	array
	*/	
	public function getCreatedByDateRange( $projectId, $startDate, $endDate )
	{
		$args = array_map_recursive( 'typeCastToInteger', func_get_args() );
		$data = array();
		
		$sql = "SELECT * FROM ";
		$sql .= "`".DB_TABLE_PREFIX.$this->_tableName."` ";
		$sql .= "WHERE `date_created` >= ".$args[1]." ";
		$sql .= "AND `date_created` <= ".$args[2]." ";
		$sql .= "ORDER BY `date_created` ASC ";
		
        $res = mysql_query( $sql ) OR die( mysql_error()."\nSQL: ".$sql."\nLine:  ".__LINE__."\nFile:  ".__FILE__  );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}

		return $data;
	}
	
	/**
	 * Get records resolved within a
	 * specific date range
	 * 
	 * @param	int		$projectid
	 * @param	int		$startDate
	 * @param	int 	$endDate
	 * @return	array
	*/
	public function getResolvedByDateRange( $projectId, $startDate, $endDate )
	{
		$args = array_map_recursive( 'typeCastToInteger', func_get_args() );
		$data = array(); 
		
		$sql = "SELECT r.*, max(r.date_revision) AS revision_date ";
    	$sql .= "FROM `".DB_TABLE_PREFIX."project_issue_revision` r ";
    	$sql .= "INNER JOIN `".DB_TABLE_PREFIX."project_issue` i on r.uuid = i.uuid ";
    	$sql .= "WHERE r.resolution = ".(int)SITE_ISSUE_RESOLUTION_ID." ";
    	$sql .= "AND r.project_id = ".$args[0]." ";
    	$sql .= "AND r.date_resolved >= ".$args[1]." ";
    	$sql .= "AND r.date_resolved <= ".$args[2]." ";
    	$sql .= "GROUP BY r.uuid ORDER BY r.date_resolved DESC ";
		
		$res = mysql_query( $sql ) OR die( mysql_error()."\nSQL: ".$sql."\nLine:  ".__LINE__."\nFile:  ".__FILE__  );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
		
		return $data;
	}
	
	/**
	 * Get in-use revision
	 *
	 * @param	int		$projectId
	 * @param	int		$issueId
	 * @return	array
	*/
	public function getInUseRevision( $projectId, $issueId )
	{
		$args = array_map_recursive( 'typeCastToInteger', func_get_args() );
		$data = array(); 
		
		$sql = "SELECT r.* ";
    	$sql .= "FROM `".DB_TABLE_PREFIX."project_issue_revision` r ";
    	$sql .= "INNER JOIN `".DB_TABLE_PREFIX."project_issue` i on r.revision_uuid = i.revision_uuid ";
    	$sql .= "WHERE i.project_id = ".$args[0]." ";
    	$sql .= "AND i.project_issue_id = ".$args[1]." ";
    	$sql .= "LIMIT 1";
		
		$res = mysql_query( $sql ) OR die( mysql_error()."\nSQL: ".$sql."\nLine:  ".__LINE__."\nFile:  ".__FILE__  );
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );
		}
		
		return $data;
	}
	
	/**
	 * Get latest revision of an issue
	 *  
	 * @param	int		$projectId
	 * @param	int		$issueId
	 * @return	array
	*/
	public function getLatestRevision( $projectId, $issueId )
	{
		$Jordon_Project_Issue_Revision = new Jordon_Project_Issue_Revision;
		return $Jordon_Project_Issue_Revision->getLatestRevision( $projectId, $issueId );
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
		$Jordon_Project_Issue_Revision = new Jordon_Project_Issue_Revision;
		return $Jordon_Project_Issue_Revision->getLatestRevisionByUUID( $uuid );
	}
	
	/**
	 * Update by UUID
	 *
	 * @param	string	$uuid
	 * @param	$data	array
	 * @return	boolean
	*/
	public function update( $uuid, $data = array() )
	{
		if( empty( $data ) ) {
			return false;
		}
		
		// get in-use revision
		$revisionUUID = $this->getRevisionUUIDByUUID( $uuid );
		$Jordon_Project_Issue_Revision = new Jordon_Project_Issue_Revision();
		$inUseRevision = $Jordon_Project_Issue_Revision->getByRevisionUUID( $revisionUUID );
				
		if( !empty( $inUseRevision ) ) {
			// compare
			$dontCheck = array('date_updated', 'date_revision', 'ip');
			$dataCheck = array();
			foreach( $data AS $key => $value ) {
				if( !in_array( $key, $dontCheck ) ) {
					$dataCheck[$key] = $value; 	
				}	
			}
			
			foreach( $inUseRevision AS $key => $value ) {
				if( !in_array( $key, $dontCheck ) ) {
					$inUseRevision[$key] = $value;
				} else {
					unset( $inUseRevision[$key] );	
				}
			}

			// diff
			$diff = array_diff_assoc( $dataCheck, $inUseRevision );
						
			if( empty( $diff ) ) {
				// no change
				return false;	
			}
			
			// merge
			$data = array_merge( $inUseRevision, $data );
			
			// increment the revision
			$lastRevision = $Jordon_Project_Issue_Revision->getLatestRevisionByUUID( $uuid );
			if( !empty( $lastRevision ) ) {
				$data['revision'] = ( $lastRevision['revision'] + 1 );				
			} else {
				$data['revision'] = 1;				
			}

		} else {
			$data['revision'] = 1;
		}
		
		// remove id
		unset( $data['id'] );
		
		// unset
		unset( $data['revision_date'] );
		
		// assignee
		if( isset( $data['assignee'] ) ) {
			if( !isset( $data['status'] ) ) {
				if( (int)$data['assignee'] <= 0 ) {
					// unassigned
					$data['status'] = (int)SITE_ISSUE_STATUS_UNASSIGNED_ID;	
				} else {
					// assigned
					$data['status'] = (int)SITE_ISSUE_STATUS_ASSIGNED_ID;			
				}	
			}
		}
		
		$data['revised_by']		= (int)$_SESSION['user']['id'];
		$data['revision_uuid']	= uuid();
		$data['date_updated']	= $this->_NOW;
		$data['ip']				= $_SERVER['REMOTE_ADDR'];
			
		$result = $Jordon_Project_Issue_Revision->insert( $data );
		if( (int)$result > 0 ) {
			// update parent table data
			return $this->setByUUID( 
					$uuid, 
					array( 
						'date_updated'	=> $data['date_updated'],
						'revision_uuid'	=> $data['revision_uuid'] 
					) 
			);
		}		
	}
	
	/**
	 * Get ID by Project Issue ID
	 *
	 * @param	int		$projectIssueId
	 * @return	int
	*/
	public function getIdByProjectIssueId( $projectIssueId )
	{
		$this->_db->where( 'project_issue_id', (int)$projectIssueId );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $data['id'];
		}
	}
	
	/**
	 * Get Revision UUID by ID
	 *
	 * @param	int		$id
	 * @return	string
	*/
	public function getRevisionUUIDById( $id )
	{
		$this->_db->where( 'id', (int)$id );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $data['revision_uuid'];
		}
	}
	
	/**
	 * Get Revision UUID by UUID
	 * 
	 * @param	string	$uuid	UUID of the entry; not the revision 
	 * @return	string
	*/
	public function getRevisionUUIDByUUID( $uuid )
	{
		$this->_db->where( 'uuid', $uuid );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $data['revision_uuid'];
		}
	}
	
	/**
	 * Get in-use revision 
	 * by ID
	 *
	 * @param	int		$id
	 * @return	array
	*/
	public function getInUseRevisionById( $id )
	{
		$data = array();
	
		$this->_db->where( 'id', (int)$id );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $this->getInUseRevision( $data['project_id'], $data['project_issue_id'] );
		}
	}
	
	/**
	 * Get in-use revision
	 * by UUID
	 *
	 * @param	string	$uuid
	 * @return	array
	*/
	public function getInUseRevisionByUUID( $uuid )
	{
		$data = array();
	
		$this->_db->where( 'uuid', $uuid );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $this->getInUseRevision( $data['project_id'], $data['project_issue_id'] );
		}
	}
	
	/**
	 * Get Project ID by UUID
	 *
	 * @param	string	$uuid
	 * @return	string
	*/
	public function getProjectIdByUUID( $uuid )
	{
		$this->_db->where( 'uuid', $uuid );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $data['project_id'];
		}
	}
	
	/**
	 * Count issues by state
	 * 
	 * @param	int		$projectId
	 * @return	array
	*/
	public function getCountByState( $projectId )
	{
		$data = array();
		
		// get the latest revision, grouped by issue state
		$sql = "SELECT r.state, ";
		$sql .= "COUNT( r.uuid ) AS count, ";
		$sql .= "max(r.date_revision) AS tmp_revision_date ";
		$sql .= "FROM `".DB_TABLE_PREFIX."project_issue_revision` r ";
		$sql .= "INNER JOIN `".DB_TABLE_PREFIX."project_issue` i ON ";
		$sql .= "r.revision_uuid = i.revision_uuid ";
		$sql .= "WHERE r.project_id = ? ";
		$sql .= "GROUP BY r.state ";
		
		$params = array( (int)$projectId );
		return $this->_db->rawQuery( $sql, $params );
	}
	
	/**
	 * Get state summary
	 *
	 * @param	int		$projectId
	 * @return	array
	 */
	public function getStateSummary( $projectId )
	{
		$data = $this->getCountByState( $projectId );
		
		if( !empty( $data ) ) {
			$Jordon_Project_Issue_State = new Jordon_Project_Issue_State;
			$totalCount = array_sum( array_column( $data, 'count' ) );
			
			foreach( $data AS $key => $value ) {
				$data[$key]['name']			= translate( $Jordon_Project_Issue_State->getNameById( $value['state'] ) );
				$data[$key]['percentage']	= getPercentage( $value['count'], $totalCount );
			}
		}

		return $data;
	}
}