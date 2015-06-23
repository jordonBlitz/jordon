<?php
/**
 * CloneUI.com - CloneUI Clone
 * CloneUI Media Comments Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Monday, September 16, 2013, 10:23 PM GMT+1 mknox
 * @edited      $Date: 2014-04-29 16:28:16 -0700 (Tue, 29 Apr 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Comments.php 38 2014-04-29 23:28:16Z hire@bizlogicdev.com $
 */

class CloneUI_Media_Comments
{	
	public function deleteOwnCommentById( $commentId )
	{
		$sql	= "DELETE FROM `".DB_TABLE_PREFIX."media_comments` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$commentId )."' ";
		$sql   .= "AND `commenter_id` = '".mysql_real_escape_string( (int)$_SESSION['user']['id'] )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res	= mysql_query( $sql ) OR die( mysql_error() );
		
		return mysql_affected_rows();
	}	
	
	public function addCommentToMedia( $mediaId, $commenterId, $commentText )
	{	
		$filter			= new Zend_Filter_StripTags();		
		$commentText	= $filter->filter( $commentText );		
		
		$sql    = "INSERT INTO `".DB_TABLE_PREFIX."media_comments` ( ";
		$sql   .= "`media_id`, `commenter_id`, `comment`, `date` ";
		$sql   .= " ) VALUES ( ";
		$sql   .= " '".mysql_real_escape_string( (int)$mediaId )."', ";
		$sql   .= " '".mysql_real_escape_string( (int)$commenterId )."', ";
		$sql   .= " '".mysql_real_escape_string( $commentText )."', ";
		$sql   .= " '".mysql_real_escape_string( time() )."' ";
		$sql   .= " ); ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error()."\nSQL:\n\n".$sql );

		$data					= array();
		$data['id'] 			= mysql_insert_id();
		$data['affected_rows']	= mysql_affected_rows();
		
		return $data;		
	}
	
	public function fetchCommentsByMediaId( $mediaId, $offset = 0, $limit = SITE_COMMENT_FETCH_LIMIT, $sortOrder = 'ASC', $sortBy = 'date' )
	{
		$limit	= ( (int)$limit == 0 ) ? $this->fetchCommentCountByMediaId( $mediaId ) : $limit;
		
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."media_comments` ";
		$sql   .= "WHERE `media_id` = '".mysql_real_escape_string( (int)$mediaId )."' ";
		$sql   .= "ORDER BY ".mysql_real_escape_string( $sortBy )." ";
		$sql   .= "LIMIT ".mysql_real_escape_string( (int)$offset ).", ".mysql_real_escape_string( (int)$limit );
			
		$res    = mysql_query( $sql ) OR die( mysql_error()."\nSQL:\n\n".$sql );	
		$data	= array();
		
		if( mysql_num_rows( $res ) > 0 ) {
			
			$i					= 0;			
			$CloneUI_User	= new CloneUI_User;
			
			if( SITE_CENSOR_REPLACEMENT_TYPE == 'image' ) {
				$censor = '<img border="0" src="'.SITE_CENSOR_REPLACEMENT.'">';
			} else {
				$censor = SITE_CENSOR_REPLACEMENT;
			}			
			
			while( $row = mysql_fetch_assoc( $res ) ) {				
				$userData = $CloneUI_User->fetchUserDetailsById( $row['commenter_id'] );
				
				if( SITE_ALLOW_URL_IN_COMMENT != 1 ) {										
					$urls = detectAllUrls( $row['comment'] );
					if( !empty( $urls ) ) {
						foreach( $urls AS $key => $value ) {							
							$row['comment'] = str_replace( $value, $censor, $row['comment'] );							
						}
					}					
				} else if( SITE_ALLOW_URL_IN_COMMENT == 1 AND SITE_PARSE_URL_IN_COMMENT == 1 ) {										
					$urls = detectAllUrls( $row['comment'] );
					if( !empty( $urls ) ) {
						foreach( $urls AS $key => $value ) {
							$row['comment'] = str_replace( $value, '<a href="http://'.$value.'" target="_blank">'.$value.'</a>', $row['comment'] );	
						}	
					}
				}
				
				$data[$i]					= $row;
				$data[$i]['commenter_name']	= $userData['username'];
				$data[$i]['avatar_url']		= $userData['avatar_url'];
				
				$i++;					
			}
		}

		return $data;		
	}

	public function fetchCommentCountByMediaId( $mediaId )
	{
		$sql    = "SELECT COUNT(*) AS `total_count` FROM `".DB_TABLE_PREFIX."media_comments` ";
		$sql   .= "WHERE `media_id` = '".mysql_real_escape_string( (int)$mediaId )."' ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error()."\nSQL:\n\n".$sql );		
		$data	= mysql_fetch_assoc( $res );
		
		return $data['total_count'];		
	}
	 
    // END OF THIS CLASS
}