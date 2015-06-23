<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Admin Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 - 2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Saturday, August 31, 2013, 19:48 GMT+1
 * @modified    $Date: 2014-06-14 09:21:49 -0700 (Sat, 14 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: AdminController.php 56 2014-06-14 16:21:49Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     CloneUI.com Base Framework
*/

class AdminController extends Zend_Controller_Action
{ 
	protected $_params;
	protected $_requestUri;
	protected $_CloneUI_Admin;
	protected $_CloneUI_Site_Config;
	protected $_CloneUI_Site_Phrase;
	protected $_CloneUI_Site_Permission;
	protected $_CloneUI_User;
	protected $_CloneUI_Usergroup;
		
    public function init() 
    {  
    	$this->_params				= $this->getRequest()->getParams();
    	$this->_requestUri			= $this->getRequest()->getRequestUri();
    	$this->_CloneUI_Admin			= new CloneUI_Admin;
    	$this->_CloneUI_Site_Config		= new CloneUI_Site_Config;
    	$this->_CloneUI_Site_Phrase		= new CloneUI_Site_Phrase;
    	$this->_CloneUI_Site_Permission	= new CloneUI_Site_Permission;
    	$this->_CloneUI_Usergroup		= new CloneUI_Usergroup;
    	$this->_CloneUI_User			= new CloneUI_User;    	       	    	
    	
    	$actionName = strtolower( Zend_Controller_Front::getInstance()->getRequest()->getActionName() );
		switch( $actionName ) {
			case 'ajax':
			case 'login':
			case 'logout':
				break;
				
			default:
			    if( !is_array( @$_SESSION['site']['permissions']['admin'] ) ) {
			        return $this->_forward('login');
			    }
			    
				if( !in_array( 'can_admin_site', @$_SESSION['site']['permissions']['admin'] ) ) {
					// $this->_forward($action, $controller = null, $module = null, array $params = null)
					return $this->_forward('login');
				}								
		}
    }
    
    public function usergroupAction()
    {
		$params = $this->_params;
    	if( !isset( $params['edit'] ) ) {
    		throw new Zend_Controller_Action_Exception('This page does not exist', 404);
    	} else {
    		$params['edit'] = (int)$params['edit'];
    		if( !empty( $_POST ) ) {
    			if( in_array( 'can_admin_usergroups', $_SESSION['site']['permissions']['admin'] ) ) {    					
    				$this->_CloneUI_Usergroup->updateUsergroupById( $params['edit'], $_POST['usergroup'] );    					    				
    			}
    			if( !empty( $_POST['permissions'] ) ) {
    				if( in_array( 'can_admin_usergroup_permissions', $_SESSION['site']['permissions']['admin'] ) ) {
    					$this->_CloneUI_Usergroup->updateUsergroupPermissionsById( $params['edit'], $_POST['permissions'] );
    				}    				
    			} else {
    				$this->_CloneUI_Usergroup->removeAllUsergroupPermissionsById( $params['edit'] );    				
    			}   			
    		}    		
    		$usergroup = $this->_CloneUI_Usergroup->fetchUsergroupById( $params['edit'] );
    		if( !empty( $usergroup ) ) {
    			$usergroup['permissions'] = $this->_CloneUI_Site_Permission->fetchUsergroupPermissionsByUsergroupId( array( $usergroup['id'] ) );    			
    			$this->view->allPerms = $this->_CloneUI_Site_Permission->fetchAllSitePermissions();    			
				$this->view->usergroup = $usergroup;    			
    		} else {
    			throw new Zend_Controller_Action_Exception('This page does not exist', 404);
    		}
    	}
    }
    public function profileAction() 
    {    	
    	$params = $this->_params;
    	if( !isset( $params['edit'] ) ) {
    		throw new Zend_Controller_Action_Exception('This page does not exist', 404);
    	} else {
    		$params['edit'] = (int)$params['edit'];
    		if( !empty( $_POST ) ) {
    			if( in_array( 'can_admin_users', $_SESSION['site']['permissions']['admin'] ) ) {
    				if( !strlen( trim( $_POST['password'] ) ) ) {
    					unset( $_POST['password'] );	
    				} else {
    					$_POST['password'] = sha1( $_POST['password'] );	
    				}
    				if( isset( $_POST['usergroups'] ) ) {    					    					
    					$this->_CloneUI_User->changerUsergroupsByUserId( $params['edit'], $_POST['usergroups'] );  					
    				} else {
    					$this->_CloneUI_User->updateUserById( $params['edit'], $_POST );    					
    				}    				
    			}    			    			
    		}
    		$this->view->usergroups = $this->_CloneUI_Usergroup->fetchAllUsergroups();    		
    		$user = $this->_CloneUI_User->fetchUserDetailsById( $params['edit'] );
    		if( !empty( $user ) ) {
				$this->view->user = $user;  
				$this->view->CloneUI_User = $this->_CloneUI_User;  			
    		} else {
    			throw new Zend_Controller_Action_Exception('This page does not exist', 404);
    		}
    	}
    }
    
    public function settingsAction()
    {
    	$this->_forward('index');
    }    
    
    public function usergroupPermissionsAction()
    {
    	$usergroupId = (int)$this->getRequest()->getParam('id');

    	if( empty( $usergroupId ) ) {
    		$this->_forward('usergroups');
    	} else {
    		if( !empty( $_POST['usergroup'] ) ) {
    			$this->_CloneUI_Usergroup->updateUsergroupById( $usergroupId, $_POST['usergroup'] );
    			$this->view->update = true;
    		}
    		 
    		$usergroup = $this->_CloneUI_Usergroup->fetchUsergroupById( $usergroupId );   		
    		
    		if( !empty( $usergroup ) ) {
    			$this->view->usergroup = $usergroup;
    		} else {
    			// display error
    		}    		
    	}    	
    }
    
    public function usergroupEditAction()
    {
    	$usergroupId = (int)$this->getRequest()->getParam('id');    			
    	
    	if( !empty( $_POST['usergroup'] ) ) {
    		$this->_CloneUI_Usergroup->updateUsergroupById( $usergroupId, $_POST['usergroup'] );
    		$this->_CloneUI_Usergroup->updateUsergroupPermissionsById( $usergroupId, $_POST['permissions'] );    		
    		$this->view->update = true;
    	}
    	 
    	$usergroup = $this->_CloneUI_Usergroup->fetchUsergroupById( $usergroupId );
    	$this->view->allPerms = $this->_CloneUI_Site_Permission->fetchAllSitePermissions();
  	    	
    	if( !empty( $usergroup ) ) {  
    		$usergroup['permissions'] = $this->_CloneUI_Site_Permission->fetchUsergroupPermissionsByUsergroupId( array( $usergroup['id'] ) );    		  		    		    		    		
    		$this->view->usergroup = $usergroup;
    	} else {
    		// display error
    	}    	
    }    
    
    public function usergroupsAction()
    {
    	$usergroups = $this->_CloneUI_Usergroup->fetchAllUsergroups();
    	
    	if( !empty( $usergroups ) ) {
    		foreach( $usergroups AS $key => $value ) {    	
    			$usergroups[$key]['edit'] = '<a href="'.PROTOCOL_RELATIVE_URL.'/admin/usergroup-edit/id/'.$value['id'].'" title="Edit" alt="Edit"><span style="float: left" class="ui-icon ui-icon-pencil"></span></a> <a data-name="'.$value['name'].'" data-id="'.$value['id'].'" class="noBlockUI deleteUsergroup" href="#" title="Delete" alt="Delete"><span style="float: left" class="ui-icon ui-icon-trash"></span></a>';
    		}
    	}
    	    	
    	$this->view->usergroups = $usergroups;
    }
    
    public function userEditAction()
    {    	    	
		$userId = (int)$this->getRequest()->getParam('id');
		if( $userId == 0 ) {
			$this->_forward('users');	
		} else {
			
			if( !empty( $_POST['user'] ) ) {
				$this->_CloneUI_User->updateUserById( $userId, $_POST['user'] );
				$this->view->update = true;
			}			
			
			$user = $this->_CloneUI_User->fetchUserDetailsById( $userId );
			if( !empty( $user ) ) {
				$this->view->user = $user;	
			} else {
				// display error	
			}	
		}    	
    }
    
    public function userAddAction()
    {    	
    	if( !empty( $_POST ) ) {
    		$result = $this->_CloneUI_User->createUser( $_POST['user'] );
    		return $result;
    	} else {
    		$this->view->usergroups = $this->_CloneUI_Usergroup->fetchAllUsergroups();    		
		}    	
    }
    
    public function usersAction()
    {
    	if( !in_array( 'can_admin_users', $_SESSION['site']['permissions']['admin'] ) ) {
    		// $this->_forward($action, $controller = null, $module = null, array $params = null)
    		$this->_forward('login');
    	}
    	    	
    	$users = $this->_CloneUI_User->fetchAllUsers( array('id',  
    															'email', 
    															'site_status', 
    															'last_ip',
    															'last_active'
    	));
    	
    	if( !empty( $users ) ) {
			foreach( $users AS $key => $value ) {
				if( isset( $value['avatar_url'] ) ) {
					$users[$key]['avatar_url'] = ( strlen( $value['avatar_url'] ) ) ? $value['avatar_url'] : SITE_DEFAULT_AVATAR_URL;
				}
								
				if( isset( $value['username'] ) ) {
					$users[$key]['username_raw'] 	= $value['username'];					
					$users[$key]['username']		= '<a class="noBlockUI" target="_blank" href="'.PROTOCOL_RELATIVE_URL.'/'.$value['username'].'">'.$value['username'].'</a>';
				}

				$users[$key]['edit'] = '<a href="'.PROTOCOL_RELATIVE_URL.'/admin/user-edit/id/'.$value['id'].'" title="Edit" alt="Edit"><span style="float: left" class="ui-icon ui-icon-pencil"></span></a> <a data-username="'.$value['username'].'" data-userid="'.$value['id'].'" class="noBlockUI deleteUser" href="#" title="Delete" alt="Delete"><span style="float: left" class="ui-icon ui-icon-trash"></span></a>';
			}    		
    	}
    	
    	$this->view->users = $users;
    }

    public function indexAction() 
    {    	
    	if( !in_array( 'can_admin_site', $_SESSION['site']['permissions']['admin'] ) ) {
    		// $this->_forward($action, $controller = null, $module = null, array $params = null)
			$this->_forward('login');
    	} else {
    		if( !empty( $_POST['config'] ) ) {
    			$this->_CloneUI_Site_Config->updateSiteConfig( $_POST['config'] );
    			$this->view->update = true;
    		}
    		    		
    		$siteConfig = $this->_CloneUI_Site_Config->fetchSiteConfigGrouped();
    		$this->view->siteConfig = $siteConfig;
    	}
    }
    
    public function loginAction()
    {
    	if( !empty( $_POST ) ) {
    		$result = $this->_CloneUI_User->login( $_POST['username'], $_POST['password'] );
    		if( $result == 'LOGIN_OK' ) {
				if( in_array( 'can_admin_site', @$_SESSION['site']['permissions']['admin'] ) ) {    	
					header( 'Location: '.BASEURL.'/admin');
					exit;
    			}    			
    		}
    	} else {    	    
    		if( @in_array( 'can_admin_site', @$_SESSION['site']['permissions']['admin'] ) ) {
				header('Location: '.BASEURL.'/admin');
				exit;
    		}    		
    	}    	    	
    } 
    
    public function logoutAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
		session_unset();
		session_destroy();
		
		header('Location: '.BASEURL.'/admin');		
    }       

    public function accountAction()
    {
    	if( !in_array( 'can_admin_site', $_SESSION['site']['permissions']['admin'] ) ) {
    		// $this->_forward($action, $controller = null, $module = null, array $params = null)
    		$this->_forward('login');
    	}
    	    	
    	$this->view->me = $this->_CloneUI_User->fetchUserDetailsById( $_SESSION['user']['id'] );
    }
    
    public function phrasesAction()
    {
    	if( !in_array( 'can_admin_site_phrases', $_SESSION['site']['permissions']['admin'] ) ) {
    		// $this->_forward($action, $controller = null, $module = null, array $params = null)
    		$this->_forward('login');
    	}
    	    	
    	if( !empty( $_POST ) ) {
			// $_POST['id'] is an array of phrases    		
    		$this->_CloneUI_Site_Phrase->updateSitePhrases( $_POST['id'] );
    		$this->view->update = true;
    	}
    	
    	$phrases = $this->_CloneUI_Site_Phrase->fetchAllPhrases();
    	foreach( $phrases AS $key => $value ) {
    		$phrases[$key]['friendly_name'] = CloneUI_Language::fetchFriendlyNameById( $value['language_id'] );	
    	}
    	
    	// START:	sort by language name
    	$phrasesFinal = array();
    	foreach( $phrases AS $key => $value ) {
    		$phrasesFinal[$value['friendly_name']][] = $value;
    	}
    	// END:		sort by languaga name
    	
    	$this->view->phrases = $phrasesFinal;
    }
    
    public function ajaxAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	    	
    	if( $_POST['method'] != 'login' ) {
    		if( !in_array( 'can_admin_site', $_SESSION['site']['permissions']['admin'] ) ) {
    			header( 'Location: '.BASEURL.'');
    			exit;
    		}    		
    	} else {
    		$result		= $this->_CloneUI_User->login( $_POST['username'], $_POST['password'] );
    		$json		= array();
    		$json['status']	= $result;
    		
			exit( json_encode( $json ) );    		
    	}    	
    	    	
		if( empty( $_POST ) ) {
			header('Location: '.BASEURL.'/admin');
			return;			
		}
		
		header('Content-Type: application/json');

		switch( $_POST['method'] ) {				
			case 'addUser':
				$result	= $this->_CloneUI_User->createUser( $_POST['data']['user'] );
				if( (int)$result > 0 ) {
					$json['status'] = 'OK';
					$json['userid'] = (int)$result;
				} else {
					$json['status'] = 'ERROR';
					$json['error']	= $result;
				}
				
				exit( json_encode( $json ) );
				
				break;
				
			case 'avatar-upload':
				// START:	chunk handling
				header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
				header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
				header('Cache-Control: no-store, no-cache, must-revalidate');
				header('Cache-Control: post-check=0, pre-check=0', false);
				header('Pragma: no-cache');
				$cleanupTargetDir	= true;
				$targetDir			= BASEDIR.'/data/temp';
				// Temp file age in seconds
				$maxFileAge			= 5 * 3600;
				$chunk				= isset( $_REQUEST['chunk'] ) ? intval( $_REQUEST['chunk'] ) : 0;
				$chunks				= isset( $_REQUEST['chunks'] ) ? intval( $_REQUEST['chunks'] ) : 0;
				// create target directory
				if( !file_exists( $targetDir ) ) {
					@mkdir( $targetDir );
				}
				// check for filename
				if (isset($_REQUEST['name'])) {
					$fileName = $_REQUEST['name'];
				} elseif (!empty($_FILES)) {
					$fileName = $_FILES['file']['name'];
				} else {
					$fileName = uniqid('file_');
				}
				$filePath = $targetDir . DIRECTORY_SEPARATOR . $fileName;
				// Remove old temp files
				if( $cleanupTargetDir ) {
					if ( !is_dir( $targetDir ) || !$dir = opendir( $targetDir ) ) {
						die('{"jsonrpc" : "2.0", "error" : {"code": 100, "message": "Failed to open temp directory."}, "id" : "id"}');
					}
					while (($file = readdir($dir)) !== false) {
						$tmpfilePath = $targetDir . DIRECTORY_SEPARATOR . $file;
						// If temp file is current file proceed to the next
						if ($tmpfilePath == "{$filePath}.part") {
							continue;
						}
						// Remove temp file if it is older than the max age and is not the current file
						if (preg_match('/\.part$/', $file) && (filemtime($tmpfilePath) < time() - $maxFileAge)) {
							@unlink($tmpfilePath);
						}
					}
					closedir($dir);
				}
				// Open temp file
				if (!$out = @fopen("{$filePath}.part", $chunks ? "ab" : "wb")) {
					die('{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}');
				}
				if (!empty($_FILES)) {
					if ($_FILES["newAvatar"]["error"] || !is_uploaded_file($_FILES["newAvatar"]["tmp_name"])) {
						die('{"jsonrpc" : "2.0", "error" : {"code": 103, "message": "Failed to move uploaded file."}, "id" : "id"}');
					}
					// Read binary input stream and append it to temp file
					if (!$in = @fopen($_FILES["newAvatar"]["tmp_name"], "rb")) {
						die('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');
					}
				} else {
					if (!$in = @fopen("php://input", "rb")) {
						die('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');
					}
				}
				while ($buff = fread($in, 4096)) {
					fwrite($out, $buff);
				}
				@fclose($out);
				@fclose($in);
				// check if file has been uploaded
				if (!$chunks || $chunk == $chunks - 1) {
					// Strip the temp .part suffix off
					rename("{$filePath}.part", $filePath);
				} else {
					// Return Success JSON-RPC response
					exit( json_encode( array('chunk'		=> $_REQUEST['chunk'],
											 'totalChunks'	=> $_POST['chunks']
											)
									)
					);
				}
				// END:		chunk handling
				if( !empty( $_POST ) AND !empty( $_FILES ) ) {
					$result	= $this->_CloneUI_User->adminUploadAvatarByFilename( $_POST['userId'], $filePath );
					$json	= $result;
					exit( json_encode( $json ) );					
				}
				break;
			case 'admin-delete-avatar':
				$result = $this->_CloneUI_User->adminDeleteUserAvatar( $_POST['userId'] );
				$json	= array();
				if( $result['status'] == 'OK' ) {
					$json = $result;
				} else {
					$json['status'] = 'ERROR';
					$json['error']	= 'NO_RIGHTS';
				}
				
				exit( json_encode( $json ) );
				break;
			case 'admin-delete-user':
				$result = (int)$this->_CloneUI_User->deleteUserById( $_POST['userId'] );
				$json	= array();
				if( $result > 0 ) {
					$json['status'] = 'OK';
				} else {
					$json['status'] = 'ERROR';
					$json['error']	= 'NO_RIGHTS';
				}
				exit( json_encode( $json ) );
				break;
				
			case 'admin-delete-usergroup':
				$result = (int)$this->_CloneUI_Usergroup->deleteUsergroupById( $_POST['id'] );
				$json	= array();
				if( $result > 0 ) {
					$json['status'] = 'OK';
				} else {
					$json['status'] = 'ERROR';
					$json['error']	= 'NO_RIGHTS';
				}
				exit( json_encode( $json ) );
				break;				
			case 'dataTablesUsers':
				$json = $this->_CloneUI_User->fetchDataForDataTables( $_POST );
				if( !empty( $json ) ) {
					exit( json_encode( $json ) );
				}
					
				break;				
				
			case 'ban-user':
				$userId	= (int)$_POST['id'];
				$result = (int)$this->_CloneUI_User->banUserById( $userId );
			
				if( $result > 0 ) {
					$json				= array();
					$json['status']		= 'OK';
			
					exit( json_encode( $json ) );
				}
					
				break;
							
			case 'delete-user':
				$userId	= (int)$_POST['id'];
				$result = (int)$this->_CloneUI_User->deleteUserById( $userId );
				
				if( $result > 0 ) {
					$json				= array();
					$json['status']		= 'OK';
						
					exit( json_encode( $json ) );
				}
			
				break;
				
			case 'delete-usergroup':
				$id		= (int)$_POST['id'];
				$result = (int)$this->_CloneUI_Usergroup->deleteUsergroupById( $id );
			
				if( $result > 0 ) {
					$json				= array();
					$json['status']		= 'OK';
			
					exit( json_encode( $json ) );
				}
					
				break;				
							
			case 'delete-media':		
				if( isset( $_POST['multiple'] ) AND $_POST['multiple'] ) {
					$this->_CloneUI_User_Media->deleteMultipleMediaById( $_POST['media'] );
						
					$json				= array();
					$json['status']		= 'OK';
					$json['mediaCount']	= $this->_CloneUI_User_Media->fetchTotalMediaCount();
					
					exit( json_encode( $json ) );					
				}
				
				if( strlen( $_POST['mediaId'] ) ) {
					$this->_CloneUI_User_Media->deleteMediaById( $_POST['mediaId'] );
					
					$json				= array();
					$json['status']		= 'OK';
					$json['mediaCount']	= $this->_CloneUI_User_Media->fetchTotalMediaCount();

					exit( json_encode( $json ) );
				}
				
				break;	
				
			default:
				$json			= array();
				$json['status'] = 'ERROR';
				$json['error']	= 'UNHANDLED_EXCEPTION';
				
				exit( json_encode( $json ) );				
		}
    }
        
// END OF THIS CLASS    
}