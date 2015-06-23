<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Error Controller
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 - 2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Tuesday, November 27, 2012, 05:35 PM GMT+1
 * @version     $Id: ErrorController.php 55 2014-06-13 19:39:33Z hire@bizlogicdev.com $
 * @edited      $Date: 2014-06-13 12:39:33 -0700 (Fri, 13 Jun 2014) $
 *
 * @package     CloneUI.com Base Framework
*/

define('THIS_PAGE', 'ERROR');
class ErrorController extends Zend_Controller_Action
{
	
    public function errorAction()
    {
        $errors     = $this->_getParam('error_handler');
        $exception  = $errors->exception;
        $message    = $exception->getMessage();
        $trace      = $exception->getTraceAsString();
        
        $controller	= trim( $this->getRequest()->getParam('controller') );

        switch ( $errors->type ) {
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_ROUTE:
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_CONTROLLER:
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_ACTION:
                // 404 error -- controller or action not found
                $this->getResponse()->setRawHeader('HTTP/1.1 404 Not Found');
                // ... get some output to display...
                break;
				
            default:
            	if( !preg_match( '/Invalid controller specified/', $exception->getMessage() ) ) {
            		// application error; display error page, but don't change
            		// status code
            		// Log the exception:
            		$log = new Zend_Log(
            				new Zend_Log_Writer_Stream(
            						LOG_DIR.'/php-exceptions-'.date('m-d-Y').'.log'
            				)
            		);
            		$log->debug($exception->getMessage() . "\n" .
            				$exception->getTraceAsString());            		
            	}
        }

        // clear previous content
        $this->getResponse()->clearBody();
        
        if( is_array( @$_SESSION['site']['permissions']['admin'] ) ) {
        	if( in_array('can_view_debug_messages', $_SESSION['site']['permissions']['admin'] ) ) {
        		$this->view->message    = $message;
        		$this->view->trace      = $trace;
        	} else {
        		$this->view->message    = fetchTranslation('http_error_404_text');
        		$this->view->trace      = null;
        	}        	
        } else {
        	$this->view->message	= fetchTranslation('http_error_404_text');
        	$this->view->trace      = null;        	
        }
    }
}