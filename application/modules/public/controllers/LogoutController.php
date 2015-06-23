<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Logout Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Friday, November 29, 2013, 05:33 PM GMT+1
 * @modified    $Date: 2014-06-14 09:21:49 -0700 (Sat, 14 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: LogoutController.php 56 2014-06-14 16:21:49Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     CloneUI.com Base Framework
*/

define('THIS_PAGE', 'LOGOUT');
class LogoutController extends Zend_Controller_Action
{	
    public function init() 
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	
    	if( !@$_SESSION['user']['logged_in'] ) {
    		header( 'Location: '.BASEURL.'/login' );
    	}
    	
    	// check for last URL
    	$lastUrl = ( isset( $_SESSION['last_url'] ) ) ? $_SESSION['last_url'] : null;
    	
    	$token = null;
    	if( @$_SESSION['user']['external']['network'] == 'twitter' ) {
    		$token = $_SESSION['twitter']['access_token'];
    	}
    	
    	session_unset();    	
    	session_destroy();
    	
    	// restore last URL
    	if( !is_null( $lastUrl ) ) {
    		$_SESSION['last_url'] = $lastUrl;
    	}	
    	
    	// store the token from Twitter
    	if( !is_null( $token ) ) {
			setcookie('twitter_access_token', $token, 2147483647);    		
    	}
    	
    	header( 'Location: '.BASEURL.'/login' );
    }

    public function indexAction() {}
}