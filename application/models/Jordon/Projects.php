<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Projects
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Thursday, July 24, 2014, 07:31 PM GMT+1 mknox
 * @edited      $Date: 2014-06-27 08:02:12 -0700 (Fri, 27 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Users.php 63 2014-06-27 15:02:12Z hire@bizlogicdev.com $
 */

class Jordon_Projects extends CloneUI_Db
{
	protected $_db;
	protected $_tableName;
	
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'projects';
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
		$CloneUI_Users = new CloneUI_Users;
		
		// Category
		$metadata['category']		= array();
		$metadata['category_id']	= array();
			
		// START:	Category Join
		$sql = "SELECT * FROM `".DB_TABLE_PREFIX."project_categories` ";
		$sql .= "INNER JOIN `".DB_TABLE_PREFIX."project_category_rel` ";
		$sql .= "ON ".DB_TABLE_PREFIX."project_categories.id = ";
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
			$lead = $CloneUI_Users->getById( $projectLead );
			if( !empty( $lead ) ) {
				unset( $lead['password'] );	
			}
			
			$metadata['lead_info'] = $lead;
		}
	
		// destroy
		unset( $CloneUI_Users );

		// return
		return $metadata;
	}
	
	/**
	 * Get by Column & Value
	 *
	 * @param	string	$column
	 * @param	mixed	$value
	 * @param	boolean	$withMetadata
	 * @param	int		$limit
	 * @return	array
	*/	
	public function getBy( $column, $value, $withMetadata = true, $limit = 1 )
	{
		$limit = (int)$limit;
		
		// where
		$this->_db->where( $column, $value );
		
		// get
		$data = $this->_db->get( $this->_tableName, $limit );		
		$data = ( $limit == 1 AND isset( $data[0] ) ) ? $data[0] : $data;
		
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
}