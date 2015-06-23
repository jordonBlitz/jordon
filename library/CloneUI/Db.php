<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * CloneUI\Db
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Saturday, July 26, 2014, 08:19 PM GMT+1 mknox
 * @edited      $Date: 2014-08-03 23:49:06 +0200 (Sun, 03 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Db.php 44 2014-08-03 21:49:06Z bizlogic $
*/

class CloneUI_Db
{
	protected $_db;
	protected $_NOW;
	protected $_tableName;
	
	public function __construct()
	{
		$this->_db	= Zend_Registry::get('dbAdapter');
		$this->_NOW	= time();
	}

	/**
	 * Get by ID
	 *
	 * @param	int		$id
	 * @return	array
	*/
	public function getById( $id )
	{
		$id = (int)$id;
		$this->_db->where( 'id', $id );				
		$data = $this->_db->getOne( $this->_tableName );
		
		return $data;
	}
	
	/**
	 * Get records
	 * 
	 * @param	int		$limit
	 * @param	int		$offset
	 * @param	array	$orderBy
	 * @return	array
	 */
	public function get( $limit = null, $offset = null, $orderBy = array( ) )
	{		
		$query = "SELECT * FROM `".DB_TABLE_PREFIX.$this->_tableName."` ";
		
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
		
		if( ( $limit > 0 ) AND ( $offset > 0 ) ) {
			$query .= "LIMIT ".$offset.", ".$limit;	
		}

		$data = $this->_db->rawQuery( $query );
	
		return $data;
	}
	
	public function count()
	{
		$stats = $this->_db->getOne( $this->_tableName, "COUNT(*) AS count");
		return $stats['count'];
	}
	
	public function countBy( $column, $value )
	{
		$column = mysql_real_escape_string( $column );
		$value	= mysql_real_escape_string( $value ); 
		
		$query = "SELECT COUNT(*) AS count FROM `".mysql_real_escape_string( DB_TABLE_PREFIX.$this->_tableName )."` ";
		$query .= "WHERE `".$column."` = '".$value."' ";		
		$res	= mysql_query( $query ) OR die( mysql_error() );
		$data	= mysql_fetch_assoc( $res );
		
		return $data['count'];
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
				$data[] = $row;	
			}	
		}
		
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;
		
		return $data;
	}
	
	/**
	 * Get all records 
	 * 
	 * @param	array	$orderBy
	 * @return	array
	*/
	public function getAll( $orderBy = array( ) )
	{
		if( !empty( $orderBy ) ) {
			foreach( $orderBy AS $key => $value ) {
				$this->_db->orderBy( $key, $value );
			}	
		}

		$data = $this->_db->get( $this->_tableName );
		
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

		$id = (int)$this->_db->insert( $this->_tableName, $data );
		
		if( $id > 0 ) {
			return $id;	
		}	
	}

	/**
	 * Delete by ID
	 *
	 * @param	int	$id
	 * @return	boolean
	*/
	public function deleteById( $id )
	{
		$id = (int)$id;
		if( $id < 1 ) {
			return false;	
		}
		
		$this->_db->where('id', $id);
		
		return $this->_db->delete( $this->_tableName );		
	}
	
	/**
	 * Set by ID
	 *
	 * @param	int		$id
	 * @param	$data	array
	 * @return	boolean
	*/	
	public function setById( $id, $data = array() )
	{
		if( empty( $data ) ) {
			return false;	
		}
		
		$this->_db->where('id', (int)$id);
		return $this->_db->update( $this->_tableName, $data );
	}
	

	/**
	 * Delete by UUID
	 *
	 * @param	string	$uuid
	 * @return	boolean
	*/
	public function deleteByUUID( $uuid )
	{
		if( strlen( $uuid ) <> 36 ) {
			return false;	
		}
		
		$this->_db->where( 'uuid', $uuid );
		if( $this->_db->delete( $this->_tableName ) ) {
			return true;
		}
	}	
	
	/**
	 * Set by UUID
	 *
	 * @param	string	$uuid
	 * @param	$data	array
	 * @return	boolean
	*/
	public function setByUUID( $uuid, $data = array() )
	{
		if( empty( $data ) ) {
			return false;
		}
		
		if( strlen( $uuid ) <> 36 ) {
			return false;
		}
	
		$this->_db->where( 'uuid', $uuid );
		return $this->_db->update( $this->_tableName, $data );
	}
	
	/**
	 * Get by UUID
	 *
	 * @param	string	$uuid
	 * @return	array
	*/
	public function getByUUID( $uuid )
	{
		$this->_db->where( 'uuid', $uuid );
		$data = $this->_db->getOne( $this->_tableName );
	
		return $data;
	}
	
	/**
	 * Get name by ID
	 *
	 * @param	int		$id
	 * @return	string
	*/
	public function getNameById( $id )
	{
		$this->_db->where( 'id', (int)$id );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $data['name'];
		}
	}
	
	/**
	 * Get UUID by ID
	 *
	 * @param	int		$id
	 * @return	string
	*/
	public function getUUIDById( $id )
	{
		$this->_db->where( 'id', (int)$id );
		$data = $this->_db->getOne( $this->_tableName );
		if ( $this->_db->count > 0 ) {
			return $data['uuid'];
		}
	}
	
}