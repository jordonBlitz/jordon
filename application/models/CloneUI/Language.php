<?php
/**
 * Jordon
 * Language Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License
 *
 * @since       Tuesday, November 27, 2012, 08:00 AM GMT+1 mknox
 * @edited      $Date: 2014-07-20 10:40:37 -0700 (Sun, 20 Jul 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Languages.php 66 2014-07-20 17:40:37Z hire@bizlogicdev.com $
 */

class CloneUI_Language
{
	/**
	 * fetch all language data
	 *
	 * @return  array
	*/
	public function fetchAllLanguages()
	{
		$data = array();
	
		$sql = "SELECT * FROM `".DB_TABLE_PREFIX."language` ";
		$res = mysql_query( $sql ) OR die( mysql_error() );
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
		
		return $data;
	}
	
	/**
	 * Fetch All Active Languages
	 *
	 * @return  array
	*/
	public function fetchActiveLanguages()
	{
		$data = array();
		$sql = "SELECT * FROM `".DB_TABLE_PREFIX."language` ";
		$sql .= "WHERE `active` = '1' ";
		$res    = mysql_query( $sql ) OR die( mysql_error() );
	
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
	
		return $data;
	}
		
    /**
     * fetch language ID via locale string
     *
     * @param   string  $locale
     * @return  int
    */
    public function fetchLanguageIdByLocale( $locale )
    {
        $sql = "SELECT `id` FROM `".DB_TABLE_PREFIX."language` ";
        $sql .= "WHERE `iso_639` = '".mysql_real_escape_string( $locale )."' ";
        $sql .= "LIMIT 1 ";

        $res = mysql_query( $sql ) OR die( mysql_error() );

        if( mysql_num_rows( $res ) > 0 ) {
            $data = mysql_fetch_assoc( $res );
            return $data['id'];
        }
    }
    
    public function languageExistsById( $id )
    {
    	$sql = "SELECT `id` FROM `".DB_TABLE_PREFIX."language` ";
    	$sql .= "WHERE `id` = '".mysql_real_escape_string( $id )."' ";
    	$sql .= "LIMIT 1 ";
    	
    	$res = mysql_query( $sql ) OR die( mysql_error() );
    	
    	if( mysql_num_rows( $res ) > 0 ) {
			return true;
    	}    	
    }
    
    /**
     * Fetch Friendly Name by ID
     * 
     * @param   int     $id
     * @return  string
    */
    public static function fetchFriendlyNameById( $id )
    {
    	$sql = "SELECT `friendly_name` FROM `".DB_TABLE_PREFIX."language` ";
    	$sql .= "WHERE `id` = '".mysql_real_escape_string( $id )."' ";
    	$sql .= "LIMIT 1 ";
    
    	$res = mysql_query( $sql ) OR die( mysql_error() );
    
    	if( mysql_num_rows( $res ) > 0 ) {
    		$data = mysql_fetch_assoc( $res );
    		return $data['friendly_name'];
    	}
    }
    
    public function fetchNativeNameById( $id )
    {
    	$sql = "SELECT `native_name` FROM `".DB_TABLE_PREFIX."language` ";
    	$sql .= "WHERE `id` = '".mysql_real_escape_string( $id )."' ";
    	$sql .= "LIMIT 1 ";
    	
    	$res = mysql_query( $sql ) OR die( mysql_error() );
    	
    	if( mysql_num_rows( $res ) > 0 ) {
    		$data = mysql_fetch_assoc( $res );
    		return $data['native_name'];
    	}
    }  
      
    public function fetchById( $id )
    {
    	$sql = "SELECT * FROM `".DB_TABLE_PREFIX."language` ";
    	$sql .= "WHERE `id` = '".mysql_real_escape_string( $id )."' ";
    	$sql .= "LIMIT 1 ";
    	
    	$res = mysql_query( $sql ) OR die( mysql_error() );
    	
    	if( mysql_num_rows( $res ) > 0 ) {
    		$data = mysql_fetch_assoc( $res );
    		return $data;
    	}
    }    
        
    public function fetchLanguageIdByIso31661( $locale )
    {
    	$sql = "SELECT `id` FROM `".DB_TABLE_PREFIX."language` ";
    	$sql .= "WHERE `iso_3166_1` = '".mysql_real_escape_string( $locale )."' ";
    	$sql .= "LIMIT 1 ";   
    	
    	$res = mysql_query( $sql ) OR die( mysql_error() );
    
    	if( mysql_num_rows( $res ) > 0 ) {
    		$data = mysql_fetch_assoc( $res );
    		return $data['id'];
    	}
    }    

    /**
     * fetch all phrases by language ID
     *
     * @param   int     $locale
     * @return  array
    */
    public function fetchPhrasesByLanguageId( $id )
    {
        $data = array();

        $sql = "SELECT `name`, `text` FROM `".DB_TABLE_PREFIX."site_phrase` ";
        $sql .= "WHERE `language_id` = '".mysql_real_escape_string( $id )."' ";
        
        $res = mysql_query( $sql ) OR die( mysql_error() );

        if( mysql_num_rows( $res ) > 0 ) {
            while( $row = mysql_fetch_assoc( $res ) ) {
                $data[ $row['name'] ] = $row['text'];
            }
        }
        
        return $data;
    }
}