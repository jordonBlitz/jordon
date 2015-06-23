<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Issue\Activity
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Monday, August 04, 2014, 12:10 AM GMT+2 mknox
 * @edited      $Date: 2014-08-04 00:58:06 +0200 (Mon, 04 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Activity.php 46 2014-08-03 22:58:06Z bizlogic $
*/

class Jordon_Project_Issue_Activity extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issue_activity';
	}
}