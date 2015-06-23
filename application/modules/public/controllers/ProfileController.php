<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Profile Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Monday, July 28, 2014, 09:32 PM GMT+1
 * @modified    $Date: 2014-08-07 04:36:13 +0200 (Thu, 07 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: ProfileController.php 52 2014-08-07 02:36:13Z bizlogic $
 *
 * @category    Controllers
 * @package     CloneUI.com Base Framework
*/

class ProfileController extends Zend_Controller_Action
{	
    public function init() {}
    
    public function __call( $method, $args )
    {
    	// START:	Check for URL Slug
    	$user = trim( str_replace( 'Action', '', $method ) );    
    	if( strlen( $user ) ) {
    		return $this->_forward( 'view', null, null, array( 'user' => $user ) );
    	}
    	// END:		Check for URL Slug
    
    	if ( 'Action' == substr( $method, -6 ) ) {
    		// If the action method was not found, render the error
    		// template
    		throw new Zend_Controller_Action_Exception( translate('error_issue_not_found'), 404 );
    	}
    
    	// all other methods throw an exception
    	throw new Exception('Invalid method "'
    			. $method
    			. '" called',
    			500);
    }
    
    public function indexAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	throw new Zend_Controller_Action_Exception( translate('profile_not_found'), 404 );
    }

    public function viewAction() 
    {    	
    	if( !has_permission('can_view_user_profiles') ) {
    		return $this->_helper->viewRenderer->setRender('no-perms');
    	}
    	
    	$urlSlug = $this->_getParam('user');
    	$Jordon_User = new Jordon_User();
    	$user = $Jordon_User->getBy( array('url_slug' => $urlSlug ) );
    	 
    	if( empty( $user ) ) {
    		throw new Zend_Controller_Action_Exception( translate('user_not_found'), 404 );
    	} else {
    		// remove password
    		unset( $user['password'] );	
    		
    		$this->view->user = $user;
    	}
    }
}