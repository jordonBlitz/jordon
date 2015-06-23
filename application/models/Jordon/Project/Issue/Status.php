<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Issue\Status
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Saturday, July 26, 2014, 08:35 PM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_Project_Issue_Status extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issue_status';
	}
}