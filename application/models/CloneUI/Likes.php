<?php
/**
 * CloneUI.com - CloneUI Clone
 * CloneUI Likes Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Sunday, September 15, 2013, 02:40 AM GMT+1 mknox
 * @edited      $Date: 2014-05-16 02:37:14 -0700 (Fri, 16 May 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Likes.php 46 2014-05-16 09:37:14Z hire@bizlogicdev.com $
 */

class CloneUI_Likes
{
	public function fetchAllLikesBySubjectId( $subjectId, $type )
	{		
		$sql    = "SELECT count(*) AS total FROM `".DB_TABLE_PREFIX."likes` ";
		$sql   .= "WHERE `subject_id` = '".mysql_real_escape_string( (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysql_real_escape_string( $type )."' ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
		
		$likeData	= array();
		$users		= array();
		$data		= mysql_fetch_assoc( $res );
		$totalLikes = $data['total'];
		
		$sql    = "SELECT u.username FROM `".DB_TABLE_PREFIX."users` u ";
		$sql   .= "INNER JOIN `".DB_TABLE_PREFIX."likes` l on u.id = l.liker_id ";
		$sql   .= "WHERE l.subject_id = '".mysql_real_escape_string( (int)$subjectId )."' ";
		$sql   .= "AND l.type = '".mysql_real_escape_string( $type )."' ";
		$sql   .= "ORDER BY RAND() ";
		$sql   .= "LIMIT 3 ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
		
		if( mysql_num_rows( $res ) > 0 ) {
			$users = array();
			while( $row = mysql_fetch_assoc( $res ) ) {
				$users[] = $row['username'];				
			}			
		}		
		
		$likeData['count'] = $totalLikes;
		$likeData['users'] = $users;

		return $likeData;
	}
	
	public function fetchLikeByUserId( $subjectId, $userId, $type )
	{
		$sql    = "SELECT `id` FROM `".DB_TABLE_PREFIX."likes` ";
		$sql   .= "WHERE `subject_id` = '".mysql_real_escape_string( (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysql_real_escape_string( $type )."' ";
		$sql   .= "AND `liker_id` = '".mysql_real_escape_string( $userId )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
		
		if( mysql_num_rows( $res ) > 0 ) {
			return true;
		}
	
		return false;
	}
		
	public function likeSubjectById( $subjectId, $type )
	{		
		$sql    = "INSERT IGNORE INTO `".DB_TABLE_PREFIX."likes` ";
		$sql   .= " (`subject_id`, `liker_id`, `type`, `date`) ";
		$sql   .= " VALUES ('".mysql_real_escape_string( (int)$subjectId )."', ";
		$sql   .= " '".mysql_real_escape_string( (int)$_SESSION['user']['id'] )."', ";
		$sql   .= " '".mysql_real_escape_string( $type )."', ";
		$sql   .= " '".mysql_real_escape_string( time() )."' ); ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );

		return mysql_affected_rows();		
	}
	
	public function unLikeSubjectById( $subjectId, $type )
	{
		$sql    = "DELETE FROM `".DB_TABLE_PREFIX."likes` ";
		$sql   .= "WHERE `subject_id` = '".mysql_real_escape_string( (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysql_real_escape_string( $type )."' ";
		$sql   .= "AND `liker_id` = '".mysql_real_escape_string( (int)$_SESSION['user']['id'] )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		return mysql_affected_rows();	
	}

	public function removeAllLikesBySubjectId( $subjectId, $type )
	{
		$sql    = "DELETE FROM `".DB_TABLE_PREFIX."likes` ";
		$sql   .= "WHERE `subject_id` = '".mysql_real_escape_string( (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysql_real_escape_string( $type )."' ";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		return mysql_affected_rows();
	}	
	 
    // END OF THIS CLASS
}