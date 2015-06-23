<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Issue\Comments
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Sunday, July 27, 2014, 03:26 AM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_Issue_Comments extends CloneUI_Db
{
	protected $_tableName;
	
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'issue_comments';
	}	
}