<?php
/**
 * Jordon
 * Index
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2014 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://jordonblitz.com
 *
 * @since       Wednesday, July 06, 2011 / 10:17 AM GMT+1
 * @edited      $Date: 2014-07-29 18:11:41 +0200 (Tue, 29 Jul 2014) $
 * @version     $Id: index.php 22 2014-07-29 16:11:41Z bizlogic $
 *
 * @package     Jordon Blitz
 * @category    Front Controller
*/

define( 'PATH', dirname( __FILE__ ) );
set_include_path(   
	PATH.'/application/'.PATH_SEPARATOR.
	PATH.'/application/configs'.PATH_SEPARATOR.
	PATH.'/application/models'.PATH_SEPARATOR.
	PATH.'/library/'.PATH_SEPARATOR.
	get_include_path()
);

require_once('Bootstrap.php');
$Bootstrap = new Bootstrap('');
$Bootstrap->run();