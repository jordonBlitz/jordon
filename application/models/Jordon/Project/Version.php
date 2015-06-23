<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Project\Version
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Tuesday, July 29, 2014, 02:22 PM GMT+1 mknox
 * @edited      $Date: 2014-08-03 02:43:56 +0200 (Sun, 03 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Version.php 34 2014-08-03 00:43:56Z bizlogic $
*/

class Jordon_Project_Version extends CloneUI_Db
{
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'project_version';
	}
}