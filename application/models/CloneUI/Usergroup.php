<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * CloneUI Usergroup Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 - 2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Staturday, August 31, 2013, 23:03 GMT+1 mknox
 * @edited      $Date: 2014-04-29 16:28:16 -0700 (Tue, 29 Apr 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Usergroups.php 38 2014-04-29 23:28:16Z hire@bizlogicdev.com $
 */

class CloneUI_Usergroup
{
	private $_columnNames;
	public	$tableName;
	
	public function __construct()
	{
		$this->tableName	= DB_TABLE_PREFIX.'usergroup';
		$this->_columnNames	= fetchColumnNames( $this->tableName );
	}
	
	public function fetchUsergroupPermissionsById( $id )
	{
		$data = array();
		
		$sql = "SELECT * FROM `".DB_TABLE_PREFIX."usergroup_permission` ";
		$sql .= "WHERE `usergroup_id` = '".mysql_real_escape_string( (int)$id )."' ";
			
		$res = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
			
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
			
			return $data;
		} else {
			return array();
		}		
	}
	
	public function updateUsergroupPermissionsById( $id, $data = array() )
	{
		$id = (int)$id;
		
		if( empty( $data ) ) {
			$sql = "DELETE FROM `".DB_TABLE_PREFIX."usergroup_permission` ";
			$sql .= "WHERE `usergroup_id` = '".mysql_real_escape_string( $id )."' ";
			
			$res = mysql_query( $sql ) OR die( mysql_error() );
			
			return true;
		}
		
		$existingPerms	= $this->fetchUsergroupPermissionsById( $id );
		$permIds		= array();
		$newPermIds 	= array();
		
		if( !empty( $existingPerms ) ) {
			// START:	fetch existing permissions			
			foreach( $existingPerms AS $key => $value ) {
				$permIds[] = $value['permission_id'];
			}
			// END:		fetch existing permissions

			// START:	fetch new permissions
			foreach( $data AS $key => $value ) {
				$newPermIds[] = $value;
			}
			// END:		fetch new permissions
			
			// compare arrays
			$diff = array_diff( $permIds, $newPermIds );
			
			// START:	remove perms
			if( !empty( $diff ) ) {
				foreach( $diff AS $key => $value ) {
					$sql = "DELETE FROM `".DB_TABLE_PREFIX."usergroup_permission` ";
					$sql .= "WHERE `permission_id` = '".mysql_real_escape_string( (int)$value )."' ";
					$sql .= "AND `usergroup_id` = '".mysql_real_escape_string( $id )."' ";
					$sql .= "LIMIT 1";
						
					$res = mysql_query( $sql ) OR die( mysql_error() );					
				}
			}
			// END:		remove perms
		}
			
	
		foreach( $data AS $key => $value ) {		
			$sql = "INSERT IGNORE INTO `".DB_TABLE_PREFIX."usergroup_permission` ( ";
			$sql .= "`usergroup_id`, `permission_id` ";
			$sql .= ") VALUES ( ";
			$sql .= "'".mysql_real_escape_string( $id )."', ";
			$sql .= "'".mysql_real_escape_string( (int)$value )."' ";
			$sql .= ") ";
			
			$res = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );			
		}
	
		return mysql_affected_rows();
	}	
	
	public function updateUsergroupById( $id, $data = array() )
	{
		if( empty( $data ) ) {
			return false;	
		}
		
		// START:	filter input
		foreach( $data AS $key => $value ) {
			if( !in_array( $key, $this->_columnNames ) ) {
				unset( $data[$key] );
			}
		}
		// END:		filter input
			
		if( empty( $data ) ) {
			return false;
		}		
		
		$count	= count( $data );
		$i		= 1;
		
		$sql    = "UPDATE `".DB_TABLE_PREFIX."usergroup` SET ";
		
		foreach( $data AS $key => $value ) {
			$sql .= "`".mysql_real_escape_string( $key )."` = '".mysql_real_escape_string( $value )."' ";
			
			if( $i < $count ) {
				$sql .= ", ";	
			}
			
			$i++;			
		}
		
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$id )."' ";
		$sql   .= "LIMIT 1 ";
	
		$res    = mysql_query( $sql ) OR die( mysql_error() );
	
		return mysql_affected_rows();
	}
		
	public function deleteUsergroupById( $id )
	{
		$sql    = "DELETE FROM `".mysql_real_escape_string( $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( $id )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysql_query( $sql ) OR die( mysql_error()."\n".$sql );
		
		return mysql_affected_rows();		
	}
	
	public function fetchAllUsergroups( $orderBy = 'name', $sortOrder = 'ASC' )
	{
		$data = array();
			
		$sql = "SELECT * FROM `".mysql_real_escape_string( $this->tableName )."` ";
		$sql .= "ORDER BY ".mysql_real_escape_string( $orderBy )." ";
		$sql .= mysql_real_escape_string( $sortOrder )." ";
		$res = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
			
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
	
		return $data;
	}

	public function fetchUsergroupById( $id )
	{
		$sql    = "SELECT * FROM `".mysql_real_escape_string( $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( $id )."' ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );				
			return $data;
		} else {
			return array();
		}
	}	
		
	public function fetchUsergroupsByUserId( $userId )
	{
		$sql    = "SELECT `usergroup_id` FROM `".mysql_real_escape_string( $this->tableName )."` ";
		$sql   .= "WHERE `user_id` = '".mysql_real_escape_string( $userId )."' ";
		 
		$res    = mysql_query( $sql ) OR die( mysql_error() );
		 
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row['usergroup_id'];				
			}
			
			return $data;
			 		
		} else {
			return array();
		}		
	}

	public function setUsersUsergroupById( $userId, $usergroupId )
	{
		$sql    = "UPDATE `".DB_TABLE_PREFIX."usergroup_member` ";
		$sql   .= "SET `usergroup_id` = '".mysql_real_escape_string( (int)$usergroupId )."' ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$userId )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysql_query( $sql ) OR die( mysql_error() );		
		
		return mysql_affected_rows();
	}	
}