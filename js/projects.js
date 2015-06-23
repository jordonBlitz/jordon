/**
 * CloneUI.com - CloneUI.com Base Framework
 * Custom JavaScript
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Saturday, August 02, 2014, 11:48 AM GMT+1
 * @modified    $Date: 2014-08-03 23:53:10 +0200 (Sun, 03 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: projects.js 45 2014-08-03 21:53:10Z bizlogic $
 *
 * @category    JavaScript
 * @package     CloneUI.com Base Framework
*/

$(document).ready(function() {
	// START:	Issue Edit
	$('.triggerProjectList').click(function(event) {
		event.preventDefault();
		
		$('.triggerProjectList').removeClass('active');
		$(this).addClass('active');

		var data = $(this).data();
		if( !empty( data ) ) {
			var category = data.category;
			
			switch( category ) {
				case 'all':
					$('.projectLegend').show('slide');					
					break;
					
				default:
					$('.projectLegend').not( '#projects-' + category ).hide('fold');
					$('#projects-' + category ).show('slide');
			}
		}
				
		return false;
	});
	// END:		Issue Edit
});