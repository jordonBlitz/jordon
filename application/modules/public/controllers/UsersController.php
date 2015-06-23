<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Users Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Thursday, November 29, 2012, 12:52 PM GMT+1
 * @modified    $Date: 2014-06-14 09:21:49 -0700 (Sat, 14 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: UsersController.php 56 2014-06-14 16:21:49Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     CloneUI.com Base Framework
*/

class UsersController extends Zend_Controller_Action
{
	private $_requestObj;
	private $_requestUri;
	private $_CloneUI_User;
	
    public function __call( $method, $args ) {}

    public function init()
    {    	    	
    	$this->_CloneUI_User = new CloneUI_User;    	    	    	
        $this->_requestObj = $this->getRequest();
        $this->_requestUri = $this->_requestObj->getRequestUri();
        
        $action = $this->getRequest()->getParam('action');                
    }
    
    public function ajaxAction()
    {
		$this->_helper->viewRenderer->setNoRender( true );
    	    	
		if( !empty( $_POST ) ) {
			header('Content-Type: application/json');						
			
			$method = $_POST['method'];
			$json	= array();			
			
			switch( $method ) {
				case 'userLogin':
					$result	= $this->_CloneUI_User->login( $_POST['username'], $_POST['password'] );
						
					if( $result == 'LOGIN_OK' ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
					break;
				case 'userLoginExternal':
					$result	= $this->_CloneUI_User->loginExternal( $_POST['data'] );
					if( $result == 'LOGIN_OK' ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
									
				case 'removeTempAvatar':
					$result = (int)$this->_CloneUI_User->removeOwnTempAvatar();
					
					if( $result > 0 ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= 'TEMP_DELETE_ERROR';
					}
					 
					break;
					
				case 'changeOwnAvatar':
					$result	= $this->_CloneUI_User->changeOwnAvatar();
					if( $result['status'] == 'OK' ) {
						$json['status'] = 'OK';
						$json['url']	= $result['url'];
					} else {
						$json['status'] = 'ERROR';
					}
				
					break;
											
				case 'uploadOwnAvatar':					
					$result	= $this->_CloneUI_User->uploadOwnAvatar();
					if( $result['status'] == 'OK' ) {
						$json['status'] = 'OK';
						$json['url']	= $result['url'];
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result['error'];
					}
				
					break;
									
				case 'unblockUser':
					$result	= (int)$this->_CloneUI_User->unblockUserById( $_POST['requesterId'], $_POST['id'] );
					if( $result > 0 ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
									
				case 'blockUser':
					$result	= (int)$this->_CloneUI_User->blockUserById( $_POST['requesterId'], $_POST['id'] );
					if( $result > 0 ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
					
				case 'resetOwnPassword':
					$result	= $this->_CloneUI_User->resetOwnPassword( $_POST['username'], $_POST['challenge'], $_POST['response'] );
					if( $result == 'OK' ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
									
				case 'updateTheme':
					$theme = $_POST['theme'];
					setcookie('theme', $theme, 315360000, '/');
					$_SESSION['theme'] = $theme;
					$json['status'] = 'OK';
				
					break;
									
				case 'changeOwnPassword':
					$result	= $this->_CloneUI_User->changeOwnPassword( $_POST['password'], $_POST['new_password'] );
					if( $result ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= 'PASSWORD_ERROR';
					}
				
					break;
									
				case 'changeLang':
					$result	= $this->_CloneUI_User->changeUserLangByLangId( (int)$_POST['langId'] );
					if( $result ) {
						$json['status'] = 'OK';						
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= 'LANG_ID_DOES_NOT_EXIST';
					}
										
					break;

				default:
					$json['status'] = 'ERROR';
					$json['error']	= 'UNHANDLED_EXCEPTION';
			}	
					
			exit( json_encode( $json ) );			
		} else {
			header( 'Location: '.BASEURL.'');
		}     	
    }

    public function indexAction() {}

    public function editAction() {}
}