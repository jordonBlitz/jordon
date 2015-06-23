<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * CloneUI Site Permissions Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Staturday, August 31, 2013, 22:54 GMT+1 mknox
 * @edited      $Date: 2014-06-14 09:21:49 -0700 (Sat, 14 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Permissions.php 56 2014-06-14 16:21:49Z hire@bizlogicdev.com $
 */

class CloneUI_Site_Permission
{
	public function fetchSitePermissionsByUserId( $userId )
	{
		$userId	= (int)$userId;
		
		if( $userId > 0 ) {
			$sql    = "SELECT `usergroup_id` FROM `".DB_TABLE_PREFIX."usergroup_member` ";
			$sql   .= "WHERE `user_id` = '".mysql_real_escape_string( $userId )."' ";
				
			$res    = mysql_query( $sql ) OR die( mysql_error() );
				
			if( mysql_num_rows( $res ) > 0 ) {
				while( $row = mysql_fetch_assoc( $res ) ) {
					$data[] = $row['usergroup_id'];
				}
					
				if( !empty( $data ) ) {
					return $this->fetchUsergroupPermissionsByUsergroupId( $data );
				}
			
			} else {
				return array();
			}			
		} else {
			return $this->fetchUsergroupPermissionsByUsergroupId( array( SITE_GUEST_USERGROUP_ID ) );	
		}	
	}
	
	public function fetchSitePermissionsExternal()
	{
		return array('site' => 'can_view_site');	
	}
	
	public function fetchAllSitePermissions()
	{
		$data = array();
		
		$sql = "SELECT * FROM `".DB_TABLE_PREFIX."site_permissions` ";			
		$res = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		} 
		
		return $data;
	}	

	public function fetchUsergroupPermissionsByUsergroupId( $usergroupId = array() )
	{
		if( !empty( $usergroupId ) ) {
			$groups	= implode ( ',', $usergroupId );			
		}
					
		$sql    = "SELECT `permission_id` FROM `".DB_TABLE_PREFIX."usergroup_permission` ";
		$sql   .= "WHERE `usergroup_id` IN (".mysql_real_escape_string( $groups )."); ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
			
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row['permission_id'];
			}
						
			if( !empty( $data ) ) {
				$perms	=  implode ( ',', $data );
 				$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."site_permission` ";
 				$sql	.= "WHERE `id` IN (".mysql_real_escape_string( $perms )."); ";

 				$res	= mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
 				
 				if( mysql_num_rows( $res ) > 0 ) {
 					$sitePerms = array();
 					while( $row = mysql_fetch_assoc( $res ) ) {
 						$sitePerms[$row['permission_type']][] = $row['permission_name'];
 					}
 					 					
 					return $sitePerms;
 				} 				
			}	
		} else {
			return array();
		}
	}	
}