<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Projects Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Thursday, July 27, 2014, 09:49 PM GMT+1
 * @modified    $Date: 2014-08-04 07:41:52 +0200 (Mon, 04 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: ProjectsController.php 49 2014-08-04 05:41:52Z bizlogic $
 *
 * @category    Controllers
 * @package     CloneUI.com Base Framework
*/

class ProjectsController extends Zend_Controller_Action
{	
    public function init() {}

    public function indexAction() 
    {
    	if( !has_permission('can_view_project_list') ) {
    		return $this->_helper->viewRenderer->setRender('no-perms');
    	}
    	    	
    	// Projects
    	$Jordon_Project = new Jordon_Project;
    	$projects = $Jordon_Project->getActivePublic();    	
    	$this->view->projects = $projects; 

    	// Project Category
    	$Jordon_Project_Category = new Jordon_Project_Category;
    	$projectCategory = $Jordon_Project_Category->getAll();
    	$this->view->projectCategory = $projectCategory;
    }
    
    public function ajaxAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	
    	if( !empty( $_POST ) ) {
    		$method		= $_POST['method'];
    		$response	= array();
    		
    		header('Content-Type: application/json');
    			
    		switch( $method ) { 
    			case 'projectInfo':
    				$part = $_POST['part'];
    				switch( $part ) {
    					case 'issues':

    						$Jordon_Project_Issue = new Jordon_Project_Issue;
    						$data = $Jordon_Project_Issue->getBy( 
    							array( 
    								'project_id' => (int)$_POST['id'] 
    							), 
    							SITE_ISSUE_RECENT_FETCH_LIMIT, 
    							0, 
    							array(
    								'date_created' => 'DESC'  
    							) 
    						);
    						
    						$response['status'] = 'OK';
    						$response['data']	= $data;
    						
    						break;

    					default:
    						$response['status'] = 'ERROR';
    						$response['data']	= null;
    						$response['error']	= 'UNHANDLED_EXCEPTION';
    				}
    				
    				break;
    				   	
    			default:
    				$response['status'] = 'ERROR';
    				$response['data']	= null;
    				$response['error']	= 'UNHANDLED_EXCEPTION';
    		}
    			
    		exit( json_encode( $response ) );
    			
    	} else {
    		header( 'Location: '.BASEURL.'' );
    	}    	
    }
}		