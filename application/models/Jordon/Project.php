<?php
/**
 * Jordon
 * Jordon\Project
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://jordonblitz.com
 * @license     GNU Affero General Public License
 *
 * @since       Thursday, July 24, 2014, 07:31 PM GMT+1 mknox
 * @edited      $Date: 2014-08-04 07:41:52 +0200 (Mon, 04 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Project.php 49 2014-08-04 05:41:52Z bizlogic $
 */

class Jordon_Project extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project';
	}
	
	/**
	 * Get Project Metadata by ID
	 *
	 * @param	int		$id
	 * @return	array
	*/	
	public function getMetadataById( $id )
	{
		$id			= (int)$id;
		$metadata 	= array();
		$project 	= $this->getById( $id );
		
		if( empty( $project ) ) {
			return $metadata;	
		}
		
		// init
		$CloneUI_User = new CloneUI_User;
		
		// Category
		$metadata['category']		= array();
		$metadata['category_id']	= array();
			
		// START:	Category Join
		$sql = "SELECT * FROM `".DB_TABLE_PREFIX."project_category` ";
		$sql .= "INNER JOIN `".DB_TABLE_PREFIX."project_category_rel` ";
		$sql .= "ON ".DB_TABLE_PREFIX."project_category.id = ";
		$sql .= DB_TABLE_PREFIX."project_category_rel.category_id ";
		$sql .= "AND ".DB_TABLE_PREFIX."project_category_rel.project_id = ";
		$sql .= mysql_real_escape_string( $id );

		$res = mysql_query( $sql ) OR die( mysql_error() );

		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$metadata['category'][]		= $row;
				$metadata['category_id'][] 	= $row['category_id'];
			}
		}
		// END:		Category Join

		// Project Lead
		$projectLead = (int)$project['lead'];
		if( $projectLead > 0 ) {
			$lead = $CloneUI_User->getById( $projectLead );
			if( !empty( $lead ) ) {
				unset( $lead['password'] );	
			}
			
			$metadata['lead_info'] = $lead;
		}
	
		// destroy
		unset( $CloneUI_User );

		// return
		return $metadata;
	}
	
	/**
	 * Get by Columns & Values
	 *
	 * @param	array	$attributes
	 * @param	int		$limit
	 * @param	int		$offset
	 * @param	array	$orderBy
	 * @param	boolean	$withMetadata
	 * @return	array
	*/	
	public function getBy( $attributes = array(), $limit = 1, $offset = 0, $orderBy = array(), $withMetadata = true )
	{
		if( empty( $attributes ) ) {
			return false;	
		}
		
		// escape
		$attributes = array_map_recursive( 'mysql_real_escape_string', $attributes );
		
		$i 			= 0;
		$count		= count( $attributes );
		
		$query = "SELECT * FROM ";
		$query .= "`".mysql_real_escape_string( DB_TABLE_PREFIX.$this->_tableName )."` ";
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
				$query .= "`".$orderKey."` ".$orderValue." ";
		
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
		
		$res = mysql_query( $query ) OR die( mysql_error() );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;	
			}	
		}
		
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;
		
		if( !empty( $data ) ) {
			if( $withMetadata ) {
				if( $limit > 1 ) {
					foreach( $data AS $key => $value ) {
						$data[$key]['metadata'] = $this->getMetadataById( $value['id'] );
					}
				} else {
					$data['metadata'] = $this->getMetadataById( $data['id'] );					
				}	
			}	
		}

		return $data;
	}
	
	/**
	 * Get all records
	 * 
	 * @param	boolean	$withMetadata
	 * @param	string	$orderBy
	 * @param	string	$sortOrder
	 * @return	array
	*/
	public function getAll( $withMetadata = true, $orderBy = 'title', $sortOrder = 'ASC' )
	{
		$this->_db->orderBy( $orderBy, $sortOrder );
		$projects = $this->_db->get( $this->_tableName );
		
		if( $withMetadata ) {
			if( !empty( $projects ) ) {
				foreach( $projects AS $key => $value ) {
					$projects[$key]['metadata'] = $this->getMetadataById( $value['id'] );	
				}
			}	
		}
		
		return $projects;	
	}	
	
	/**
	 * Get Active, Public records
	 *
	 * @param	boolean	$withMetadata
	 * @param	string	$orderBy
	 * @param	string	$sortOrder
	 * @return	array
	*/
	public function getActivePublic( $withMetadata = true, $orderBy = 'title', $sortOrder = 'ASC' )
	{
		$this->_db->where( 'active', '1' );
		$this->_db->where( 'privacy', 'public' );
		$this->_db->orderBy( $orderBy, $sortOrder );
		$projects = $this->_db->get( $this->_tableName );
		
		if( $withMetadata ) {
			if( !empty( $projects ) ) {
				foreach( $projects AS $key => $value ) {
					$projects[$key]['metadata'] = $this->getMetadataById( $value['id'] );
				}
			}
		}
		
		return $projects;
	}

}