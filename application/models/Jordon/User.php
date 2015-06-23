<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Users
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Thursday, July 31, 2014, 097:18 PM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_User extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'user';
	}

	public function search( $attributes = array(), $limit = 1, $offset = 0, $orderBy = array() )
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
			$query .= "`".$key."` LIKE '%".$value."%' ";
			if( $i < $count ) {
				$query .= " OR ";
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
	
		$res = mysql_query( $query ) OR die( mysql_error() );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
	
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;
	
		return $data;
	}	
	
	/**
	 * Get by Columns & Values
	 *
	 * @param	array	$attribues
	 * @param	int		$limit
	 * @param	int		$offset
	 * @param	array	$orderBy
	 * @return	array
	 */
	public function getBy( $attributes = array(), $limit = 1, $offset = 0, $orderBy = array() )
	{
		if( empty( $attributes ) OR !is_array( $attributes ) ) {
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
	
		$res = mysql_query( $query ) OR die( mysql_error() );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				if( !strlen( trim( $row['avatar_url'] ) ) ) {
					$row['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
				} elseif ( !urlExists( $row['avatar_url'] ) ) {
					$row['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
				}
				
				$data[] = $row;
			}
		}
	
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;
	
		return $data;
	}
}