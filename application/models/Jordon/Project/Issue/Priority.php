<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Issues\Priority
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Saturday, July 26, 2014, 07:47 PM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_Project_Issue_Priority extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issue_priority';
	}	
}