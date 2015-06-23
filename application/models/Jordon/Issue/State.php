<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Jordon\Issue\State
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Saturday, July 26, 2014, 08:18 PM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Jordon_Issue_State extends CloneUI_Db
{
	protected $_db;
	protected $_tableName;
	
	public function __construct()
	{
		parent::__construct();
		$this->_tableName = 'issue_state';
	}	
}