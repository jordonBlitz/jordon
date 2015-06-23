<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * CloneUI Site Config Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2013 - 2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Tuesday, October 08, 2013, 04:39 PM GMT+1 mknox
 * @edited      $Date: 2014-08-03 02:43:56 +0200 (Sun, 03 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Config.php 34 2014-08-03 00:43:56Z bizlogic $
*/

class CloneUI_Site_Config
{
	// START OF THIS CLASS	
	protected $_db;
	protected $_tableName;
	
	public function __construct()
	{	
		$this->_db			= Zend_Registry::get('db');
		$this->_tableName	= DB_TABLE_PREFIX.'site_config';		
	}
	
	/**
	 * Fetch site configuration
	 *
	 * @param	string	$orderBy
	 * @param	string	$sortOrder
	 * @param	int		$editable
	 * @return  array
	*/
	public function fetchSiteConfig( $orderBy = 'name', $sortOrder = 'ASC', $editable = 1 )
	{
		$sql = "SELECT * FROM `".$this->_tableName."` WHERE `editable` = :editable ";
		$sql .= "ORDER BY :order ";
		$stmt = $this->_db->prepare( $sql );
		$stmt->bindValue( 'editable', $editable );
		$stmt->bindValue( 'order', $orderBy.' '.$sortOrder );
		$stmt->execute();
		
		$data = $stmt->fetchAll();
	
		return $data;
	}
	
	/**
	 * Fetch site config grouped by 
	 * category
	 * 
	 * @param	string	$orderBy
	 * @param	string	$sortOrder
	 * @return  array
	*/
	public function fetchSiteConfigGrouped( $orderBy = 'name', $sortOrder = 'ASC' )
	{
		$groupedData = array();
		$data = $this->fetchSiteConfig( $orderBy, $sortOrder );
		if( !empty( $data ) ) {
			foreach( $data AS $key => $value ) {
				if( !isset( $groupedData[$value['category']] ) ) {
					$groupedData[$value['category']] = array();
				}
				$groupedData[$value['category']][] = $value;
			}
			
			ksort( $groupedData, SORT_STRING );
		}
		
		return $groupedData;
	}
		
	public function fetchSiteConfigCategories( $orderBy = 'category', $sortOrder = 'ASC' )
	{		
		$result = array();
		
		$sql = "SELECT DISTINCT `category` FROM `".$this->_tableName."` ";
		$sql .= "ORDER BY :order ";
		$stmt = $this->_db->prepare( $sql );
		$stmt->bindValue( 'order', $orderBy.' '.$sortOrder );
		$stmt->execute();
		
		$data = $stmt->fetchAll();
	
		if( !empty( $data ) ) {
			foreach( $data AS $key => $value ) {
				$result[] = $value['category'];
			}
		}
	
		return $result;
	}	
	
	/**
	 * define site configuration
	*/
	public function defineSiteConfig()
	{
		$config = $this->fetchSiteConfig();
	
		if( !empty( $config ) ) {
			foreach( $config AS $key => $value ) {
				$value['value'] = str_replace( '__BASEURL__', BASEURL, $value['value'] );							
				define( strtoupper( $value['name'] ), $value['value'] );
			}
		}
	}

	public function updateSiteConfig( $config )
	{
		if( empty( $config ) ) {
			return false;
		}
	
		foreach( $config AS $key => $value ) {
			$this->_db->update( 
			    $this->_tableName, 
			    array( 
			        'value' => strip_all_slashes( $value ) 			        
			    ), 
			    array( 'name' => $key ) 
            );
		}
	
		return true;
	}	
	
    // END OF THIS CLASS
}