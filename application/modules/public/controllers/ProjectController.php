<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Project Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Friday, July 25, 2014, 07:36 PM GMT+1
 * @modified    $Date: 2014-08-07 04:36:13 +0200 (Thu, 07 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: ProjectController.php 52 2014-08-07 02:36:13Z bizlogic $
 *
 * @category    Controllers
 * @package     CloneUI.com Base Framework
*/

class ProjectController extends Zend_Controller_Action
{	
    public function init() {}

    public function __call( $method, $args )
    {
    	// START:	Check for Project Key
    	$key = trim( str_replace( 'Action', '', $method ) );
    	if( strlen( $key ) ) {
    		return $this->_forward( 'key', null, null, array('key' => $key ) );     		
    	}
    	// END:		Check for Project Key

    	if ( 'Action' == substr( $method, -6 ) ) {
    		// If the action method was not found, render the error
    		// template
    		throw new Zend_Controller_Action_Exception('Project not found', 404);
    	}
    
    	// all other methods throw an exception
    	throw new Exception('Invalid method "'
    			. $method
    			. '" called',
    			500);
    }
    
    // get lost...
    public function indexAction() 
    {
    	$this->_helper->viewRenderer->setNoRender( true );
		throw new Zend_Controller_Action_Exception('Project not found', 404);
    }
    
    /**
     * Viewing a project by key
    */
    public function keyAction()
    {
    	// get project
    	$key = $this->_getParam('key');
    	$Jordon_Project = new Jordon_Project;
    	$project = $Jordon_Project->getBy( array( 'key' => $key ) );
    	
    	if( !empty( $project ) ) {
    		// update session
    		$_SESSION['project']['recent'][] = array( 
    				'key' => $project['key'], 
    				'title' => $project['title'] 
    		);
    		
    		// START:	get summary   		
    		$Jordon_Project_Issue = new Jordon_Project_Issue();
    		$startDate	= strtotime('-30 days');
    		$endDate	= time();
    		$created	= $Jordon_Project_Issue->getCreatedByDateRange( $project['id'], $startDate, $endDate );    		
    		$resolved	= $Jordon_Project_Issue->getResolvedByDateRange( $project['id'], $startDate, $endDate );
    		
    		$this->view->totalCreated	= count( $created );
    		$this->view->totalResolved	= count( $resolved );  

    		// START:	series for Highcharts   		
    		$dateDiff	= ( $endDate - $startDate );
    		$days		= floor( $dateDiff / ( 60*60*24 ) );
    		$max		= ( $days + 1 );
    		$min		= date('j', $startDate );
    		    		
    		// create date range
    		$seriesCreated = dateRange( $startDate, $endDate );
    		foreach( $seriesCreated AS $key => $value ) {
    			$seriesCreated[$key] = 0;
    		}
    		
    		if( !empty( $created ) ) {				  			
    			foreach( $created AS $key => $value ) {
    				$day = date( 'm-d-Y', $value['date_created'] );
					$seriesCreated[$day]++;
    			}	
    		}
    		
    	    // create date range
    		$seriesResolved = dateRange( $startDate, $endDate );
    		foreach( $seriesResolved AS $key => $value ) {
    			$seriesResolved[$key] = 0;
    		}
    		
    		if( !empty( $resolved ) ) {
    			foreach( $resolved AS $key => $value ) {
    				$day = date( 'm-d-Y', $value['date_resolved'] );
    				$seriesResolved[$day]++;
    			}
    		}  	
    		// END:		series for Highcharts
    		
    		// START:	Get recent activity    	
    		if( has_permission( 'project_can_view_activity_stream' ) ) {
    			$Jordon_Project_Issue_Comment = new Jordon_Project_Issue_Comment();
    			$recentComments = $Jordon_Project_Issue_Comment->getByProjectId( $project['id'] );
    			
    			if( !empty( $recentComments ) ) {
    				$Jordon_User = new Jordon_User();
    				 
    				foreach( $recentComments AS $key => $value ) {
    					// get issue info
    					$issueUUID	= $Jordon_Project_Issue->getUUIDById( $value['issue_id'] );
    					$Jordon_Project_Issue_Revision = new Jordon_Project_Issue_Revision;
    					$issue		= $Jordon_Project_Issue_Revision->getLatestRevisionByUUID( $issueUUID );
    			
    					$author = $Jordon_User->getById( $value['author_id'] );
    			
    					if( !empty( $author ) ) {
    						unset( $author['password'] );
    					}
    			
    					$recentComments[$key]['author'] = $author;
    					$recentComments[$key]['issue']	= $issue;
    				}
    				
    				$this->view->activity = $recentComments;
    			}    			
    		} 				
    		// END:		Get recent activity
    		
    		// get issue states    		
    		$states = $Jordon_Project_Issue->getStateSummary( $project['id'] );
    		
    		if( !empty( $states ) ) {
    			$this->view->issueStates = $states;	
    		}
    		
    		// END:		get summary
    		
    		$this->view->startDate	= $startDate;
    		$this->view->endDate	= $endDate;
    		$this->view->created	= $seriesCreated;
    		$this->view->resolved	= $seriesResolved;
			$this->view->project	= $project;
    	} else {
    		// project does not exist
    		throw new Zend_Controller_Action_Exception( translate('project_not_found'), 404 );
    	}
    }
}		