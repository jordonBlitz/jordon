<?php
/**
 * CloneUI.com - Base Framework
 * User Media Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 - 2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Wednesday, November 28, 2013, 01:08 AM GMT+1 mknox
 * @edited      $Date: 2014-04-29 16:28:16 -0700 (Tue, 29 Apr 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Media.php 38 2014-04-29 23:28:16Z hire@bizlogicdev.com $
 */

class CloneUI_User_Media
{
	protected $_CloneUI_Likes;
	protected $_CloneUI_Media_Comments;
	protected $_CloneUI_Upload;
	
	public function __construct()
	{
		$this->_CloneUI_Likes			= new CloneUI_Likes;
		$this->_CloneUI_Media_Comments	= new CloneUI_Media_Comments;
		$this->_CloneUI_Upload			= new CloneUI_Upload;
	}
	
	public function updateMediaById( $id, $data = array() )
	{
		if( empty( $data ) ) {
			return false;	
		}
		
		$count	= count( $data );
		$i		= 1;
		
		$sql = "UPDATE `".DB_TABLE_PREFIX."user_media` SET ";
		
		foreach( $data AS $key => $value ) {
			$sql .= "`".mysql_real_escape_string( $key )."` = '".mysql_real_escape_string( $value )."' ";
			
			if( $i < $count ) {
				$sql .= ", ";	
			}
			
			$i++;	
		}
		
		$sql .= "WHERE `id` = '".mysql_real_escape_string( (int)$id ) ."' ";
		$sql .= "LIMIT 1 ";
	
		$res = mysql_query( $sql ) OR die( mysql_error() );
	
		return mysql_affected_rows();
	}	

	public function updateCaptionByMediaId( $mediaId, $comment )
	{
		$sql = "UPDATE `".DB_TABLE_PREFIX."user_media` ";
		$sql .= "SET `caption` = '".mysql_real_escape_string( $comment ) ."' ";
		$sql .= "WHERE `owner_id` = '".mysql_real_escape_string( $_SESSION['user']['id'] ) ."' ";
		$sql .= "AND `id` = '".mysql_real_escape_string( $mediaId ) ."' ";
		$sql .= "LIMIT 1 ";
		
		$res = mysql_query( $sql ) OR die( mysql_error() );
		
		return mysql_affected_rows();
	}

	public function repostMediaById( $mediaId )
	{
		$data = $this->fetchMediaDataById( $mediaId );

		if( !empty( $data ) ) {
			require_once('randlib.class.php');
						
			$data['repost_source']	= ( strlen( $data['repost_source'] ) ) ? $data['repost_source'] : $data['id'];
			$data['is_repost']		= 1;
			$data['upload_date']	= time();
			$data['owner_id']		= $_SESSION['user']['id'];
			$data['uuid']			= random::generateRandomString( rand ( 8, 11 ) );
			
			unset( $data['id'] );
			
			return $this->_CloneUI_Upload->add_media( $data );				
		}
	}
	
