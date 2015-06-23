<?php
/**
 * Jordon
 * Index Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://jordonblitz.com
 * @license     Commercial
 *
 * @since  	    Tuesday, November 27, 2012, 04:18 PM GMT+1
 * @modified    $Date: 2014-06-14 09:21:49 -0700 (Sat, 14 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: IndexController.php 56 2014-06-14 16:21:49Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Jordon
*/

class IndexController extends Zend_Controller_Action
{	
    public function init() {}

    public function indexAction() 
    {    	
    	if( !has_permission('can_view_system_dashboard') ) {
    		return $this->_helper->viewRenderer->setRender('no-perms');
    	}
    	
    	return $this->forward('index', 'projects');
    }
}