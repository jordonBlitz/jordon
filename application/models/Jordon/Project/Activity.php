<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Activity
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Saturday, August 02, 2014, 07:48 AM GMT+2 mknox
 * @edited      $Date: 2014-07-29 18:11:41 +0200 (Tue, 29 Jul 2014) $ $Author: bizlogic $
 * @version     $Id: Versions.php 22 2014-07-29 16:11:41Z bizlogic $
*/

class Jordon_Project_Activity extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_activity';
	}
}