	public function deleteOwnMediabyId( $mediaId )
	{
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$mediaId )."' ";
		$sql   .= "AND `owner_id` = '".mysql_real_escape_string( (int)$_SESSION['user']['id'] )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );
				
			@unlink( $data['file_path'] );
			@unlink( $data['mid_path'] );
			@unlink( $data['thumb_path'] );
				
			$sql    = "DELETE FROM `".DB_TABLE_PREFIX."user_media` ";
			$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$mediaId )."' ";
			$sql   .= "AND `owner_id` = '".mysql_real_escape_string( (int)$_SESSION['user']['id'] )."' ";
			$sql   .= "LIMIT 1";
		
			$this->_CloneUI_Likes->removeAllLikesBySubjectId( (int)$mediaId, 'media' );
			
			$res    = mysql_query( $sql ) OR die( mysql_error() );
		
			return true;
		}		
	}
	
	public function deleteMultipleMediaById( $media = array() )
	{
		if( empty( $media ) ) {
			return;
		}
		
		foreach( $media AS $key => $value ) {
			$this->deleteMediaById( (int)$value );	
		}
		
		return true;
	}
	
	public function deleteMediaById( $mediaId )
	{
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$mediaId )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );
			
			@unlink( $data['file_path'] );
			@unlink( $data['mid_path'] );			
			@unlink( $data['thumb_path'] );
			
			$sql    = "DELETE FROM `".DB_TABLE_PREFIX."user_media` ";
			$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$mediaId )."' ";
			$sql   .= "LIMIT 1";
				
			$res    = mysql_query( $sql ) OR die( mysql_error() );
			
			$this->_CloneUI_Likes->removeAllLikesBySubjectId( (int)$mediaId, 'media' );			

			return true;
		}
	}
	
	public function fetchMediaDataById( $id )
	{
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( $id )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );
			return $data;
		} else {
			return array();
		}
	}	
	
	public function getMediaDataByUUID( $uuid )
	{
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `uuid` = '".mysql_real_escape_string( $uuid )."' ";
		$sql   .= "LIMIT 1";
		 
		$res    = mysql_query( $sql ) OR die( mysql_error() );
		 
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );
			return $data; 		
		} else {
			return array();
		}		
	} 
	
	public function fetchAllMediaIdsByUserId( $userId )
	{
		$sql    = "SELECT `id` FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `owner_id` = '".mysql_real_escape_string( (int)$userId )."' ";
		$res    = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
			
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row['id'];
			}
	
			return $data;
	
		} else {
			return array();
		}
	}
		
	public function fetchAllMediaByUserId( $userId )
	{
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `owner_id` = '".mysql_real_escape_string( (int)$userId )."' ";		 
		$res    = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
		 
		if( mysql_num_rows( $res ) > 0 ) {
			while( $row = mysql_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
	
			return $data;
	
		} else {
			return array();
		}
	}
		
    public function fetchMediaByUserId( $userId, $limit = SITE_DEFAULT_MEDIA_FETCH_LIMIT, $orderBy = 'upload_date', $sortOrder = 'DESC', $offset = 0 )
    {    	
    	$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
    	$sql   .= "WHERE `owner_id` = '".mysql_real_escape_string( (int)$userId )."' ";
    	$sql   .= "ORDER BY `".mysql_real_escape_string( $orderBy )."` ".mysql_real_escape_string( $sortOrder )." ";
    	$sql   .= "LIMIT ".mysql_real_escape_string( (int)$offset ).", ".mysql_real_escape_string( (int)$limit );
    	
    	$res    = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
    	
    	if( mysql_num_rows( $res ) > 0 ) {
    		while( $row = mysql_fetch_assoc( $res ) ) {
    			$data[] = $row;
    		}
    		
    		return $data;
    		
    	} else {
    		return array();
    	}    	
    }
    
    public function fetchMediaCountByUserId( $userId )
    {
    	$sql    = "SELECT COUNT(*) AS `count` FROM `".DB_TABLE_PREFIX."user_media` ";
    	$sql   .= "WHERE `owner_id` = '".mysql_real_escape_string( (int)$userId )."' ";
    	 
    	$res    = mysql_query( $sql ) OR die( mysql_error() );    	
    	$data	= mysql_fetch_assoc( $res );
    	
    	return $data['count'];    	
    }

    public function fetchTotalMediaCount()
    {
    	$sql    = "SELECT COUNT(*) AS `count` FROM `".DB_TABLE_PREFIX."user_media` ";
    
    	$res    = mysql_query( $sql ) OR die( mysql_error() );
    	$data	= mysql_fetch_assoc( $res );
    	 
    	return $data['count'];
    }   

    public function fetchRandomMediaByUserId( $userId, $limit = null )
    {
    	if( is_null( $limit ) ) {
    		$limit = 14;
    	}
    	    	
    	$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
    	$sql   .= "WHERE `owner_id` = '".mysql_real_escape_string( (int)$userId )."' ";
    	$sql   .= "ORDER BY RAND() ";    	
    	$sql   .= "LIMIT ".mysql_real_escape_string( (int)$limit );
    	 
    	$res    = mysql_query( $sql ) OR die( mysql_error() );
    	 
    	if( mysql_num_rows( $res ) > 0 ) {
    		while( $row = mysql_fetch_assoc( $res ) ) {
    			$data[] = $row;
    		}
    		
    		$split	= array_chunk( $data, ( $limit / 2 ) );    		
    		$data	= array();
    		
    		foreach( $split[0] AS $key => $value ) {
    			if( isset( $split[1][$key] ) ) {
    				$split[0][$key]['flip'] = $split[1][$key];    				
    			} else {
    				$split[0][$key]['flip'] = array();
    			}   				
    		}    		    	
    		
    		$data = $split[0];
  		    		    
    		return $data;
    
    	} else {
    		return array();
    	}
    }     

    public function fetchRandomCompHtml( $userId, $limit = 14 )
    {    	    	
    	$data = $this->fetchRandomMediaByUserId( (int)$userId, (int)$limit );
    	if( !empty( $data ) ) {
    		    		
    		$response	= '';
    		$i			= 0;
    		
			foreach ( $data AS $key => $value ) {
				$i++;
				$response .= '<div class="compPhoto compPhoto'.$i;
				$rand = rand(0, 10);
				if ($rand >= 5) {
					$response .= ' compFlipped';
				}
				$response .= '">';
				$response .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" data-timestamp="'.$value['upload_date'].'" data-image="'.$value['thumb_url_path'].'" data-mediaid="'.$value['id'].'" class="displayModal noBlockUI compFrontside" target="_blank" href="';
				$response .= BASEURL.'/p/'.$value['uuid'].'">';
				
				if( $value['media_type'] == 'video' ) {
					// $response .= '<div class="tVideo">';					
				}
				
				$response .= '<div alt="" src="';
				if( $i == 3 ) {
					$response .= $value['mid_url_path']; 
				} else {
					$response .= $value['thumb_url_path']; 
				}
				
				$response .= '" style="';
				if( $i == 3 ) {
					$response .= 'background-image: url('.$value['mid_url_path'].');';
				} else {
					$response .= 'background-image: url('.$value['thumb_url_path'].'); ';
				}
							
				$response .= ' width: 100%; height: 100%;" class="Image iLoaded"></div>';
				
				if( $value['media_type'] == 'video' ) {
					// $response .= '<div class="tVideoIndicator"></div>';
					// $response .= '</div>';
				}
								
				$response .= '<b class="compPhotoShadow"></b>';
				$response .= '</a>';
				if( !empty( $value['flip'] ) ) {
					$response .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" data-timestamp="'.$value['upload_date'].'" data-image="'.$value['thumb_url_path'].'" data-mediaid="'.$value['id'].'" class="displayModal noBlockUI compFlipside" target="_blank" ';
					$response .= 'href="'.BASEURL.'/p/'.$value['flip']['uuid'].'">';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideo">';
					}
										
					$response .= '<div alt="" src="';
					if( $i == 3 ) {
						$response .= $value['flip']['mid_url_path']; 
					} else {
						$response .= $value['flip']['thumb_url_path']; 
					}
					
					$response .= '" style="';
					
					if( $i == 3 ) {
						$response .= 'background-image: url('.$value['flip']['mid_url_path'].'); '; 
					} else {
						$response .= 'background-image: url('.$value['flip']['thumb_url_path'].'); '; 
					} 
					
					$response .= 'width: 100%; height: 100%;" class="Image iLoaded"></div>';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideoIndicator"></div>';
						// $response .= '</div>';
					}
										
					$response .= '<b class="compPhotoShadow"></b>';
					$response .= '</a>';
				} else {
					$response .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" data-timestamp="'.$value['upload_date'].'" data-image="'.$value['thumb_url_path'].'" data-mediaid="'.$value['id'].'" class="displayModal noBlockUI compFlipside" target="_blank" href="';
					$response .= BASEURL.'/p/'.$value['uuid'].'">';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideo">';
					}
										
					$response .= '<div alt="" src="';
					
					if( $i == 3 ) {
						$response .= $value['mid_url_path']; 
					} else {
						$response .= $value['thumb_url_path']; 
					}
					 
					$response .= '" style="';
					if( $i == 3 ) {
						$response .= 'background-image: url('.$value['mid_url_path'].') '; 
					} else {
						$response .= 'background-image: url('.$value['thumb_url_path'].') '; 
					}
					
					$response .= 'width: 100%; height: 100%;" class="Image iLoaded"></div>';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideoIndicator"></div>';
						// $response .= '</div>';
					}
										
					$response .= '<b class="compPhotoShadow"></b>';
					$response .= '</a>';
				}

				$response .= '</div>';					
			}

			return $response;
		}    			
    }
    
    public function fetchAllMedia( $limit = null, $offset = null, $orderBy = 'upload_date', $sortOrder = 'DESC' )
    {
    	if( is_null( $limit ) ) {
    		$limit = 60;
    	}
    	
    	if( is_null( $offset ) ) {
    		$offset = 0;
    	}    	
    	    	
    	$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
    	$sql   .= "ORDER BY `".mysql_real_escape_string( $orderBy )."` ".mysql_real_escape_string( $sortOrder )." ";
    	$sql   .= "LIMIT ".mysql_real_escape_string( (int)$offset ).", ".mysql_real_escape_string( (int)$limit );
    	 
    	$res    = mysql_query( $sql ) OR die( mysql_error().'<br>'.$sql );
    	 
    	if( mysql_num_rows( $res ) > 0 ) {
    		while( $row = mysql_fetch_assoc( $res ) ) {
    			$CloneUI_User	= new CloneUI_User;
    			$row['owner_name']	= $CloneUI_User->fetchUsernameById( $row['owner_id'] );
    			$data[] = $row;
    		}
    
    		return $data;
    
    	} else {
    		return array();
    	}
    }  

	public function fetchMedia( $page, $limit = SITE_ADMIN_PAGINATION_ITEMS_PER_PAGE, $sortBy = 'upload_date', $sortOrder = 'DESC' )
	{
		$count = $this->fetchTotalMediaCount();

		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}
			
		if ($page > $totalPages) {
			$page = $totalPages;			
		}
			
		$offset	= ( $limit * $page ) - $limit;
			
		$sql	= "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "ORDER BY ".mysql_real_escape_string( $sortBy )." ".mysql_real_escape_string( $sortOrder )." ";
		$sql   .= "LIMIT ".mysql_real_escape_string( (int)$offset ).", ".mysql_real_escape_string( (int)$limit );
		
		$res	= mysql_query( $sql ) OR die( mysql_error() );
			
		$gridData				= array();
		$gridData['page']		= $page;
		$gridData['total']		= $totalPages;
		$gridData['records']	= $count;
		
		while( $row = mysql_fetch_assoc( $res ) ) {
			$CloneUI_User	= new CloneUI_User;
			$row['owner_name']	= $CloneUI_User->fetchUsernameById( $row['owner_id'] );			
			$gridData['rows'][] = $row;
		}
			
		return $gridData;		
	}

	public function fetchPagedMediaByUserId( $returnHtml = false, $userId, $page, $limit = SITE_DEFAULT_MEDIA_FETCH_LIMIT, $sortBy = 'upload_date', $sortOrder = 'DESC' )
	{
		$count = $this->fetchMediaCountByUserId( (int)$userId );
	
		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}
			
		if ($page > $totalPages) {
			$page = $totalPages;
		}
			
		$offset	= ( $limit * $page ) - $limit;
			
		$sql	= "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `owner_id` = '".mysql_real_escape_string( (int)$userId )."' ";		
		$sql   .= "ORDER BY ".mysql_real_escape_string( $sortBy )." ".mysql_real_escape_string( $sortOrder )." ";
		$sql   .= "LIMIT ".mysql_real_escape_string( (int)$offset ).", ".mysql_real_escape_string( (int)$limit );
	
		$res	= mysql_query( $sql ) OR die( mysql_error()."\n".$sql );
			
		$gridData				= array();
		$gridData['page']		= $page;
		$gridData['total']		= $totalPages;
		$gridData['records']	= $count;
	
		while( $row = mysql_fetch_assoc( $res ) ) {
			$CloneUI_User	= new CloneUI_User;
			$row['owner_name']	= $CloneUI_User->fetchUsernameById( $row['owner_id'] );
			$gridData['rows'][] = $row;
		}
		
		if( $returnHtml ) {
			$gridData['html'] = $this->fetchHtmlForUserMediaGrid( $gridData['rows'] );			
		}
			
		return $gridData;
	}

	public function fetchHtmlForUserMediaGrid( $data ) 
	{
		if( !empty( $data ) ) {
			$month	= array();
			$monthI	= 0;
			
			$html = '';
			
			foreach( $data AS $key => $value ) {
				$thisMonth = date( 'F', $value['upload_date'] ); 
				$monthI++; 
				$month[$thisMonth][] = $monthI;

				$html .= '<li class="photo">';
				$html .= '<div class="photo-wrapper">';
				
				if( count( $month[$thisMonth] ) == 1 ) {
					$html .= '<h3><span>'.$thisMonth.'</span>';
					$html .= '<span> </span>';
					$html .= '<span>'.date( 'Y', $value['upload_date'] ).'</span>';
					$html .= '</h3>';
				}

				$html .= '<a class="bg noBlockUI" target="_blank" href="'.BASEURL.'/p/'.$value['uuid'].'"></a>';
				$html .= '<time class="photo-date">';
				$html .= '<span>';
				$html .= '<span></span>';
				$html .= '<span>'.date( 'd', $value['upload_date'] ).'</span>';
				$html .= '<span> </span>';
				$html .= '<span>'.$thisMonth.'</span>';
				$html .= '<span> </span>';
				$html .= '<span>'.date( 'Y', $value['upload_date'] ).'</span>';
				$html .= '<span></span>';
				$html .= '</span>';
				$html .= '</time>';
				$html .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" ';
				$html .= 'data-timestamp="'.$value['upload_date'].'" ';
				$html .= 'data-mediaid="'.$value['id'].'" ';
				$html .= 'data-image="'.$value['url_path'].'" ';
				$html .= 'class="displayModal noBlockUI" target="_blank" ';
				$html .= 'href="'.BASEURL.'/p/'.$value['uuid'].'">';
				$html .= '<div src="'.$value['thumb_url_path'].'" class="Image iLoaded iWithTransition" ';
				$html .= 'style="background-image: url('.$value['thumb_url_path'].');"></div>';
				$html .= '<div class="photoShadow"></div>';
				$html .= '</a>';
				$html .= '<ul class="photo-stats">';
				$html .= '<li class="stat-likes">';
				$html .= '<b>492</b>';
				$html .= '</li>';
				$html .= '<li class="stat-comments">';
				$html .= '<b>2</b>';
				$html .= '</li>';
				$html .= '</ul>';
				$html .= '</div>';        			
				$html .= '</li>';			
			}

			return $html;
		}	
	}

	public function fetchTotalPagesAndMediaCount( $limit = SITE_ADMIN_PAGINATION_ITEMS_PER_PAGE )
	{
		$count = $this->fetchTotalMediaCount();
	
		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}

		$data				= array();		
		$data['totalPages'] = $totalPages;
		$data['count']		= $count;
		
		return $data;
	}
	
	public function fetchTotalPagesAndMediaCountByUserId( $userId, $limit = SITE_DEFAULT_MEDIA_FETCH_LIMIT )
	{
		$count = $this->fetchMediaCountByUserId( (int)$userId );
	
		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}
	
		$data				= array();
		$data['totalPages'] = $totalPages;
		$data['count']		= $count;
	
		return $data;
	}	

	public function fetchDataForMediaModal( $mediaId )
	{
		$mediaId = (int)$mediaId;
		
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( $mediaId )."' ";
		$sql   .= "LIMIT 1";
		
		$res    = mysql_query( $sql ) OR die( mysql_error() );
		
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );

			$data['comments']			= $this->_CloneUI_Media_Comments->fetchCommentsByMediaId( $mediaId );
			$data['has_liked']			= $this->_CloneUI_Likes->fetchLikeByUserId( $mediaId, $_SESSION['user']['id'], 'media' );
			$data['like_data']			= $this->_CloneUI_Likes->fetchAllLikesBySubjectId( $mediaId, 'media' );
			$data['next_media_item']	= $this->fetchDataForNextMediaId( $mediaId, $data['owner_id'] );
			$data['prev_media_item']	= $this->fetchDataForPreviousMediaId( $mediaId, $data['owner_id'] );
			
			return $data;
		
		} else {
			return array();
		}		
	}
	
	public function fetchDataForNextMediaId( $mediaId, $ownerId )
	{		
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `id` > '".mysql_real_escape_string( (int)$mediaId )."' ";
		$sql   .= "AND `owner_id` = '".mysql_real_escape_string( (int)$ownerId )."' ";
		$sql   .= "ORDER BY `id` ASC ";
		$sql   .= "LIMIT 1";
	
		$res    = mysql_query( $sql ) OR die( mysql_error() );
	
		if( mysql_num_rows( $res ) > 0 ) {
			$data				= mysql_fetch_assoc( $res );
			$data['comments']	= $this->_CloneUI_Media_Comments->fetchCommentsByMediaId( $mediaId );
			$data['has_liked']	= $this->_CloneUI_Likes->fetchLikeByUserId( $mediaId, $_SESSION['user']['id'], 'media' );
						
			return $data;
	
		} else {
			return array();
		}
	}

	public function fetchDataForPreviousMediaId( $mediaId, $ownerId )
	{
		$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `id` < '".mysql_real_escape_string( (int)$mediaId )."' ";
		$sql   .= "AND `owner_id` = '".mysql_real_escape_string( (int)$ownerId )."' ";
		$sql   .= "ORDER BY `id` DESC ";
		$sql   .= "LIMIT 1";
	
		$res    = mysql_query( $sql ) OR die( mysql_error() );
	
		if( mysql_num_rows( $res ) > 0 ) {
			$data				= mysql_fetch_assoc( $res );
			$data['comments']	= $this->_CloneUI_Media_Comments->fetchCommentsByMediaId( $mediaId );
			$data['has_liked']	= $this->_CloneUI_Likes->fetchLikeByUserId( $mediaId, $_SESSION['user']['id'], 'media' );
			
			return $data;
	
		} else {
			return array();
		}
	}

	public function fetchMediaBase64ById( $mediaId, $path )
	{
		$allowedPaths = array( 'thumb', 'mid', 'file' );
		
		if( !in_array( $path, $allowedPaths ) ) {
			return;			
		}
		
		$sql    = "SELECT `".mysql_real_escape_string( $path )."_path`, ";
		$sql   .= "`mime_type` ";		
		$sql   .= "FROM `".DB_TABLE_PREFIX."user_media` ";
		$sql   .= "WHERE `id` = '".mysql_real_escape_string( (int)$mediaId )."' ";		
		$sql   .= "LIMIT 1";
	
		$res    = mysql_query( $sql ) OR die( mysql_error() );
	
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );

			$base64			= 'data:'.$data['mime_type'].';base64,'.base64_encode( file_get_contents( $data[$path.'_path'] ) );			
			$contentLength	= strlen( $base64 ); 
									
			header('Content-Length: '.$contentLength);
			
			return $base64; 
		}
	}	
	 
    // END OF THIS CLASS
}