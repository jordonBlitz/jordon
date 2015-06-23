<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * CloneUI Site Phrases Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Tuesday, October 08, 2013, 04:55 PM GMT+1 mknox
 * @edited      $Date: 2014-04-29 16:28:16 -0700 (Tue, 29 Apr 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Phrases.php 38 2014-04-29 23:28:16Z hire@bizlogicdev.com $
*/

class CloneUI_Site_Phrase
{
	public function fetchPhraseFromSession( $phrase )
	{	
		if( !isset( $_SESSION['site']['phrases'][$phrase] ) ) {
			return $phrase;	
		}	
		
		return $_SESSION['site']['phrases'][$phrase];
	}
	
	public function fetchAllPhrases( $orderBy = 'name', $sortOrder = 'ASC' )
	{
		$data	= array();
		
		$sql	= "SELECT * FROM `".DB_TABLE_PREFIX."site_phrase` ";
		$sql   .= "ORDER BY ".mysql_real_escape_string( $orderBy )." ";
		$sql   .= mysql_real_escape_string( $sortOrder );
		
		$res	= mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
		
		if( mysql_num_rows( $res ) > 0 ) {			
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}	
		}
		
		return $data;
	}
	 
	public function updateSitePhrases( $phrases )
	{
		if( empty( $phrases ) ) {
			return false;	
		}
						
		foreach( $phrases AS $key => $value ) {
			$sql  = "UPDATE `".DB_TABLE_PREFIX."site_phrase` SET ";			
			$sql .= "`text` = '".mysql_real_escape_string( $value )."' ";
			$sql .= "WHERE `id` = '".mysql_real_escape_string( $key )."' ";
			$sql .= "LIMIT 1 ";
			
			$res = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );			
		}		

		return true;
	}	
    // END OF THIS CLASS
}