/**
 * Various JavaScript Functions
 *
 * @author      CloneUI.com <hire@bizlogicdev.com>
 * @license     Commercial
 * @link        http://bizlogicdev.com
 *
 *
 * @since       Wednesday, April 25, 2012 / 01:47 AM GMT+1 mknox
 * @edited      $Date: 2014-06-13 12:39:33 -0700 (Fri, 13 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Revision: 55 $
 *
 * @package     CloneUI.com Base
*/

$('#logo').live('click', 
		function() {
			blockUIWithMessage( 'Loading...', 'Loading, please wait...' );	
			window.location = BASEURL; 
		}
);

function blockUIWithMessage( title, message, timeout )
{ 	
	title	= ( typeof title !== 'undefined' && strlen( title ) ) ? title : 'Loading...';
	message = ( typeof message !== 'undefined' && strlen( message ) ) ? message : 'Loading, please wait...';
	timeout	= ( typeof timeout !== 'undefined' && is_numeric( timeout ) ) ? timeout : 0;
	
	if( timeout > 0 ) {		
		$.blockUI({ 
			theme:		true, 
			title:    	title, 
			message:	message + '&nbsp;&nbsp;<img style="vertical-align: middle;" src="'+ BASEURL +'/img/loading.gif" border="0">',
			timeout:	timeout
		});	
	} else {
		$.blockUI({ 
			theme:		true, 
			title:    	title, 
			message:	message + '&nbsp;&nbsp;<img style="vertical-align: middle;" src="'+ BASEURL +'/img/loading.gif" border="0">'			
		});	
	}
}

function reloadPage()
{
	window.location.reload();
}