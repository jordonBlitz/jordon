/**
 * CloneUI.com - CloneUI Clone
 * Custom JavaScript
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2013 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Wednesday, September 30, 2013, 12:55 PM GMT+1
 * @modified    $Date: 2014-07-29 18:11:41 +0200 (Tue, 29 Jul 2014) $ $Author: bizlogic $
 * @version     $Id: custom.validation.js 22 2014-07-29 16:11:41Z bizlogic $
 *
 * @category    JavaScript
 * @package     CloneUI Clone
*/

function formIsValid( formId, displayErrors )
{
	if( typeof displayErrors === 'undefined' ) {
		var displayErrors = true;
	}
	
	var errors		= new Array();	
	var required	= $('#' + formId).find('input[data-required="1"], textarea[data-required="1"], select[data-required="1"]');
	var dupes		= $('#' + formId).find('input[data-duplicate="1"], textarea[data-duplicate="1"], select[data-duplicate="1"]');
	
	if( !empty( required ) ) {
		required.each( function( index, value ) {
			var id		= $(this).attr('id');
			var myValue = trim( $(this).val() );
			
			if( !strlen( myValue ) ) {
				if( displayErrors ) {
					$('#' + id).addClass('inputError');					
				}

				errors.push( id );
			} else {
				if( $(this).data('type') == 'email' ) {
					if( isValidEmailAddress( myValue ) ) {
						if( displayErrors ) {
							$('#' + id).removeClass('inputError');	
						}
					} else {
						errors.push( id );
						if( displayErrors ) {
							$('#' + id).addClass('inputError');					
						}							
					}						
				}
				
				if( typeof $(this).data('rules') !== 'undefined' ) {
					var rules = $(this).data('rules');
					switch( rules ) {
						case 'alphaNumericAllowDash':
							if( !isAlphaNumericWithSlash( myValue ) ) {
								if( displayErrors ) {
									$('#' + id).addClass('inputError');					
								}
								
								errors.push( id );	
							}
							
							break;
					}
				}
				
				if( typeof $(this).data('duplicate') !== 'undefined' ) {
					var dupeId = $(this).data('duplicate');
										
					if( $(this).val() != $('#' + dupeId).val() ) {					
						errors.push( id );
						errors.push( dupeId );
						
						if( displayErrors ) {
							$('#' + id).addClass('inputError');
							$('#' + dupeId).addClass('inputError');
						}
					}
				}
			}
			
			var type = strtolower( $('#' + id).prop('tagName') );
			switch( type ) {
				case 'select':
					$('#' + id).change(function() {
						var myValue = trim( $(this).val() );
						if( displayErrors ) {
							if( strlen( myValue ) ) {
								if( $(this).data('type') != 'email' ) {
									$('#' + id).removeClass('inputError');						
								} else {
									if( isValidEmailAddress( myValue ) ) {
										$('#' + id).removeClass('inputError');							
									} else {
										$('#' + id).addClass('inputError');							
									}
								}
							} else {
								$('#' + id).addClass('inputError');
							}	
						}
					});
					
					break;
					
				default:
					$('#' + id).bind('keyup paste', function() {
						var myValue = trim( $(this).val() );
						if( displayErrors ) {
							if( strlen( myValue ) ) {
								if( $(this).data('type') != 'email' ) {
									$('#' + id).removeClass('inputError');						
								} else {
									if( isValidEmailAddress( myValue ) ) {
										$('#' + id).removeClass('inputError');							
									} else {
										$('#' + id).addClass('inputError');							
									}
								}	
							} else {
								$('#' + id).addClass('inputError');					
							}
						}
					});						
			}
		
		});		
	}
	
	var errorSize = errors.length;
	if( errorSize > 0 ) {	
		if( displayErrors ) {
			$.each(errors, function( index, value ) {
				var element = $('#' + value);
				element.addClass('inputError');
			});
		}
		
		return false;
	} else {
		if( displayErrors ) {
			required.each( function( index, value ) {
				var id = $(this).attr('id');
				$('#' + id).removeClass('inputError');
			});
		}
		
		return true;		
	}	
}

function getFormErrors( formId )
{
	var errors		= new Array();	
	var required	= $('#' + formId).find('input[data-required="1"], textarea[data-required="1"], select[data-required="1"]');
	
	if( !empty( required ) ) {
		required.each( function( index, value ) {
			var id		= $(this).attr('id');
			var myValue = trim( $(this).val() );
			
			if( !strlen( myValue ) ) {
				errors.push( id );
			} else {
				if( $(this).data('type') == 'email' ) {
					if( !isValidEmailAddress( myValue ) ) {
						errors.push( id );							
					}				
				}
				
				if( typeof $(this).data('rules') !== 'undefined' ) {
					var rules = $(this).data('rules');
					switch( rules ) {
						case 'alphaNumericAllowDash':
							if( !isAlphaNumericWithSlash( myValue ) ) {
								errors.push( id );	
							}
							
							break;
					}
				}				
				
				if( typeof $(this).data('duplicate') !== 'undefined' ) {
					var dupeId = $(this).data('duplicate');
					if( $(this).val() != $('#' + dupeId).val() ) {					
						errors.push( id );
						errors.push( dupeId );							
					}
				}				
			}
		});		
	}
	
	return errors;
}

function isAlphaNumericWithSlash( string )
{
	return string.match(/^[-a-zA-Z0-9]+$/);	
}