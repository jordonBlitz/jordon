<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * CloneUI Site Theme Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 - 2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Tuesday, September 24, 2013, 10:55 AM GMT+1 mknox
 * @edited      $Date: 2014-06-27 08:00:19 -0700 (Fri, 27 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Themes.php 62 2014-06-27 15:00:19Z hire@bizlogicdev.com $
 */

class CloneUI_Site_Theme
{
	private $_tableName;
	
	public function __construct()
	{
		$this->_tableName = DB_TABLE_PREFIX.'site_theme';
	}
	
	public function fetchThemesForDisplay( $orderBy = 'display_name', $sortOrder = 'ASC' )
	{		
		$sql	= "SELECT `name`, `display_name` ";
		$sql   .= "FROM `".$this->_tableName."` ";
		$sql   .= "WHERE `active` = '1' ";
		$sql   .= "ORDER BY `".mysql_real_escape_string( $orderBy )."` ";
		$sql   .= mysql_real_escape_string( $sortOrder )." ";		
		$res	= mysql_query( $sql ) OR die( mysql_error() );
		
		if( mysql_num_rows( $res ) > 0 ) {
			$data = array();
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[$row['name']] = $row['display_name'];
			}
			return $data;
		} else {
			return array();
		}
	}
	
	public function fetchBootstrapThemesForDisplay( $orderBy = 'display_name', $sortOrder = 'ASC', $active = 1 )
	{
		$sql = "SELECT `name`, `display_name` ";
		$sql .= "FROM `".$this->_tableName."` ";
		$sql .= "WHERE `active` = '".mysql_real_escape_string( $active )."' ";
		$sql .= "AND `type` = 'bootstrap' ";
		$sql .= "ORDER BY `".mysql_real_escape_string( $orderBy )."` ";
		$sql .= mysql_real_escape_string( $sortOrder )." ";
		$res = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			$data = array();
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[$row['name']] = $row['display_name'];
			}
	
			return $data;
	
		} else {
			return array();
		}
	}
		
	public function fetchActiveThemes()
	{
		$sql = "SELECT * FROM `".$this->_tableName."` ";		 
		$res = mysql_query( $sql ) OR die( mysql_error() );
		 
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;				
			}

			return $data;
			 		
		} else {
			return array();
		}		
	}

	public function fetchAllThemes()
	{
		$sql    = "SELECT * FROM `".$this->_tableName."` ";
		$sql   .= "WHERE `active` = 1 ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
			
			return $data;
				
		} else {
			return array();
		}
	}	
}