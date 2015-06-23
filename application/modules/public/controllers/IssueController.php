<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Issue Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Saturday, July 26, 2014, 08:59 PM GMT+1
 * @modified    $Date: 2014-08-07 04:36:13 +0200 (Thu, 07 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: IssueController.php 52 2014-08-07 02:36:13Z bizlogic $
 *
 * @category    Controllers
 * @package     CloneUI.com Base Framework
*/

class IssueController extends Zend_Controller_Action
{	
	private $_Jordon_Project_Issue;
	private $_Jordon_Project;
	private $_Jordon_Project_Issue_Activity;
	private $_Jordon_Project_Issue_Revision;
	private $_Jordon_Project_Issue_Comment;
	private $_Jordon_Project_Issue_State;
	private $_Jordon_Project_Issue_Status;
	private $_Jordon_Project_Issue_Resolution;
	private $_Jordon_User;
	private $_Jordon_Project_Activity;
	protected $_NOW;
	
    public function init() 
    {
    	if( !has_permission('can_view_issues') ) {
			return $this->_helper->viewRenderer->setRender('no-perms');
    	} else {
    		$this->_NOW								= time();
    		$this->_Jordon_Project					= new Jordon_Project;
    		$this->_Jordon_Project_Issue			= new Jordon_Project_Issue();
    		$this->_Jordon_Project_Issue_Activity	= new Jordon_Project_Issue_Activity();
    		$this->_Jordon_Project_Issue_Comment	= new Jordon_Project_Issue_Comment();
    		$this->_Jordon_Project_Issue_State 		= new Jordon_Project_Issue_State;
    		$this->_Jordon_Project_Issue_Status		= new Jordon_Project_Issue_Status;
    		$this->_Jordon_Project_Issue_Resolution	= new Jordon_Project_Issue_Resolution;
    		$this->_Jordon_User						= new Jordon_User();
    		$this->_Jordon_Project_Activity			= new Jordon_Project_Activity();
    		$this->_Jordon_Project_Issue_Revision	= new Jordon_Project_Issue_Revision();
    	}
    }

    public function __call( $method, $args )
    {
    	// START:	Check for Project Key
    	$id = trim( str_replace( 'Action', '', $method ) );
    	
    	// key
    	$key = preg_replace('/[0-9]+/', '', $id );
    	
    	// id
    	$id = (int)filter_var( $id, FILTER_SANITIZE_NUMBER_INT );

		if( $id > 0 ) {
    		return $this->_forward( 'view', null, null, array( 'id' => $id, 'key' => $key ) );     		
    	}
    	// END:		Check for Project Key

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
		throw new Zend_Controller_Action_Exception( translate('error_issue_not_found'), 404 );
    }
    
    public function createAction()
    {
        if( !has_permission('can_create_issues') ) {
            // throw exception
            throw new Zend_Controller_Action_Exception( translate('error_no_permission'), 403 );            
        }
        
    	// project
    	$projects = $this->_Jordon_Project->getActivePublic();
    	$this->view->projects = $projects;
    	
    	// issue types
    	$Jordon_Project_Issue_Type = new Jordon_Project_Issue_Type;
    	$types = $Jordon_Project_Issue_Type->getBy( array('active' => '1'), 0, 0, array('name' => 'ASC') );
    	$this->view->types = $types;
    	
    	// issue priority
    	$Jordon_Project_Issue_Priority = new Jordon_Project_Issue_Priority;
    	$priority = $Jordon_Project_Issue_Priority->getAll( array( 'severity' => 'ASC' ) );
    	$this->view->priority = $priority;
    	
    	// issue privacy
    	$Jordon_Privacy_Type = new Jordon_Privacy_Type;
    	$privacy = $Jordon_Privacy_Type->getActive();
    	$this->view->privacy = $privacy; 	
    }
    
    public function ajaxAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	 
    	if( !empty( $_POST ) ) {
    		$method		= @$_POST['method'];
    		$response	= array();
    
    		header('Content-Type: application/json');
    		 
    		switch( @$method ) {
    			case 'getProjectIssueId':
    				$data = $this->_Jordon_Project_Issue->getById( @$_POST['id'] );
    				if( !empty( $data ) ) {
    					$response['status'] = 'OK';
    					$response['data']	= $data['project_issue_id'];    					
    				} else {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'RESOURCE_DOES_NOT_EXIST';    					
    				}
    				
    				break;
    				
    			case 'issueEdit':
    				if( !has_permission('can_edit_issues') ) {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'NO_PERMISSION';
    				} else {  					
    					$data 					= array();
    					$data[$_POST['name']]	= $_POST['value'];
    					$data['date_updated']	= $this->_NOW;
    					
    					switch( $_POST['value'] ) {
    						case SITE_ISSUE_RESOLUTION_ID:
    							$data['date_resolved'] = $this->_NOW;
    							break;	
    							
    						default:
    							$data['date_resolved'] = 0;
    					}
    					
    					$result = (int)$this->_Jordon_Project_Issue->update( $_POST['uuid'], $data );
    				
    					if( $result > 0 ) {
    						$saveChange = true;
    						
    						// update activity
    						switch( $_POST['name'] ) {
    							case 'state':
    								$action = $this->_Jordon_Project_Issue_State->getNameById( (int)$_POST['value'] );
    								
    								break;

    							case 'status':
    								$action = $this->_Jordon_Project_Issue_Status->getNameById( (int)$_POST['value'] );
    								$action = ( $action == 'open' ) ? 'reopened' : $action;
    								
    								break;
    								
    							case 'resolution':
    								$action = $this->_Jordon_Project_Issue_Resolution->getNameById( (int)$_POST['value'] );
    								
    								break;
    								
    							default:
    								$saveChange = false;
    						}
    						
    						if( $saveChange ) {
    							// START:	project activity    							
    							$update					= array();
    							$update['by']			= (int)$_SESSION['user']['id'];
    							$update['project_id']	= $this->_Jordon_Project_Issue->getProjectIdByUUID( $_POST['uuid'] );
    							$update['parent_uuid']	= $_POST['uuid'];
    							$update['action_uuid']	= $this->_Jordon_Project_Issue_Revision->getLatestRevisionUUIDByUUID( $_POST['uuid'] );
    							$update['action']		= $action;
    							$update['target']		= 'issue';
    							$update['ip']			= $_SERVER['REMOTE_ADDR'];
    							$update['date'] 		= $data['date_updated'];
    							
    							$this->_Jordon_Project_Activity->insert(
    								$update
    							); 
    							// END:		project activity 

    							// START:	issue activity
    							$columns = fetchColumnNames( DB_TABLE_PREFIX.'project_issue_activity' );
    							$columns = array_flip( $columns );
    								
    							// unset ID column, as it is auto-incremented
    							unset( $columns['id'] );
    								
    							$intersect = array_intersect_key( $columns, $update );
    							if( !empty( $intersect ) ) {
    								$intersect = array_intersect_key( $update, $intersect );
    							} else {
    								// error
    							}
    							
    							// issue UUID
    							$intersect['issue_uuid'] = $update['parent_uuid'];
    							
    							// insert into 'project_issue_activity' table
    							try {
    								$id = $this->_Jordon_Project_Issue_Activity->insert( $intersect );
    							} catch (Exception $e) {
    								// insert failed
    							}
    							// END:		issue activity
    						}
    						
    						$response['status'] = 'OK';
    					} else {
    						$response['status'] = 'ERROR';
    						$response['error']	= 'NOT_SAVED';
    					}
    				}
    				    				
    				break;
    				
    			case 'issueDelete':
    				if( !has_permission('can_delete_issues') ) {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'NO_PERMISSION';
    				} else {    						
    					$result = (int)$this->_Jordon_Project_Issue->deleteByUUID( $_POST['uuid'] );
    						
    					if( $result > 0 ) {
    						// START:	project activity
    						$update					= array();
    						$update['by']			= (int)$_SESSION['user']['id'];
    						$update['project_id']	= (int)$_POST['project_id'];
    						$update['parent_uuid']	= $_POST['uuid'];
    						$update['action']		= 'delete';
    						$update['target']		= 'issue';
    						$update['ip']			= $_SERVER['REMOTE_ADDR'];
    						$update['date'] 		= $this->_NOW;
    								
    						$this->_Jordon_Project_Activity->insert(
    							$update
    						);
    						// END:		project activity
    						
    						// START:	issue activity
    						$columns = fetchColumnNames( DB_TABLE_PREFIX.'project_issue_activity' );
    						$columns = array_flip( $columns );
    						
    						// unset ID column, as it is auto-incremented
    						unset( $columns['id'] );
    						
    						$intersect = array_intersect_key( $columns, $update );
    						if( !empty( $intersect ) ) {
    							$intersect = array_intersect_key( $update, $intersect );
    						} else {
    							// error
    						}
    							
    						// issue UUID
    						$intersect['issue_uuid'] = $update['parent_uuid'];
    							
    						// insert into 'project_issue_activity' table
    						try {
    							$id = $this->_Jordon_Project_Issue_Activity->insert( $intersect );
    						} catch (Exception $e) {
    							// insert failed
    						}
    						// END:		issue activity
    						    						
    						$response['status'] = 'OK';
    						$response['data']	= $result;
    					} else {
    						$response['status'] = 'ERROR';
    						$response['error']	= 'NOT_SAVED';
    					}
    				}
    				    				
    				break;
    				
    			case 'create':
    				if( !has_permission('can_create_issues') ) {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'NO_PERMISSION';
    				} else {
    					// START:	normalize data
    					unset( $_POST['method'] );
    					// END:		normalize data

    					$result = (int)$this->_Jordon_Project_Issue->insert( $_POST['data'] );
    					
    					if( $result > 0 ) {
    						// START: 	project activity
    						$update					= array();
    						$update['by']			= (int)$_SESSION['user']['id'];
    						$update['project_id']	= $_POST['data']['project_id'];
    						$update['parent_uuid']	= $this->_Jordon_Project_Issue->getUUIDById( $result );
    						$update['action']		= 'create';
    						$update['target']		= 'issue';
    						$update['ip']			= $_SERVER['REMOTE_ADDR'];
    						$update['date'] 		= $this->_NOW;
    								
    						$this->_Jordon_Project_Activity->insert(
    							$update
    						);   						
    						// END:		project activity
    						
    						// START:	issue activity
    						$columns = fetchColumnNames( DB_TABLE_PREFIX.'project_issue_activity' );
    						$columns = array_flip( $columns );
    							
    						// unset ID column, as it is auto-incremented
    						unset( $columns['id'] );
    							
    						$intersect = array_intersect_key( $columns, $update );
    						if( !empty( $intersect ) ) {
    							$intersect = array_intersect_key( $update, $intersect );
    						} else {
    							// error
    						}
    						
    						$intersect['issue_uuid'] = $update['parent_uuid']; 
    						
    						// insert into 'project_issue_activity' table
    						try {
    							$id = $this->_Jordon_Project_Issue_Activity->insert( $intersect );
    						} catch (Exception $e) {
    							// insert failed
    						}  						
    						// END:		issue activity
    						
    						$response['status'] = 'OK';
    						$response['data']	= $result;    						
    					} else {
    						$response['status'] = 'ERROR';
    						$response['error']	= 'NOT_SAVED';    						
    					}
    				}
    				
    				break;
    				
    			case 'getVersions':
    				$Jordon_Project_Version = new Jordon_Project_Version;
    				
    				$search = array(
    					'project_id'	=> $_POST['id'],
    					'privacy'		=> '1'
    				);
    				
    				$data = $Jordon_Project_Version->getBy( $search, 0 );
    				
    				if( !empty( $data ) ) {
    					$response['status'] = 'OK';
    					$response['data']	= $data;
    				} else {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'NO_DATA';    					
    				}
    				
    				break;
    				
    			case 'commentDelete':
    				if( !has_permission('can_delete_issue_comments') ) {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'NO_PERMISSION';
    				} else {
    					$result = $this->_Jordon_Project_Issue_Comment->deleteById( $_POST['id'] );
    					if( $result ) {
    						$response['status'] = 'OK';   						
    					} else {
    						$response['status'] = 'ERROR';
    						$response['error']	= 'NOT_DELETED';    						
    					}
    				}
    				
    				break;
    				
    			case 'getComments':
    				if( !has_permission('can_view_issue_comments') ) {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'NO_PERMISSION';
    				} else {
	    				$result = $this->_Jordon_Project_Issue_Comment->getBy( array('issue_id' => $_POST['id'] ), SITE_ISSUE_COMMENT_FETCH_LIMIT, $_POST['offset'], array('date' => 'ASC' ) );
	    				
	    				if( !empty( $result ) ) {
	    					$response['status'] = 'OK';
	    					$response['data']	= $result;
	    				} else {
	    					$response['status'] = 'ERROR';
	    					$response['error']	= 'NO_DATA';
	    				}
    				}
    				
    				break;
    				
    			case 'comment':
    				if( !has_permission('can_comment_on_issues') ) {
    					$response['status'] = 'ERROR';
    					$response['error']	= 'NO_PERMISSION';
    				} else {
	    				// unset method
	    				unset( $_POST['method'] );
	    				
	    				// get issue
	    				$issue = $this->_Jordon_Project_Issue->getByUUID( $_POST['uuid'] );
	    				
	    				if( empty( $issue ) ) {
	    					// issue no longer exists...
	    					$response['status'] = 'ERROR';
	    					$response['error']	= 'RESOURCE_DOES_NOT_EXIST';
	    				} else {
	    					// unset UUID
	    					$uuid = $_POST['uuid'];
	    					unset( $_POST['uuid'] );
	    					
	    					// set project ID
	    					$projectId = $issue['project_id'];
	    					
	    					// set issue ID
	    					$_POST['issue_id'] = $issue['id'];
	    					 
	    					// insert
	    					$result = (int)$this->_Jordon_Project_Issue_Comment->insert( $_POST );
	    					 
	    					if( $result > 0 ) {
	    						// START: 	project activity
	    						$update					= array();
	    						$update['by']			= (int)$_SESSION['user']['id'];
	    						$update['project_id']	= $issue['project_id'];
	    						$update['parent_uuid']	= $uuid;
	    						$update['action_uuid']	= $this->_Jordon_Project_Issue_Comment->getUUIDById( $result );
	    						$update['action']		= 'comment';
	    						$update['target']		= 'issue';
	    						$update['ip']			= $_SERVER['REMOTE_ADDR'];
	    						$update['date'] 		= $this->_NOW;
	    					
	    						$this->_Jordon_Project_Activity->insert(
	    							$update
	    						);
	    						// END:		project activity
	    						
	    						// START:	issue activity
	    						$columns = fetchColumnNames( DB_TABLE_PREFIX.'project_issue_activity' );
	    						$columns = array_flip( $columns );
	    							
	    						// unset ID column, as it is auto-incremented
	    						unset( $columns['id'] );
	    							
	    						$intersect = array_intersect_key( $columns, $update );
	    						if( !empty( $intersect ) ) {
	    							$intersect = array_intersect_key( $update, $intersect );
	    						} else {
	    							// error
	    						}
	    						
	    						$intersect['issue_uuid'] = $update['parent_uuid']; 
	    						
	    						// insert into 'project_issue_activity' table
	    						try {
	    							$id = $this->_Jordon_Project_Issue_Activity->insert( $intersect );
	    						} catch (Exception $e) {
	    							// insert failed
	    						}  						
	    						// END:		issue activity
	    					
	    						$response['status'] = 'OK';
	    						$response['data']	= array_merge( $_POST, array('id' => $result ) );
	    					
	    						// update last comment date
	    						$result = (int)$this->_Jordon_Project_Issue->setById(
    								$issue['id'],
    								array(
    									'date_last_comment' => $this->_NOW
    								)
	    						);
	    					} else {
	    						$response['status'] = 'ERROR';
	    						$response['error']	= 'NOT_SAVED';
	    					}	    					
	    				}
    				}
    				
    				break;
    				
    			case 'info':
    				$part = $_POST['part'];
    				switch( $part ) {
    					case 'comments':
    						if( !has_permission('can_view_issue_comments') ) {
    							$response['status'] = 'ERROR';
    							$response['error']	= 'NO_PERMISSION';
    						} else {
	    						$data = $this->_Jordon_Project_Issue_Comment->getBy( 
	    							array( 
	    								'issue_id' => (int)$_POST['id'] 
	    							), 
	    							0 
	    						);
	    
	    						$response['status'] = 'OK';
	    						$response['data']	= $data;
    						}
    
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
    
    public function viewAction()
    {    	
    	$id  = $this->_getParam('id');
    	$key = $this->_getParam('key');
    	
    	// get project data	
    	$project = $this->_Jordon_Project->getBy( array('key' => $key ) );
    	
		if( empty( $project ) ) {
			throw new Zend_Controller_Action_Exception( translate('error_issue_not_found'), 404 );
		}
    	
		// get issue data
    	$issue = $this->_Jordon_Project_Issue->getByProjectIdAndIssueId( $project['id'], $id, true );
    	
    	if( !empty( $issue ) ) {    		
    		// get original record
    		$original = $this->_Jordon_Project_Issue->getBy( 
    				array( 
    					'project_issue_id'	=> $issue['project_issue_id'],
    					'project_id'		=> $project['id'] 
    				), 
    				1, null, null, 
    				array( 'date_created' => 'DESC' ), 
    				true 
    		);
    		
    		// set issue ID; the previous ID is from the revision table
    		$issue['id'] = $original['id'];
    		
    		// overwrite revision metadata using the original data
    		$issue['date_created']		= $original['date_created'];
    		$issue['date_last_comment'] = $original['date_last_comment'];
    		    		    		
    		// workaround for getting project versions via x-editable
    		$_SESSION['browse']['project']['current'] = $project['id'];
    		
    		if( has_permission( 'can_view_issue_comments' ) ) {
    			// get comments
    			$comments = $this->_Jordon_Project_Issue_Comment->getBy( array('issue_id' => $issue['id'] ), SITE_ISSUE_COMMENT_FETCH_LIMIT, 0, array('date' => 'ASC') );
    			if( !empty( $comments ) ) {
    				foreach( $comments AS $key => $value ) {
    					$comments[$key]['dateFull'] = date( 'l, F, d, Y / h:i:s A P', $value['date'] );	
    				}	
    			}
    			
    			$totalComments = $this->_Jordon_Project_Issue_Comment->countBy( 'issue_id', $issue['id'] );
    			
    			$this->view->comments		= $comments;
    			$this->view->commentTotal	= $totalComments;
    		}
    		
    		$this->view->issue = $issue;
    	} else {
    		// unset
    		$_SESSION['browse']['project']['current'] = null;
    		
    		// throw exception
    		throw new Zend_Controller_Action_Exception( translate('error_issue_not_found'), 404 );
    	}
    }
    
    public function priorityAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	header('Content-Type: application/json');
    	 
    	$result = array();
    	 
    	$Jordon_Project_Issue_Priority = new Jordon_Project_Issue_Priority();
    	$data = $Jordon_Project_Issue_Priority->getAll( array( 'severity' => 'ASC' ) );
    	 
    	if( !empty( $data ) ) {
    		$i = 0;
    		foreach( $data AS $key => $value ) {
    			$result[$i]['value']	= $value['id'];
    			$result[$i]['text']		= translate( $value['name'] );
    			$i++;
    		}
    	}
    	 
    	exit( json_encode( $result ) );
    }
    
    public function resolutionAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	header('Content-Type: application/json');
    
    	$result = array();
    
    	$Jordon_Project_Issue_Resolution = new Jordon_Project_Issue_Resolution();
    	$data = $Jordon_Project_Issue_Resolution->getAll( array( 'name' => 'ASC' ) );
    
    	if( !empty( $data ) ) {
    		$i = 0;
    		foreach( $data AS $key => $value ) {
    			$result[$i]['value']	= $value['id'];
    			$result[$i]['text']		= translate( $value['name'] );
    			$i++;
    		}
    	}
    
    	exit( json_encode( $result ) );
    }
        
    public function stateAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	header('Content-Type: application/json');
    	 
    	$result = array();
    	 
    	$Jordon_Project_Issue_State = new Jordon_Project_Issue_State();
    	$data = $Jordon_Project_Issue_State->getAll( array( 'name' => 'ASC' ) );
    	 
    	if( !empty( $data ) ) {
    		$i = 0;
    		foreach( $data AS $key => $value ) {
    			$result[$i]['value']	= $value['id'];
    			$result[$i]['text']		= translate( $value['name'] );
    			$i++;
    		}
    	}
    	 
    	exit( json_encode( $result ) );
    }
    
    public function statusAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	header('Content-Type: application/json');
    
    	$result = array();
    
    	$Jordon_Project_Issue_Status = new Jordon_Project_Issue_Status();
    	$data = $Jordon_Project_Issue_Status->getAll( array( 'name' => 'ASC' ) );
    
    	if( !empty( $data ) ) {
    		$i = 0;
    		foreach( $data AS $key => $value ) {
    			$result[$i]['value']	= $value['id'];
    			$result[$i]['text']		= translate( $value['name'] );
    			$i++;
    		}
    	}
    
    	exit( json_encode( $result ) );
    }
        
    public function typeAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );    	
    	header('Content-Type: application/json');
    	
    	$result = array();
    	
    	$Jordon_Project_Issue_Type = new Jordon_Project_Issue_Type();
    	$data = $Jordon_Project_Issue_Type->getBy( 
    		array( 'active' => '1' ), 
    		0, 
    		0, 
    		array( 'name' => 'ASC' ) 
    	);
    	
    	if( !empty( $data ) ) {
    		$i = 0;
    		foreach( $data AS $key => $value ) {
    			$result[$i]['value']	= $value['id'];
    			$result[$i]['text']		= translate( $value['name'] );
    			$i++;
    		}
    	}
    	
    	exit( json_encode( $result ) );
    }
    
    public function versionAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	header('Content-Type: application/json');
    	 
    	$result = array();
    	 
    	$Jordon_Project_Version = new Jordon_Project_Version();
    	$data = $Jordon_Project_Version->getBy(
    		array( 'project_id' => (int)$_SESSION['browse']['project']['current'] ),
    		0,
    		0,
    		array( 'name' => 'ASC' )
    	);
    	 
    	if( !empty( $data ) ) {
    		$i = 0;
    		foreach( $data AS $key => $value ) {
    			$result[$i]['value']	= $value['id'];
    			$result[$i]['text']		= translate( $value['version'] );
    			$i++;
    		}
    	}
    	 
    	exit( json_encode( $result ) );
    }
    
    public function assigneeAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	header('Content-Type: application/json');
    	
    	// permission check
    	$data = array();
    	if( !has_permission('can_assign_issues') ) {
    		// do nothing...  		
    	} else {
    		// get query
			$query = trim( @$_GET['query'] );
			
			// eval
    		if( strlen( $query ) ) {
    			
    			// get UUID
    			$uuid = $this->_Jordon_Project_Issue->getUUIDById( (int)$_GET['id'] );
    			
    			if( !strlen( $uuid ) ) {
    				// record does not exist
    				exit( json_encode( $data ) );
    			}
    			
    			// get existing data to check for change
    			$prev = $this->_Jordon_Project_Issue->getInUseRevisionByUUID( $uuid );
    			
    			if( is_numeric( $query ) ) {
    				if( (int)$query > 0 ) {
    					// get user data to return
    					$user = $this->_Jordon_User->getById( (int)$query );
    					
    					if( !empty( $user ) ) {
    						// unset password
    						unset( $user['password'] );
    						
    						// unset last IP
    						unset( $user['last_ip'] );
    						
    						// unset signup IP
    						unset( $user['signup_ip'] );
    						
    						if( !empty( $prev ) ) {
    							if( $prev['assignee'] <> (int)$user['id'] ) {
			    					// update if there was a change
			    					$result = $this->_Jordon_Project_Issue->update(
			    						$uuid,
			    						array('assignee' => (int)$user['id'] )
			    					);
    							}

    							$data = $user;
    						} else {
    							// the record has been deleted	
    						}
    					} else {
    						$data = array( 'id' => -1, 'display_name' => translate('unassigned') );
    					}    					
    				} else {
    					// unassigned
    					$data = array( 'id' => -1, 'display_name' => translate('unassigned') ); 

    					// check if previous entry was unassigned
    					if( (int)$prev['assignee'] <= 0 ) {
							// no change...
    					} else {
    						// update if there was a change
    						$result = $this->_Jordon_Project_Issue->update(
    								$uuid,
    								array('assignee' => -1 )
    						);
    					}
    				}	    						
    			} else {
    				// search
    				$Jordon_User = new Jordon_User();
    				$data = $Jordon_User->search(
						array( 'first_name' => $query, 'last_name' => $query ),
    					30,
    					0,
    					array( 'last_name' => 'ASC', 'first_name' => 'ASC' )
    				); 

    				// prepend 'Unassigned'
    				$unassigned = array( 'id' => -1, 'display_name' => translate('unassigned') ); 
    				array_unshift( $data, $unassigned );			
    			}
    		} else {
    			// empty query
    		}  	
    	}
    	
    	// output JSON
    	exit( json_encode( $data ) );
    }
    
    public function reporterAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	header('Content-Type: application/json');

    	$data = array();
    	
    	// permission check
    	if( !has_permission('issue_can_change_reporter') ) {
    		// do nothing...
    	} else {
    		// get query
    		$query	= trim( @$_GET['query'] );
    		$data	= array();
    			
    		// eval
    		if( strlen( $query ) ) {
    			// get UUID
    			$uuid = $this->_Jordon_Project_Issue->getUUIDById( (int)$_GET['id'] );
    			 
    			if( !strlen( $uuid ) ) {
    				// record does not exist
    				exit( json_encode( $data ) );
    			}
    			 
    			// get existing data to check for change
    			$prev = $this->_Jordon_Project_Issue->getInUseRevisionByUUID( $uuid );
    			
    			if( is_numeric( $query ) ) {
    				if( (int)$query > 0 ) {
    					// get
    					$user = $this->_Jordon_User->getById( (int)$query );
    					
    					if( !empty( $user ) ) {
    						// unset password
    						unset( $user['password'] );
    
    						// unset last IP
    						unset( $user['last_ip'] );
    
    						// unset signup IP
    						unset( $user['signup_ip'] );
    
    						if( !empty( $prev ) ) {
    							if( $prev['reporter'] <> (int)$user['id'] ) {
    								// update if there was a change
    								$result = $this->_Jordon_Project_Issue->update(
    									$uuid,
    									array('reporter' => (int)$user['id'] )
    								);
    							}
    
    							$data = $user;
    						} else {
    							// the record has been deleted
    						}
    					} else {
    						// user does not exits
    					}
    				}
    			} else {
    				// search
    				$Jordon_User = new Jordon_User();
    				$data = $Jordon_User->search(
    					array( 'first_name' => $query, 'last_name' => $query ),
    					30,
    					0,
    					array( 'last_name' => 'ASC', 'first_name' => 'ASC' )
    				);
    			}
    		}
    	}
    	 
    	// output JSON
    	exit( json_encode( $data ) );
    }
}		