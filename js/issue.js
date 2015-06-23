/**
 * CloneUI.com - CloneUI.com Base Framework
 * Custom JavaScript
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Monday, July 28, 2014, 02:19 PM GMT+1
 * @modified    $Date: 2014-08-04 02:08:37 +0200 (Mon, 04 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: issue.js 48 2014-08-04 00:08:37Z bizlogic $
 *
 * @category    JavaScript
 * @package     CloneUI.com Base Framework
*/

$(document).ready(function() {
	// START:	Issue Edit
	$('.issueEdit').click(function(event) {
		event.preventDefault();
		
		if( INITIAL_XEDITABLE_REQ ) {
			$.blockUI();
		}
		
		var timeout = 4000;
		
		$('.xeditable.issueData, .xeditable-select2.issueData')
		.editable('toggle', false)
		.promise().done(function( event ) {
			if( INITIAL_XEDITABLE_REQ ) {
				INITIAL_XEDITABLE_REQ = false;
				setTimeout(function() {
					$.unblockUI();
				}, timeout);				
			}
		});
				
		return false;
	});
	// END:		Issue Edit
	
	// START:	Issue Deletion
	$('.issueDelete').live('click', function(event) {
		event.preventDefault();
		
		var issueId		= $(this).data('id');
		var projectId	= $(this).data('projectid');
		var projectKey	= $(this).data('projectkey');
		var uuid		= $(this).data('uuid');
		var prompt		= translate('prompt_issue_delete');
		prompt			= prompt + '<br>' + translate('prompt_irreversible_action');
		
		var ME = bootbox.dialog({
			message: prompt,
			buttons: {
				confirm: {
					label: '<i class="fa fa-times-circle"></i> ' + translate('delete'),
					className: 'btn-danger',
					callback: function( event ) {
						// block the dialog
						var DIALOG_CONTENT = ME.find('.modal-content');
						DIALOG_CONTENT.block();
						
						// change the dialog's text
						ME.find('.bootbox-body').html( translate('deleting_issue') + '... <img alt="" src="'+ BASEURL +'/images/preloader/small-black.png" />' );
						
						// AJAX Request
						$.ajax({
							type: 'POST',
							url: BASEURL + '/issue/ajax',
							data: { 
								method: 'issueDelete', 				
								id:	issueId,
								project_id: projectId,
								uuid: uuid
							},
							complete: function( jqXHR, textStatus ) {
								// ...
							},
							success: function( response, textStatus, jqXHRresponse ) {				
								if( response.status == 'OK' ) {
									window.location.assign( BASEURL + '/project/' + projectKey +'#issues' );
								} else {		
									// remove the original dialog
									ME.modal('hide');
									ME.remove();
									$('.modal-backdrop').remove();
									
									// display error dialog
									var error	= translate('error');
									error		= strtoupper( error ) + ':  ' + translate( response.error );
									bootbox.alert(error, function() {
										// ...
									});
								}								
							},
							error: function(  jqXHR, textStatus, errorThrown ) {
								// remove the original dialog
								ME.modal('hide');
								ME.remove();
								$('.modal-backdrop').remove();
								
								// display error dialog
								var error	= translate('error');
								error		= strtoupper( error ) + ':  ' + errorThrown;								
								bootbox.alert(error, function() {
									// ...
								});							
							},		
							dataType: 'json'
						});	
						
						return false;
					}
				},
				cancel: {
					label: '<i class="fa fa-times"></i> ' + translate('cancel'),
					className: 'btn-default',
					callback: function( result ) {

					}
				}
			}
		});
	});	
	// END:		Issue Deletion
	
	// START:	Comment Deletion
	$('.deleteComment').live('click', function(event) {
		event.preventDefault();
		
		var commentId	= $(this).data('id');		
		var prompt		= translate('prompt_comment_delete');
		prompt			= prompt + '<div style="width: 100%;">' + $('#commentText-' + commentId).html() + '</div>';
		var count		= parseInt( $('#commentCount').text() );
		
		bootbox.confirm(prompt, function(result) {
			if( result ) {
				$.ajax({
					type: 'POST',
					url: BASEURL + '/issue/ajax',
					data: { 
						method: 'commentDelete', 				
						id:	commentId  
					},
					complete: function( jqXHR, textStatus ) {
						
					},
					success: function( response, textStatus, jqXHRresponse ) {				
						if( response.status == 'OK' ) {
							$('#comment-' + commentId).fadeOut();
							$('#commentCount').html( count - 1 );
						} else {
							var error	= translate('error');
							error		= strtoupper( error ) + ':  ' + translate( response.error );
							bootbox.alert(error, function() {
								
							});
						}								
					},
					error: function(  jqXHR, textStatus, errorThrown ) {

					},		
					dataType: 'json'
				});					
			}
		}); 
	});	
	// END:		Comment Deletion
	
	// START: 	Infinite Scroll
	$(window).scroll(function() {
		if( ( $(window).scrollTop() + $(window).height() ) <= ( $(document).height() - NEAR_BOTTOM_PX ) ) {						
			NEAR_BOTTOM = true;
			if( !POST_APPEND_PROGRESS ) {
				COMMENTS_REMAINING = parseInt( COMMENTS_REMAINING );
				if( COMMENTS_REMAINING > 0 ) {
					POST_APPEND_PROGRESS = true;
					
					// specify target element
					var targetElement = $('#commentList');
					
					// START:	fetch posts
					$.ajax({
						type: 'POST',
						url: BASEURL + '/issue/ajax',
						data: { 
							method: 'getComments', 	
							offset: $('.commentTable').length,
							id: ISSUE_ID
						},
						complete: function( jqXHR, textStatus ) {
							// ...
						},
						success: function( response, textStatus, jqXHRresponse ) {				
							if( response.status == 'OK' ) {
								var posts	= response.data;
								var total 	= parseInt( posts.length );
								var i		= 0;					
								
								if( total > 0 ) {
									COMMENTS_REMAINING = parseInt( COMMENTS_REMAINING - total );
									
									$.each(posts, function( index, value ) {
										i++;
										
										// comments
										posts[index]['comment'] = nl2br( value.comment );
										
										if( i == total ) {
											// add messages to the DOM
											targetElement.append(
												$.render.templateComments( posts )
											);
											
											POST_APPEND_PROGRESS = false;
										}
									});
								}
							} else {
								// ...
							}								
						},
						error: function(  jqXHR, textStatus, errorThrown ) {
							// ...
						},		
						dataType: 'json'
					});										
					// END:		fetch posts
				}	
			}		
		} else {
			NEAR_BOTTOM = false;
		}						
	});		
	// END:		Infinite Scroll
	
	// START:	Commenting
	$('#newComment').bind('keyup', function(event) {
		var value = trim( $(this).val() );
		if( value.length > 0 ) {
			$('#issueAddComment').prop('disabled', false);
		} else {
			$('#issueAddComment').prop('disabled', true);	
		}
	}).autosize();
	
	$('#issueAddComment').click(function(event) {
		event.preventDefault();
		
		// the clicked element
		var ME = $(this);
		
		// disable button
		ME.prop('disabled', true);
		
		// disable comment box
		$('#newComment').prop('disabled', true);
		
		// get comment
		var comment = $('#newComment').val();
		
		// get issue UUID
		var uuid = $(this).data('uuid');
		
		// specify target element
		var targetElement = $('#commentList');
		
		// post comment
		$.ajax({
			type: 'POST',
			url: BASEURL + '/issue/ajax',
			data: { 
				method: 'comment',
				comment: comment,
				uuid: uuid
			},
			complete: function( jqXHR, textStatus ) {
				// enable button
				ME.prop('disabled', false);
				
				// enable comment box
				$('#newComment').prop('disabled', false);
			},
			success: function( response, textStatus, jqXHRresponse ) {
				if( response.status == 'OK' ) {					
					// clear the comment
					$('#newComment').val('');
					
					var data = response.data;					
					if( !empty( data ) ) {
						var i		= 0;
						var total	= count( data );
						
						// iterate
						$.each(data, function( index, value ) {
							data[index]['date'] = date( 'l, F m, Y / h:i:s A e', value.date );
							i++;
							
							if( i == total ) {								
								// add messages to the DOM
								targetElement.append(
									$.render.templateComments( data )
								);	
								
								// update livestamp
								$('#issueLastComment').livestamp( new Date() );
							}
						});
					} else {
						targetElement.append( '<div class="alert alert-danger" role="alert"><i class="fa fa-exclamation-triangle"></i> '+ translate('no_data') +'</div>' );
					}					
				} else {
					if( response.status == 'ERROR' ) {
						targetElement.append( '<div class="alert alert-danger" role="alert"><i class="fa fa-exclamation-triangle"></i> '+ translate( response.error ) +'</div>' );	
					}	
				}
			},
			error: function( jqXHR, textStatus, errorThrown ) {
				targetElement.append( '<div class="alert alert-danger" role="alert"><i class="fa fa-exclamation-triangle"></i> HTTP '+ jqXHR.status + ' ' + translate( errorThrown ) +'</div>' );
			},		
			dataType: 'json'
		});		
	});
	// END:		Commenting
});