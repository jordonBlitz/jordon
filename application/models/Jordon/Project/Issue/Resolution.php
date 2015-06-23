<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Issue\Resolution
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Sunday, July 27, 2014, 02:55 PM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_Project_Issue_Resolution extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_issue_resolution';
	}
}