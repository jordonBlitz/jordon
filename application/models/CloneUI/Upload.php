<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * CloneUI Upload Model
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 - 2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Monday, August 26, 2013, 22:09 GMT+1 mknox
 * @edited      $Date: 2014-05-04 16:36:58 -0700 (Sun, 04 May 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Upload.php 40 2014-05-04 23:36:58Z hire@bizlogicdev.com $
 */

require_once('randlib.class.php');
require_once('PclZip/pclzip.lib.php');
require_once('PHPMailer/PHPMailerAutoload.php');

class CloneUI_Upload
{
	protected $_CloneUI_User;

	public function __construct()
	{
		$this->_CloneUI_User = new CloneUI_User;
	}
	
	public function fetchDownloadKeyForRecipient( $uploadId, $recipientEmail )
	{
		$sql	= "SELECT `custom_token` FROM `".DB_TABLE_PREFIX."recipients` ";
		$sql   .= "WHERE `parent_id` = '".mysql_real_escape_string( $uploadId )."' ";
		$sql   .= "AND `email` = '".mysql_real_escape_string( $recipientEmail )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysql_query( $sql ) OR die( mysql_error() );
			
		if( mysql_num_rows( $res ) > 0 ) {
			$data = mysql_fetch_assoc( $res );
			return $data['custom_token'];
		} else {
			return '';
		}		
	}
	
	public function notifyRecipients( $uploadId, $sender, $fileData = array(), $sendTo = array() )
	{
		$CloneUI_Files	= new CloneUI_Files;
		$uploadInfo			= $CloneUI_Files->fetchFileDataById( $uploadId );		
		$mail				= new PHPMailer;
		$sendToCount		= count( $sendTo );		
		
		foreach( $sendTo AS $sendToKey => $sendToValue ) {
			// START:	fetch custom token
			$token = $this->fetchDownloadKeyForRecipient( $uploadId, $sendToValue );			
			// END:		fetch custom token
			
			$mail->From		= SITE_EMAIL_ADDRESS;
			$mail->FromName	= SITE_NAME;
			$mail->addAddress( $sendToValue );
			$mail->addReplyTo( $sender );
			
			$mail->WordWrap = 50;
			$mail->isHTML( true );			
			
			$mail->Subject = '['.SITE_NAME.'] '.$sender.' ';
			$files = ( count( $fileData ) > 1 ) ? 'some files' : 'a file';
			$mail->Subject .= 'has sent you '.$files.' via '.SITE_NAME;
			
			$body = $sender.' has sent you the following files via '.SITE_NAME.':<br><br>';
			
			if( strlen( $uploadInfo['expiration_date'] ) ) {
				$body .= 'The file(s) will be available until ';
				$body .= date( 'F d, Y @ H:i:s T', $uploadInfo['expiration_date'] ).'.<br><br>';
			}
			
			if( !empty( $fileData ) ) {
				$totalFileSize = array();
				foreach( $fileData AS $key => $value ) {
					$totalFileSize[] = $value['bytes'];
				}
			
				$totalFileSizeReadable = bytesToHumanReadable( array_sum( $totalFileSize ) );
			
				$body .= '<br>Uploaded Files ('.$totalFileSizeReadable.' Total):  <br>';
				$body .= '<ol>';
			
				foreach( $fileData AS $key => $value ) {
					$body .= '<li>'.$value['name'].' ('.$value['size'].') </li>';
				}
			
				$body .= '</ol>';
			}
			
			if( strlen( $uploadInfo['comment'] ) ) {
				$body .= '<br>Message:<br><br>';
				$comment = str_replace( array("\r\n", "\n", "\r"), '<br>', $uploadInfo['comment'] );
				$comment = stripcslashes( $comment );
				$comment = stripslashes( $comment );
				$body .= nl2br( $comment );				
			}
			
			$body .= '<br><br><br>Download:<br><br><a target="_blank" href="'.BASEURL.'/transfer/'.$token.'">'.BASEURL.'/transfer/'.$token.'</a>';
			
			$body .= '<br><br><br>Thank you, ';
			$body .= '<br>'.SITE_NAME;
			$body .= '<br>'.BASEURL;
			
			$mail->Body = $body;
			
			$body = $sender." has sent you the following files via ".SITE_NAME."\r\n\r\n";
			
			if( strlen( $uploadInfo['expiration_date'] ) ) {
				$body .= "The file(s) will be available until ";
				$body .= date( 'F d, Y @ H:i:s T', $uploadInfo['expiration_date'] ).".\r\n\r\n";
			}
			
			if( !empty( $fileData ) ) {
				$body .= "\rnUploaded Files (".$totalFileSizeReadable." Total):  ";
				$body .= "\r\n\r\n";
			
				foreach( $fileData AS $key => $value ) {
					$body .= "\r\n".$value['name'].' ('.$value['size'].')';
				}
			}
			
			if( strlen( $uploadInfo['comment'] ) ) {
				$body .= "\r\n\r\nMessage:\r\n\r\n";
				$comment = stripcslashes( $comment );
				$comment = stripslashes( $comment );	
				$body .= $comment;
			}
			
			$body .= "\r\n\r\n\r\nDownload:\r\n\r\n".BASEURL."/transfer/".$token;
			
			$body .= "\r\n\r\n\r\nThank you,  ";
			$body .= "\r\n".SITE_NAME;
			$body .= "\r\n".BASEURL;
			
			$mail->AltBody = $body;
			
			if( !$mail->send() ) {
				return $mail->ErrorInfo;
			}			
		}
		
		return true;		
	}
	
	public function notifyUploaderOfDownload( $uploadId, $recipientId )
	{
		$CloneUI_Files	= new CloneUI_Files;
		$uploadInfo			= $CloneUI_Files->fetchFileDataById( $uploadId );
		$downloaderInfo		= $CloneUI_Files->fetchRecipientDataById( $recipientId );
		$files				= $CloneUI_Files->fetchAllFilesByParentId( $uploadId );
		$uploaderInfo		= $this->_CloneUI_User->fetchUserDetailsById( $uploadInfo['uploader'] );
		
		$mail				= new PHPMailer;
		$mail->From			= SITE_EMAIL_ADDRESS;
		$mail->FromName 	= SITE_NAME;
		$mail->addAddress( $uploaderInfo['email'] );
		$mail->addReplyTo( SITE_EMAIL_ADDRESS, SITE_NAME );
		
		$mail->WordWrap = 50;
		$mail->isHTML( true );
		
		$mail->Subject = '['.SITE_NAME.'] Download confirmation from '.$downloaderInfo['email'].' ';
		$mail->Subject .= 'via '.SITE_NAME;
				
		$body  = $downloaderInfo['email'].' has successfully downloaded the following file(s) ';
		$body .= 'that you sent via '.SITE_NAME.'<br><br>';		
		$body .= 'Files ('.bytesToHumanReadable( $uploadInfo['total_file_size'] ).' total)<br>';
						
		if( !empty( $files ) ) {
			$body .= '<ol>';
		
			foreach( $files AS $key => $value ) {
				$body .= '<li>'.basename( $value['file_path'] ).' ('.$value['file_size'].') </li>';
			}
				
			$body .= '</ol>';
		}
					
		if( strlen( $uploadInfo['comment'] ) ) {
			$body .= '<br>Message:<br><br>';
			$comment = str_replace( array("\r\n", "\n", "\r"), '<br>', $uploadInfo['comment'] );
			$comment = stripcslashes( $comment );
			$comment = stripslashes( $comment );
			$body .= nl2br( $comment );
		}
				
		$body .= '<br><br><br>Thank you, ';
		$body .= '<br>'.SITE_NAME;
		$body .= '<br>'.BASEURL;
		
		$mail->Body = $body;
		
		$body  = $downloaderInfo['email']." has successfully downloaded the following file(s) ";
		$body .= "that you sent via ".SITE_NAME."\r\n\r\n";
		$body .= "Files (".bytesToHumanReadable( $uploadInfo['total_file_size'] )." total)\r\n";
		
		if( !empty( $files ) ) {				
			foreach( $files AS $key => $value ) {
				$body .= "\r\n".basename( $value['file_path'] )." (".$value['file_size'].")";
			}
		}
		
		if( strlen( $uploadInfo['comment'] ) ) {
			$body .= "\r\n\r\nMessage:\r\n\r\n";
			$comment = stripcslashes( $comment );
			$comment = stripslashes( $comment );
			$body .= $comment;
		}
		
		$body .= "\r\n\r\n\r\nThank you,  ";
		$body .= "\r\n".SITE_NAME;
		$body .= "\r\n".BASEURL;
		
		$mail->AltBody = $body;		
		
		if( !$mail->send() ) {		
			return $mail->ErrorInfo;
		}			
				
		return true;		
	} 
	
	public function notifyUploader( $email, $token, $fileData = array(), $sendTo = array() )
	{
		$CloneUI_Files	= new CloneUI_Files;
		$uploadInfo			= $CloneUI_Files->fetchFileDataByToken( $token ); 
				
		$mail				= new PHPMailer;		
		$mail->From			= SITE_EMAIL_ADDRESS;
		$mail->FromName 	= SITE_NAME;
		$mail->addAddress( $email );
		$mail->addReplyTo( SITE_EMAIL_ADDRESS, SITE_NAME );
		
		$mail->WordWrap = 50;
		$mail->isHTML( true );		
		
		$sendToCount = count( $sendTo );
		
		$mail->Subject = '['.SITE_NAME.'] Thanks for using '.SITE_NAME.' - ';
		$mail->Subject .= 'file sent to '.$sendTo[0];		
		
		if( $sendToCount > 2 ) {
			$mail->Subject .= ' (& '.$sendToCount.' others)';			
		} elseif ( $sendToCount == 2 ) {
			$mail->Subject .= ' & '.$sendTo[1];			
		}
						
		$body  = 'Your recent upload to '.SITE_NAME.' was successful. <br>You will be notified via email ';
		$body .= 'when one of your recipients downloads it.<br><br>';
		
		if( strlen( $uploadInfo['expiration_date'] ) ) {
			$body .= 'The file(s) will be deleted on '.date( 'F d, Y @ H:i:s T', $uploadInfo['expiration_date'] ).'.<br><br>';			
		}
		
		$body .= 'Recipient(s):<br>';
		$body .= '<ol>';
		foreach( $sendTo AS $key => $value ) {
			$body .= '<li><a href="mailto:'.$value.'">'.$value.'</a></li>';
		}
		$body .= '</ol>';
		
		if( !empty( $fileData ) ) {
			$totalFileSize = array();						
			foreach( $fileData AS $key => $value ) {
				$totalFileSize[] = $value['bytes'];
			}			
						 
			$totalFileSizeReadable = bytesToHumanReadable( array_sum( $totalFileSize ) );
						
			$body .= '<br>Uploaded Files ('.$totalFileSizeReadable.' Total):  <br>';			
			$body .= '<ol>';

			foreach( $fileData AS $key => $value ) {
				$body .= '<li>'.$value['name'].' ('.$value['size'].') </li>';
			}
			
			$body .= '</ol>';
		}
		
		if( strlen( $uploadInfo['comment'] ) ) {
			$body .= '<br>Message:<br><br>';
			// fix escaped text			
			$comment = str_replace( array("\r\n", "\n", "\r"), '<br>', $uploadInfo['comment'] );
			$comment = stripcslashes( $comment );
			$comment = stripslashes( $comment );						
			$body .= nl2br( $comment );
		}		
		
		$body .= '<br><br><br>Download:<br><br><a target="_blank" href="'.BASEURL.'/transfer/'.$token.'">'.BASEURL.'/transfer/'.$token.'</a>';		

		$body .= '<br><br><br>Thank you, ';
		$body .= '<br>'.SITE_NAME;
		$body .= '<br>'.BASEURL;
		
		$mail->Body = $body;
		
		$body  = "\r\n\r\nYour recent upload to ".SITE_NAME." was successful.\r\n You will be notified via email  ";
		$body .= "\r\nwhen one of your recipients downloads it.\r\n\r\n";
		
		if( strlen( $uploadInfo['expiration_date'] ) ) {
			$body .= "The file(s) will be deleted on ".date( 'F d, Y @ H:i:s T', $uploadInfo['expiration_date'] ).".\r\n\r\n";
		}		
		
		$body .= "Recipient(s):\r\n\r\n";
		foreach( $sendTo AS $key => $value ) {
			$body .= $value."\r\n";
		}
		
		if( !empty( $fileData ) ) {
			$body .= "\rnUploaded Files (".$totalFileSizeReadable." Total):  ";
			$body .= "\r\n\r\n";
			
			foreach( $fileData AS $key => $value ) {
				$body .= "\r\n".$value['name'].' ('.$value['size'].')';
			}			
		}
		
		if( strlen( $uploadInfo['comment'] ) ) {
			$body .= "\r\n\r\nMessage:\r\n\r\n";
			// fix escaped text
			$comment = stripcslashes( $comment );
			$comment = stripslashes( $comment );
						
			$body .= $comment;
		}

		$body .= "\r\n\r\n\r\nDownload:\r\n\r\n".BASEURL."/transfer/".$token;
				
		$body .= "\r\n\r\n\r\nThank you,  ";
		$body .= "\r\n".SITE_NAME;
		$body .= "\r\n".BASEURL;
		
		$mail->AltBody = $body;
		
		if( !$mail->send() ) {
			return $mail->ErrorInfo;
		}
		
		return true;		
	}	
	
	public function zipFiles( $token, $destination, $files = array() )
	{
		if( empty( $files ) ) {
			return false;	
		}	
				
		$archive	= new PclZip( $destination.'/'.SITE_ARCHIVE_PREFIX.$token.'.zip');
		$filesToZip	= implode( ',', $files );
		$zip		= $archive->create( $filesToZip, PCLZIP_OPT_REMOVE_ALL_PATH );
		
		if( $zip ) {
			return true;	
		}
	}
	
	public function deleteTempFilesAndDir( $files )
	{
		if( empty( $files ) ) {
			return;	
		}
		
		$dir = str_replace( basename( $files[0] ), '', $files[0] );
		
		if( preg_match( BASEDIR.'/data/temp', $dir ) ) {
			if( $dir != BASEDIR.'/data/temp' ) {
				delTree( $dir );
				return true;
			}	
		}
		
		return false;		
	}

    /**
     * Add files to the DB
     *
     * @param   array	$data
     * @param   array	$uploadedFiles
     * @return  boolean
    */
    public function addFiles( $data = array(), $uploadedFiles = array() )
    {    		    	
    	if( empty( $data ) ) {
    		return;
    	}
    	
    	$count	= count( $data );
    	$i		= 0;
    	
    	$sql	= "INSERT INTO `".DB_TABLE_PREFIX."uploads` ( ";
    	foreach( $data AS $key => $value ) {
    		$i++;
    		$comma = ( $i < $count ) ? ', ' : ' ';
    		$key = mysql_real_escape_string( $key );
    		$sql .= "`".mysql_real_escape_string( $key )."` ".$comma;
    	}    	
		$sql .= ") VALUES ( ";
		
    	$i = 0;
    	foreach( $data AS $key => $value ) {
    		$i++;
    		$comma = ( $i < $count ) ? ', ' : ' '; 
    		
    		if( $key == 'comment' ) {
    			// replace line breaks
    			$value = str_replace( array("\r\n", "\n", "\r"), '<br>', $value );
    			// replace escape apostrophes
    			$value = stripcslashes( $value );
    			$value = stripslashes( $value );
    		}
    		   		
    		$value = mysql_real_escape_string( $value );
    		$sql .= "'".mysql_real_escape_string( $value )."' ".$comma;
    	}
    	
    	$sql   .= ");";
        $res    = mysql_query( $sql ) OR die( mysql_error()."\nSQL:  ".$sql );
        
        $dbId	= mysql_insert_id();
        
        $this->addUploadedFiles( $dbId, $uploadedFiles );        
        $this->_CloneUI_User->updateUserById( $data['uploader'], array('last_upload' => time() ) );

		return $dbId;
    }
    
    public function addUploadedFiles( $parentId, $data = array() )
    {
    	if( empty( $data ) ) {
    		return false;
    	}
    	 
    	$count	= count( $data );
    	$i		= 0;

    	foreach( $data AS $key => $value ) {
    		$sql = "INSERT INTO `".DB_TABLE_PREFIX."uploaded_files` ( ";
 			$sql .= "`parent_id` , `file_path`, `file_size` ";
			$sql .= " ) VALUES ( ";
			$sql .= " '".mysql_real_escape_string( $parentId )."', ";
			$sql .= "'".mysql_real_escape_string( $value )."', ";
			$sql .= "'".mysql_real_escape_string( filesize( $value ) )."' ";			
			$sql .= "); ";
			
    		$res    = mysql_query( $sql ) OR die( mysql_error()."\nSQL:  ".$sql );    		
    	}
    
    	return true;
    }    
    
    public function handleTempFileUpload( $filePath, $fileData = array() ) 
    {    	
    	extract( $fileData );
    	    	
    	$fileExt	= strtolower( $fileExt );
    	$filename	= strtolower( $filename ).'.'.$fileExt;
    	$uuid		= ( isset( $uuid ) ) ? $uuid : '';    	
    	$tempPath	= BASEDIR.'/data/temp/'.$uuid;
    	$tempFile	= $tempPath.'/'.$filename;    	 
    	
    	if( !file_exists( $tempPath ) ) {
			mkdir( $tempPath, 0777, true );    		
    	}
    	 
    	$upload = rename( $filePath, $tempFile );
    	$json	= array();
    	
    	if( $upload ) {    		    	
			$json['status'] = 'OK';			
			return json_encode( $json );
    	} else {
    		$json['status']	= 'ERROR';
    		$json['error']	= 'FILE_UPLOAD';
    		
    		return json_encode( $json );    		
    	}    	
    }    	
    
    public function completeFileUpload( $fileData = array() ) 
    {    	    	
    	extract( $fileData );

    	$sendTo		= explode( ',', $fileData['recipients'] );
    	$randlib	= new random();
		$tempPath	= BASEDIR.'/data/temp/'.$uuid;
		$files		= glob( $tempPath.'/*' );
		
		if( !empty( $files ) ) {
			$fileDetails	= array();
			$totalFilesize	= array();
			
			foreach( $files AS $key => $value ) {
				$totalFilesize[]			= filesize( $value );
				$fileDetails[$key]['name']	= basename( $value );
				$fileDetails[$key]['size']	= bytesToHumanReadable( filesize( $value ) );
				$fileDetails[$key]['bytes']	= filesize( $value );				 
			}	
		}
    	        
		$data			= array();
    	$data['uuid']	= $uuid;
    	$data['token']	= $randlib->generateRandomString( rand( SITE_TOKEN_MIN_LENGTH, SITE_TOKEN_MAX_LENGTH ) );
    	
    	if( strlen( trim( $fileMessage ) ) ) {
    		$data['comment'] = $fileMessage;    		
    	}
    	
    	$data['upload_date']		= time();
    	$data['expiration_date']	= time() + hoursToSeconds( SITE_GUEST_UPLOAD_RETENTION );
    	$data['uploader_ip']		= $_SERVER['REMOTE_ADDR'];

		if( !$this->_CloneUI_User->usernameExists( $email ) ) {
			$userData			= array();
			$userData['email']	= $email;
			
			$createUser = $this->_CloneUI_User->createUser( $userData );
		}
		
		$user = $this->_CloneUI_User->fetchUserDetailsByUsername( $email );

		if( !empty( $user ) ) {
			$data['uploader']			= $user['id'];
			$data['direct_url'] 		= PROTOCOL_RELATIVE_URL.'/transfer/'.$data['token'];
			$destination				= BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$user['id'].'/'.$uuid;			
			$data['file_path']			= $destination.'/'.SITE_ARCHIVE_PREFIX.$data['token'].'.zip';
			$data['total_file_size']	= array_sum( $totalFilesize );			
			
			if( !file_exists( $destination ) ) {
				mkdir( $destination, 0777, true );
			}
			
			if( file_exists( $destination ) ) {
				$zip = $this->zipFiles( $data['token'], $destination, $files );								
			}
			
			if( $zip ) {
				$delete = deltree( $tempPath );
				
				if( !$delete ) {
					error_log( "[".date("m-d-Y, H:i:s")."] ERROR:  failed to delete files in ".$tempPath."\n" );	
				}
								
				// insert in the DB
				$dbId = (int)$this->addFiles( $data, $files );
					
				if( $dbId > 0 ) {
					// START:	add recipients to DB
					$this->addRecipients( $sendTo, $dbId );					
					// END:		add recipients to DB	
									
					$notify = $this->notifyUploader( $email, $data['token'], $fileDetails, $sendTo );
					if( !$notify ) {
						error_log( "[".date("m-d-Y, H:i:s")."] ERROR:  failed to notify ".$email." about upload success of ".$uuid."\n" );
					}
					
					$notify = $this->notifyRecipients( $dbId, $email, $fileDetails, $sendTo );
					if( !$notify ) {
						error_log( "[".date("m-d-Y, H:i:s")."] ERROR:  failed to notify recipients about available download of ".$uuid."\n" );
					}					
										
					$json			= array();
					$json['status']	= 'OK';
						
					// return JSON
					return json_encode( $json );
				}				
			} else {
				$json			= array();
				$json['status']	= 'ERROR';
				$json['error']	= 'FILE_ZIP';
				
				// return JSON
				return json_encode( $json );				
			}			
		}   			    	
    }

    public function addRecipients( $sendTo = array(), $fileId )
    {
    	if( empty( $sendTo ) ) {
    		return false;	
    	}
    	
    	$randlib = new random();

    	foreach( $sendTo AS $key => $value ) {
    		$token = $randlib->generateRandomString( rand( SITE_TOKEN_MIN_LENGTH, SITE_TOKEN_MAX_LENGTH ) );
    		
    		$sql = "INSERT IGNORE INTO `".DB_TABLE_PREFIX."recipients` ( ";
    		$sql .= "`parent_id`, ";
    		$sql .= "`custom_token`, ";
    		$sql .= "`email` ";
    		$sql .= ") VALUES ( ";
    		$sql .= "'".mysql_real_escape_string( $fileId )."', "; 
    		$sql .= "'".mysql_real_escape_string( $token )."', "; 
    		$sql .= "'".mysql_real_escape_string( $value )."' ";
    		$sql .= "); ";
    		    		
			$res = mysql_query( $sql ) OR die( mysql_error()."\nSQL:  ".$sql );
    	}    	

		return true;    	
    }
}