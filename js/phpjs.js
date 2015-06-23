/**
 * CloneUI.com - Base Framework
 * phpJS
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 - 2014 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Wednesday, July 10, 2013, 20:49 GMT+1
 * @modified    $Date: 2014-07-28 23:30:47 +0200 (Mon, 28 Jul 2014) $ $Author: bizlogic $
 * @version     $Id: phpjs.js 17 2014-07-28 21:30:47Z bizlogic $
 *
 * @category    JavaScript
 * @package     Base Framework
*/

function base64_encode(data) {
	return B64.encode( data );
}

function base64_decode(data) {
	return B64.decode( data );
}

function ucfirst(str) {
  //  discuss at: http://phpjs.org/functions/ucfirst/
  // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // bugfixed by: Onno Marsman
  // improved by: Brett Zamir (http://brett-zamir.me)
  //   example 1: ucfirst('kevin van zonneveld');
  //   returns 1: 'Kevin van zonneveld'

  str += '';
  var f = str.charAt(0)
    .toUpperCase();
  return f + str.substr(1);
}

// @link	http://www.ferrassi.com/2011/08/javascript-string-truncate-function/
function truncate(text, length, ellipsis) {	 
	// Set length and ellipsis to defaults if not defined
	if (typeof length == 'undefined') var length = 100;
	if (typeof ellipsis == 'undefined') var ellipsis = '...';
	 
	// Return if the text is already lower than the cutoff
	if (text.length < length) return text;
	 
	// Otherwise, check if the last character is a space.
	// If not, keep counting down from the last character
	// until we find a character that is a space
	for (var i = length-1; text.charAt(i) != ' '; i--) {
	length--;
	}
	 
	// The for() loop ends when it finds a space, and the length var
	// has been updated so it doesn't cut in the middle of a word.
	return text.substr(0, length) + ellipsis;
}

function isset() {
  //  discuss at: http://phpjs.org/functions/isset/
  // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // improved by: FremyCompany
  // improved by: Onno Marsman
  // improved by: Rafał Kukawski
  //   example 1: isset( undefined, true);
  //   returns 1: false
  //   example 2: isset( 'Kevin van Zonneveld' );
  //   returns 2: true

  var a = arguments,
    l = a.length,
    i = 0,
    undef;

  if (l === 0) {
    throw new Error('Empty isset');
  }

  while (i !== l) {
    if (a[i] === undef || a[i] === null) {
      return false;
    }
    i++;
  }
  return true;
}

function array_values(input) {
  //  discuss at: http://phpjs.org/functions/array_values/
  // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // improved by: Brett Zamir (http://brett-zamir.me)
  //   example 1: array_values( {firstname: 'Kevin', surname: 'van Zonneveld'} );
  //   returns 1: {0: 'Kevin', 1: 'van Zonneveld'}

  var tmp_arr = [],
    key = '';

  if (input && typeof input === 'object' && input.change_key_case) {
    // Duck-type check for our own array()-created PHPJS_Array
    return input.values();
  }

  for (key in input) {
    tmp_arr[tmp_arr.length] = input[key];
  }

  return tmp_arr;
}

function array_unique(inputArr) {
  //  discuss at: http://phpjs.org/functions/array_unique/
  // original by: Carlos R. L. Rodrigues (http://www.jsfromhell.com)
  //    input by: duncan
  //    input by: Brett Zamir (http://brett-zamir.me)
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // bugfixed by: Nate
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // bugfixed by: Brett Zamir (http://brett-zamir.me)
  // improved by: Michael Grier
  //        note: The second argument, sort_flags is not implemented;
  //        note: also should be sorted (asort?) first according to docs
  //   example 1: array_unique(['Kevin','Kevin','van','Zonneveld','Kevin']);
  //   returns 1: {0: 'Kevin', 2: 'van', 3: 'Zonneveld'}
  //   example 2: array_unique({'a': 'green', 0: 'red', 'b': 'green', 1: 'blue', 2: 'red'});
  //   returns 2: {a: 'green', 0: 'red', 1: 'blue'}

  var key = '',
    tmp_arr2 = {},
    val = '';

  var __array_search = function (needle, haystack) {
    var fkey = '';
    for (fkey in haystack) {
      if (haystack.hasOwnProperty(fkey)) {
        if ((haystack[fkey] + '') === (needle + '')) {
          return fkey;
        }
      }
    }
    return false;
  };

  for (key in inputArr) {
    if (inputArr.hasOwnProperty(key)) {
      val = inputArr[key];
      if (false === __array_search(val, tmp_arr2)) {
        tmp_arr2[key] = val;
      }
    }
  }

  return tmp_arr2;
}

function substr(str, start, len) {
	  //  discuss at: http://phpjs.org/functions/substr/
	  //     version: 909.322
	  // original by: Martijn Wieringa
	  // bugfixed by: T.Wild
	  // improved by: Onno Marsman
	  // improved by: Brett Zamir (http://brett-zamir.me)
	  //  revised by: Theriault
	  //        note: Handles rare Unicode characters if 'unicode.semantics' ini (PHP6) is set to 'on'
	  //   example 1: substr('abcdef', 0, -1);
	  //   returns 1: 'abcde'
	  //   example 2: substr(2, 0, -6);
	  //   returns 2: false
	  //   example 3: ini_set('unicode.semantics',  'on');
	  //   example 3: substr('a\uD801\uDC00', 0, -1);
	  //   returns 3: 'a'
	  //   example 4: ini_set('unicode.semantics',  'on');
	  //   example 4: substr('a\uD801\uDC00', 0, 2);
	  //   returns 4: 'a\uD801\uDC00'
	  //   example 5: ini_set('unicode.semantics',  'on');
	  //   example 5: substr('a\uD801\uDC00', -1, 1);
	  //   returns 5: '\uD801\uDC00'
	  //   example 6: ini_set('unicode.semantics',  'on');
	  //   example 6: substr('a\uD801\uDC00z\uD801\uDC00', -3, 2);
	  //   returns 6: '\uD801\uDC00z'
	  //   example 7: ini_set('unicode.semantics',  'on');
	  //   example 7: substr('a\uD801\uDC00z\uD801\uDC00', -3, -1)
	  //   returns 7: '\uD801\uDC00z'

	  var i = 0,
	    allBMP = true,
	    es = 0,
	    el = 0,
	    se = 0,
	    ret = '';
	  str += '';
	  var end = str.length;

	  // BEGIN REDUNDANT
	  this.php_js = this.php_js || {};
	  this.php_js.ini = this.php_js.ini || {};
	  // END REDUNDANT
	  switch ((this.php_js.ini['unicode.semantics'] && this.php_js.ini['unicode.semantics'].local_value.toLowerCase())) {
	  case 'on':
	    // Full-blown Unicode including non-Basic-Multilingual-Plane characters
	    // strlen()
	    for (i = 0; i < str.length; i++) {
	      if (/[\uD800-\uDBFF]/.test(str.charAt(i)) && /[\uDC00-\uDFFF]/.test(str.charAt(i + 1))) {
	        allBMP = false;
	        break;
	      }
	    }

	    if (!allBMP) {
	      if (start < 0) {
	        for (i = end - 1, es = (start += end); i >= es; i--) {
	          if (/[\uDC00-\uDFFF]/.test(str.charAt(i)) && /[\uD800-\uDBFF]/.test(str.charAt(i - 1))) {
	            start--;
	            es--;
	          }
	        }
	      } else {
	        var surrogatePairs = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g;
	        while ((surrogatePairs.exec(str)) != null) {
	          var li = surrogatePairs.lastIndex;
	          if (li - 2 < start) {
	            start++;
	          } else {
	            break;
	          }
	        }
	      }

	      if (start >= end || start < 0) {
	        return false;
	      }
	      if (len < 0) {
	        for (i = end - 1, el = (end += len); i >= el; i--) {
	          if (/[\uDC00-\uDFFF]/.test(str.charAt(i)) && /[\uD800-\uDBFF]/.test(str.charAt(i - 1))) {
	            end--;
	            el--;
	          }
	        }
	        if (start > end) {
	          return false;
	        }
	        return str.slice(start, end);
	      } else {
	        se = start + len;
	        for (i = start; i < se; i++) {
	          ret += str.charAt(i);
	          if (/[\uD800-\uDBFF]/.test(str.charAt(i)) && /[\uDC00-\uDFFF]/.test(str.charAt(i + 1))) {
	            // Go one further, since one of the "characters" is part of a surrogate pair
	            se++;
	          }
	        }
	        return ret;
	      }
	      break;
	    }
	    // Fall-through
	  case 'off':
	    // assumes there are no non-BMP characters;
	    //    if there may be such characters, then it is best to turn it on (critical in true XHTML/XML)
	  default:
	    if (start < 0) {
	      start += end;
	    }
	    end = typeof len === 'undefined' ? end : (len < 0 ? len + end : len + start);
	    // PHP returns false if start does not fall within the string.
	    // PHP returns false if the calculated end comes before the calculated start.
	    // PHP returns an empty string if start and end are the same.
	    // Otherwise, PHP returns the portion of the string from start to end.
	    return start >= str.length || start < 0 || start > end ? !1 : str.slice(start, end);
	  }
	  // Please Netbeans
	  return undefined;
}

function uniqid (prefix, more_entropy) {
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +    revised by: Kankrelune (http://www.webfaktory.info/)
  // %        note 1: Uses an internal counter (in php_js global) to avoid collision
  // *     example 1: uniqid();
  // *     returns 1: 'a30285b160c14'
  // *     example 2: uniqid('foo');
  // *     returns 2: 'fooa30285b1cd361'
  // *     example 3: uniqid('bar', true);
  // *     returns 3: 'bara20285b23dfd1.31879087'
  if (typeof prefix === 'undefined') {
    prefix = "";
  }

  var retId;
  var formatSeed = function (seed, reqWidth) {
    seed = parseInt(seed, 10).toString(16); // to hex str
    if (reqWidth < seed.length) { // so long we split
      return seed.slice(seed.length - reqWidth);
    }
    if (reqWidth > seed.length) { // so short we pad
      return Array(1 + (reqWidth - seed.length)).join('0') + seed;
    }
    return seed;
  };

  // BEGIN REDUNDANT
  if (!this.php_js) {
    this.php_js = {};
  }
  // END REDUNDANT
  if (!this.php_js.uniqidSeed) { // init seed with big random int
    this.php_js.uniqidSeed = Math.floor(Math.random() * 0x75bcd15);
  }
  this.php_js.uniqidSeed++;

  retId = prefix; // start with prefix, add current milliseconds hex string
  retId += formatSeed(parseInt(new Date().getTime() / 1000, 10), 8);
  retId += formatSeed(this.php_js.uniqidSeed, 5); // add seed hex string
  if (more_entropy) {
    // for more entropy we add a float lower to 10
    retId += (Math.random() * 10).toFixed(8).toString();
  }

  return retId;
}

function round(value, precision, mode) {
  //  discuss at: http://phpjs.org/functions/round/
  // original by: Philip Peterson
  //  revised by: Onno Marsman
  //  revised by: T.Wild
  //  revised by: Rafał Kukawski (http://blog.kukawski.pl/)
  //    input by: Greenseed
  //    input by: meo
  //    input by: William
  //    input by: Josep Sanz (http://www.ws3.es/)
  // bugfixed by: Brett Zamir (http://brett-zamir.me)
  //        note: Great work. Ideas for improvement:
  //        note: - code more compliant with developer guidelines
  //        note: - for implementing PHP constant arguments look at
  //        note: the pathinfo() function, it offers the greatest
  //        note: flexibility & compatibility possible
  //   example 1: round(1241757, -3);
  //   returns 1: 1242000
  //   example 2: round(3.6);
  //   returns 2: 4
  //   example 3: round(2.835, 2);
  //   returns 3: 2.84
  //   example 4: round(1.1749999999999, 2);
  //   returns 4: 1.17
  //   example 5: round(58551.799999999996, 2);
  //   returns 5: 58551.8

  var m, f, isHalf, sgn; // helper variables
  // making sure precision is integer
  precision |= 0;
  m = Math.pow(10, precision);
  value *= m;
  // sign of the number
  sgn = (value > 0) | -(value < 0);
  isHalf = value % 1 === 0.5 * sgn;
  f = Math.floor(value);

  if (isHalf) {
    switch (mode) {
    case 'PHP_ROUND_HALF_DOWN':
      // rounds .5 toward zero
      value = f + (sgn < 0);
      break;
    case 'PHP_ROUND_HALF_EVEN':
      // rouds .5 towards the next even integer
      value = f + (f % 2 * sgn);
      break;
    case 'PHP_ROUND_HALF_ODD':
      // rounds .5 towards the next odd integer
      value = f + !(f % 2);
      break;
    default:
      // rounds .5 away from zero
      value = f + (sgn > 0);
    }
  }

  return (isHalf ? value : Math.round(value)) / m;
}

function abs(mixed_number) {
  //  discuss at: http://phpjs.org/functions/abs/
  // original by: Waldo Malqui Silva
  // improved by: Karol Kowalski
  // improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // improved by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
  //   example 1: abs(4.2);
  //   returns 1: 4.2
  //   example 2: abs(-4.2);
  //   returns 2: 4.2
  //   example 3: abs(-5);
  //   returns 3: 5
  //   example 4: abs('_argos');
  //   returns 4: 0

  return Math.abs(mixed_number) || 0;
}

function nl2br(str, is_xhtml) {
  //  discuss at: http://phpjs.org/functions/nl2br/
  // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // improved by: Philip Peterson
  // improved by: Onno Marsman
  // improved by: Atli Þór
  // improved by: Brett Zamir (http://brett-zamir.me)
  // improved by: Maximusya
  // bugfixed by: Onno Marsman
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  //    input by: Brett Zamir (http://brett-zamir.me)
  //   example 1: nl2br('Kevin\nvan\nZonneveld');
  //   returns 1: 'Kevin<br />\nvan<br />\nZonneveld'
  //   example 2: nl2br("\nOne\nTwo\n\nThree\n", false);
  //   returns 2: '<br>\nOne<br>\nTwo<br>\n<br>\nThree<br>\n'
  //   example 3: nl2br("\nOne\nTwo\n\nThree\n", true);
  //   returns 3: '<br />\nOne<br />\nTwo<br />\n<br />\nThree<br />\n'

  var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br ' + '/>' : '<br>'; // Adjust comment to avoid issue on phpjs.org display

  return (str + '')
    .replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
}

function strip_tags(input, allowed) {
  //  discuss at: http://phpjs.org/functions/strip_tags/
  // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // improved by: Luke Godfrey
  // improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  //    input by: Pul
  //    input by: Alex
  //    input by: Marc Palau
  //    input by: Brett Zamir (http://brett-zamir.me)
  //    input by: Bobby Drake
  //    input by: Evertjan Garretsen
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // bugfixed by: Onno Marsman
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // bugfixed by: Eric Nagel
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // bugfixed by: Tomasz Wesolowski
  //  revised by: Rafał Kukawski (http://blog.kukawski.pl/)
  //   example 1: strip_tags('<p>Kevin</p> <br /><b>van</b> <i>Zonneveld</i>', '<i><b>');
  //   returns 1: 'Kevin <b>van</b> <i>Zonneveld</i>'
  //   example 2: strip_tags('<p>Kevin <img src="someimage.png" onmouseover="someFunction()">van <i>Zonneveld</i></p>', '<p>');
  //   returns 2: '<p>Kevin van Zonneveld</p>'
  //   example 3: strip_tags("<a href='http://kevin.vanzonneveld.net'>Kevin van Zonneveld</a>", "<a>");
  //   returns 3: "<a href='http://kevin.vanzonneveld.net'>Kevin van Zonneveld</a>"
  //   example 4: strip_tags('1 < 5 5 > 1');
  //   returns 4: '1 < 5 5 > 1'
  //   example 5: strip_tags('1 <br/> 1');
  //   returns 5: '1  1'
  //   example 6: strip_tags('1 <br/> 1', '<br>');
  //   returns 6: '1 <br/> 1'
  //   example 7: strip_tags('1 <br/> 1', '<br><br/>');
  //   returns 7: '1 <br/> 1'
  allowed = (((allowed || '') + '')
    .toLowerCase()
    .match(/<[a-z][a-z0-9]*>/g) || [])
    .join(''); // making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)
  var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
    commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
  return input.replace(commentsAndPhpTags, '')
    .replace(tags, function ($0, $1) {
      return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
    });
}
function stripslashes(str) {
  //       discuss at: http://phpjs.org/functions/stripslashes/
  //      original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  //      improved by: Ates Goral (http://magnetiq.com)
  //      improved by: marrtins
  //      improved by: rezna
  //         fixed by: Mick@el
  //      bugfixed by: Onno Marsman
  //      bugfixed by: Brett Zamir (http://brett-zamir.me)
  //         input by: Rick Waldron
  //         input by: Brant Messenger (http://www.brantmessenger.com/)
  // reimplemented by: Brett Zamir (http://brett-zamir.me)
  //        example 1: stripslashes('Kevin\'s code');
  //        returns 1: "Kevin's code"
  //        example 2: stripslashes('Kevin\\\'s code');
  //        returns 2: "Kevin\'s code"

  return (str + '')
    .replace(/\\(.?)/g, function (s, n1) {
      switch (n1) {
      case '\\':
        return '\\';
      case '0':
        return '\u0000';
      case '':
        return '';
      default:
        return n1;
      }
    });
}

function array_search(needle, haystack, argStrict) {
  //  discuss at: http://phpjs.org/functions/array_search/
  // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  //    input by: Brett Zamir (http://brett-zamir.me)
  // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  //  depends on: array
  //        test: skip
  //   example 1: array_search('zonneveld', {firstname: 'kevin', middle: 'van', surname: 'zonneveld'});
  //   returns 1: 'surname'
  //   example 2: ini_set('phpjs.return_phpjs_arrays', 'on');
  //   example 2: var ordered_arr = array({3:'value'}, {2:'value'}, {'a':'value'}, {'b':'value'});
  //   example 2: var key = array_search(/val/g, ordered_arr); // or var key = ordered_arr.search(/val/g);
  //   returns 2: '3'

  var strict = !! argStrict,
    key = '';

  if (haystack && typeof haystack === 'object' && haystack.change_key_case) { // Duck-type check for our own array()-created PHPJS_Array
    return haystack.search(needle, argStrict);
  }
  if (typeof needle === 'object' && needle.exec) { // Duck-type for RegExp
    if (!strict) { // Let's consider case sensitive searches as strict
      var flags = 'i' + (needle.global ? 'g' : '') +
        (needle.multiline ? 'm' : '') +
        (needle.sticky ? 'y' : ''); // sticky is FF only
      needle = new RegExp(needle.source, flags);
    }
    for (key in haystack) {
      if (needle.test(haystack[key])) {
        return key;
      }
    }
    return false;
  }

  for (key in haystack) {
    if ((strict && haystack[key] === needle) || (!strict && haystack[key] == needle)) {
      return key;
    }
  }

  return false;
}

function time_sleep_until(timestamp) {
  //  discuss at: http://phpjs.org/functions/time_sleep_until/
  // original by: Brett Zamir (http://brett-zamir.me)
  //        note: For study purposes. Current implementation could lock up the user's browser.
  //        note: Expects a timestamp in seconds, so DO NOT pass in a JavaScript timestamp which are in milliseconds (e.g., new Date()) or otherwise the function will lock up the browser 1000 times longer than probably intended.
  //        note: Consider using setTimeout() instead.
  //   example 1: time_sleep_until(1233146501) // delays until the time indicated by the given timestamp is reached
  //   returns 1: true

  while (new Date() < timestamp * 1000) {}
  return true;
}

function urlencode (str) {
  // From: http://phpjs.org/functions
  // +   original by: Philip Peterson
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +      input by: AJ
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +      input by: travc
  // +      input by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Lars Fischer
  // +      input by: Ratheous
  // +      reimplemented by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Joris
  // +      reimplemented by: Brett Zamir (http://brett-zamir.me)
  // %          note 1: This reflects PHP 5.3/6.0+ behavior
  // %        note 2: Please be aware that this function expects to encode into UTF-8 encoded strings, as found on
  // %        note 2: pages served as UTF-8
  // *     example 1: urlencode('Kevin van Zonneveld!');
  // *     returns 1: 'Kevin+van+Zonneveld%21'
  // *     example 2: urlencode('http://kevin.vanzonneveld.net/');
  // *     returns 2: 'http%3A%2F%2Fkevin.vanzonneveld.net%2F'
  // *     example 3: urlencode('http://www.google.nl/search?q=php.js&ie=utf-8&oe=utf-8&aq=t&rls=com.ubuntu:en-US:unofficial&client=firefox-a');
  // *     returns 3: 'http%3A%2F%2Fwww.google.nl%2Fsearch%3Fq%3Dphp.js%26ie%3Dutf-8%26oe%3Dutf-8%26aq%3Dt%26rls%3Dcom.ubuntu%3Aen-US%3Aunofficial%26client%3Dfirefox-a'
  str = (str + '').toString();

  // Tilde should be allowed unescaped in future versions of PHP (as reflected below), but if you want to reflect current
  // PHP behavior, you would need to add ".replace(/~/g, '%7E');" to the following.
  return encodeURIComponent(str).replace(/!/g, '%21').replace(/'/g, '%27').replace(/\(/g, '%28').
  replace(/\)/g, '%29').replace(/\*/g, '%2A').replace(/%20/g, '+');
}

function urldecode (str) {
    // From: http://phpjs.org/functions
    // +   original by: Philip Peterson
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +      input by: AJ
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +      input by: travc
    // +      input by: Brett Zamir (http://brett-zamir.me)
    // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Lars Fischer
    // +      input by: Ratheous
    // +   improved by: Orlando
    // +   reimplemented by: Brett Zamir (http://brett-zamir.me)
    // +      bugfixed by: Rob
    // +      input by: e-mike
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +      input by: lovio
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // %        note 1: info on what encoding functions to use from: http://xkr.us/articles/javascript/encode-compare/
    // %        note 2: Please be aware that this function expects to decode from UTF-8 encoded strings, as found on
    // %        note 2: pages served as UTF-8
    // *     example 1: urldecode('Kevin+van+Zonneveld%21');
    // *     returns 1: 'Kevin van Zonneveld!'
    // *     example 2: urldecode('http%3A%2F%2Fkevin.vanzonneveld.net%2F');
    // *     returns 2: 'http://kevin.vanzonneveld.net/'
    // *     example 3: urldecode('http%3A%2F%2Fwww.google.nl%2Fsearch%3Fq%3Dphp.js%26ie%3Dutf-8%26oe%3Dutf-8%26aq%3Dt%26rls%3Dcom.ubuntu%3Aen-US%3Aunofficial%26client%3Dfirefox-a');
    // *     returns 3: 'http://www.google.nl/search?q=php.js&ie=utf-8&oe=utf-8&aq=t&rls=com.ubuntu:en-US:unofficial&client=firefox-a'
    // *     example 4: urldecode('%E5%A5%BD%3_4');
    // *     returns 4: '\u597d%3_4'
    return decodeURIComponent((str + '').replace(/%(?![\da-f]{2})/gi, function () {
        // PHP tolerates poorly formed escape sequences
        return '%25';
    }).replace(/\+/g, '%20'));
}

function bytesToHumanReadable(bytes) {
   var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
   if (bytes == 0) return '0 Bytes';
   var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
   return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
}

function array_diff (arr1) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Sanjoy Roy
  // +    revised by: Brett Zamir (http://brett-zamir.me)
  // *     example 1: array_diff(['Kevin', 'van', 'Zonneveld'], ['van', 'Zonneveld']);
  // *     returns 1: {0:'Kevin'}
  var retArr = {},
    argl = arguments.length,
    k1 = '',
    i = 1,
    k = '',
    arr = {};

  arr1keys: for (k1 in arr1) {
    for (i = 1; i < argl; i++) {
      arr = arguments[i];
      for (k in arr) {
        if (arr[k] === arr1[k1]) {
          // If it reaches here, it was found in at least one array, so try next value
          continue arr1keys;
        }
      }
      retArr[k1] = arr1[k1];
    }
  }

  return retArr;
}

function array_push (inputArr) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // %        note 1: Note also that IE retains information about property position even
  // %        note 1: after being supposedly deleted, so if you delete properties and then
  // %        note 1: add back properties with the same keys (including numeric) that had
  // %        note 1: been deleted, the order will be as before; thus, this function is not
  // %        note 1: really recommended with associative arrays (objects) in IE environments
  // *     example 1: array_push(['kevin','van'], 'zonneveld');
  // *     returns 1: 3
  var i = 0,
    pr = '',
    argv = arguments,
    argc = argv.length,
    allDigits = /^\d$/,
    size = 0,
    highestIdx = 0,
    len = 0;
  if (inputArr.hasOwnProperty('length')) {
    for (i = 1; i < argc; i++) {
      inputArr[inputArr.length] = argv[i];
    }
    return inputArr.length;
  }

  // Associative (object)
  for (pr in inputArr) {
    if (inputArr.hasOwnProperty(pr)) {
      ++len;
      if (pr.search(allDigits) !== -1) {
        size = parseInt(pr, 10);
        highestIdx = size > highestIdx ? size : highestIdx;
      }
    }
  }
  for (i = 1; i < argc; i++) {
    inputArr[++highestIdx] = argv[i];
  }
  return len + i - 1;
}

function is_array (mixed_var) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Legaev Andrey
  // +   bugfixed by: Cord
  // +   bugfixed by: Manish
  // +   improved by: Onno Marsman
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
  // +   improved by: Nathan Sepulveda
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // %        note 1: In php.js, javascript objects are like php associative arrays, thus JavaScript objects will also
  // %        note 1: return true in this function (except for objects which inherit properties, being thus used as objects),
  // %        note 1: unless you do ini_set('phpjs.objectsAsArrays', 0), in which case only genuine JavaScript arrays
  // %        note 1: will return true
  // *     example 1: is_array(['Kevin', 'van', 'Zonneveld']);
  // *     returns 1: true
  // *     example 2: is_array('Kevin van Zonneveld');
  // *     returns 2: false
  // *     example 3: is_array({0: 'Kevin', 1: 'van', 2: 'Zonneveld'});
  // *     returns 3: true
  // *     example 4: is_array(function tmp_a(){this.name = 'Kevin'});
  // *     returns 4: false
  var ini,
    _getFuncName = function (fn) {
      var name = (/\W*function\s+([\w\$]+)\s*\(/).exec(fn);
      if (!name) {
        return '(Anonymous)';
      }
      return name[1];
    },
    _isArray = function (mixed_var) {
      // return Object.prototype.toString.call(mixed_var) === '[object Array]';
      // The above works, but let's do the even more stringent approach: (since Object.prototype.toString could be overridden)
      // Null, Not an object, no length property so couldn't be an Array (or String)
      if (!mixed_var || typeof mixed_var !== 'object' || typeof mixed_var.length !== 'number') {
        return false;
      }
      var len = mixed_var.length;
      mixed_var[mixed_var.length] = 'bogus';
      // The only way I can think of to get around this (or where there would be trouble) would be to have an object defined
      // with a custom "length" getter which changed behavior on each call (or a setter to mess up the following below) or a custom
      // setter for numeric properties, but even that would need to listen for specific indexes; but there should be no false negatives
      // and such a false positive would need to rely on later JavaScript innovations like __defineSetter__
      if (len !== mixed_var.length) { // We know it's an array since length auto-changed with the addition of a
      // numeric property at its length end, so safely get rid of our bogus element
        mixed_var.length -= 1;
        return true;
      }
      // Get rid of the property we added onto a non-array object; only possible
      // side-effect is if the user adds back the property later, it will iterate
      // this property in the older order placement in IE (an order which should not
      // be depended on anyways)
      delete mixed_var[mixed_var.length];
      return false;
    };

  if (!mixed_var || typeof mixed_var !== 'object') {
    return false;
  }

  // BEGIN REDUNDANT
  this.php_js = this.php_js || {};
  this.php_js.ini = this.php_js.ini || {};
  // END REDUNDANT

  ini = this.php_js.ini['phpjs.objectsAsArrays'];

  return _isArray(mixed_var) ||
    // Allow returning true unless user has called
    // ini_set('phpjs.objectsAsArrays', 0) to disallow objects as arrays
    ((!ini || ( // if it's not set to 0 and it's not 'off', check for objects as arrays
    (parseInt(ini.local_value, 10) !== 0 && (!ini.local_value.toLowerCase || ini.local_value.toLowerCase() !== 'off')))
    ) && (
    Object.prototype.toString.call(mixed_var) === '[object Object]' && _getFuncName(mixed_var.constructor) === 'Object' // Most likely a literal and intended as assoc. array
    ));
}

function preg_match(pattern, subject)
{
    var offset = ( arguments.length >= 5 ) ? arguments[4] : 0;
    var flags = ( arguments.length >= 4 ) ? arguments[3] : 0;
    var matches = ( arguments.length >= 3 ) ? arguments[2] : null;

    var result = null;
    var regexp = new RegExp(pattern);
    regexp.lastIndex = offset;

    if( (result = regexp.exec(subject)) )
    {
        if( is_array(matches) )
        {
            matches.splice(0, matches.length);

            for( i = 0; i < result.length; i ++ )
            {
                matches.push(( flags == 'PREG_OFFSET_CAPTURE' ) ? new Array(result[i].toString(), (( i == 0 ) ? result.index : -1)) : result[i].toString());
            }
        }

        return( 1 );
    }
    else
    {
        return( 0 );
    }
}

function preg_replace(pattern, replacement, subject)
{
    var count = ( arguments.length >= 5 ) ? arguments[4] : 0;
    var limit = ( arguments.length >= 4 ) ? arguments[3] : -1;

    new_subject = ( !is_array(subject) ) ? new Array(subject) : subject;
    new_pattern = ( !is_array(pattern) ) ? new Array(pattern) : pattern;

    var key_1;
    var key_2;
    var i = 0;

    for( key_1 in new_subject )
    {
        for( key_2 in new_pattern )
        {
            if( !is_array(replacement) )
            {
                var new_replacement = replacement;
            }
            else
            {
                var new_replacement = ( isset(replacement[key_2]) ) ? replacement[key_2] : '';
            }

            for( i = 0; is_null(limit) || limit == -1 || i < limit; )
            {
                var newest_subject = new_subject[key_1].replace(new_pattern[key_2], new_replacement);

                if( newest_subject != new_subject[key_1] )
                {
                    new_subject[key_1] = newest_subject;

                    i ++;
                }
                else
                {
                    break;
                }
            }

            count += i;
        }
    }

    return( ( !is_array(subject) ) ? new_subject[0] : new_subject );
}

function preg_split(pattern, subject)
{
    var flags = ( arguments.length >= 4 ) ? arguments[3] : 0;
    var limit = ( arguments.length >= 3 ) ? arguments[2] : -1;

    var splitted_subject = subject.split(pattern);

    var regexp = new RegExp(pattern.source, (( pattern.ignoreCase ) ? 'i' : '')+(( pattern.multiline ) ? 'm' : '')+'g');
    var match = null;

    var return_array = new Array();
    var position = 0;
    var i = 0;
    var j = 0;

    while( (match = regexp.exec(subject)) )
    {
        if( is_null(limit) || limit == -1 || i < limit )
        {
            if( flags == 'PREG_SPLIT_NO_EMPTY' && match.index == position )
            {
                continue;
            }
            else
            {
                i ++;
            }

            var string = subject.substr(position, match.index - position);

            return_array.push(( flags == 'PREG_SPLIT_OFFSET_CAPTURE' ) ? new Array(string, position) : string);

            position = match.index + match[0].length;

            if( flags == 'PREG_SPLIT_DELIM_CAPTURE' )
            {
                if( match.length == 2 && match[0] == match[1] )
                {
                    return_array.push(( flags == 'PREG_SPLIT_OFFSET_CAPTURE' ) ? new Array(match[0], match.index) : match[0]);
                }
                else
                {
                    for( j = 1; j < match.length; j ++ )
                    {
                        return_array.push(( flags == 'PREG_SPLIT_OFFSET_CAPTURE' ) ? new Array(match[j], -1) : match[j]);
                    }
                }
            }
        }
        else
        {
            break;
        }
    }

    if( position < subject.length )
    {
        var string = subject.substr(position);

        return_array.push(( flags == 'PREG_SPLIT_OFFSET_CAPTURE' ) ? new Array(string, position) : string);
    }

    return( return_array );
}

function strtotime (text, now) {
    // Convert string representation of date and time to a timestamp
    //
    // version: 1109.2015
    // discuss at: http://phpjs.org/functions/strtotime
    // +   original by: Caio Ariede (http://caioariede.com)
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +      input by: David
    // +   improved by: Caio Ariede (http://caioariede.com)
    // +   bugfixed by: Wagner B. Soares
    // +   bugfixed by: Artur Tchernychev
    // +   improved by: A. Matías Quezada (http://amatiasq.com)
    // +   improved by: preuter
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // %        note 1: Examples all have a fixed timestamp to prevent tests to fail because of variable time(zones)
    // *     example 1: strtotime('+1 day', 1129633200);
    // *     returns 1: 1129719600
    // *     example 2: strtotime('+1 week 2 days 4 hours 2 seconds', 1129633200);
    // *     returns 2: 1130425202
    // *     example 3: strtotime('last month', 1129633200);
    // *     returns 3: 1127041200
    // *     example 4: strtotime('2009-05-04 08:30:00');
    // *     returns 4: 1241418600
    var parsed, match, year, date, days, ranges, len, times, regex, i;

    if (!text) {
        return null;
    }

    // Unecessary spaces
    text = text.replace(/^\s+|\s+$/g, '')
        .replace(/\s{2,}/g, ' ')
        .replace(/[\t\r\n]/g, '')
        .toLowerCase();

    if (text === 'now') {
        return now === null || isNaN(now) ? new Date().getTime() / 1000 | 0 : now | 0;
    }
    if (!isNaN(parsed = Date.parse(text))) {
        return parsed / 1000 | 0;
    }
    if (text === 'now') {
        return new Date().getTime() / 1000; // Return seconds, not milli-seconds
    }
    if (!isNaN(parsed = Date.parse(text))) {
        return parsed / 1000;
    }

    match = text.match(/^(\d{2,4})-(\d{2})-(\d{2})(?:\s(\d{1,2}):(\d{2})(?::\d{2})?)?(?:\.(\d+)?)?$/);
    if (match) {
        year = match[1] >= 0 && match[1] <= 69 ? +match[1] + 2000 : match[1];
        return new Date(year, parseInt(match[2], 10) - 1, match[3],
            match[4] || 0, match[5] || 0, match[6] || 0, match[7] || 0) / 1000;
    }

    date = now ? new Date(now * 1000) : new Date();
    days = {
        'sun': 0,
        'mon': 1,
        'tue': 2,
        'wed': 3,
        'thu': 4,
        'fri': 5,
        'sat': 6
    };
    ranges = {
        'yea': 'FullYear',
        'mon': 'Month',
        'day': 'Date',
        'hou': 'Hours',
        'min': 'Minutes',
        'sec': 'Seconds'
    };

    function lastNext(type, range, modifier) {
        var diff, day = days[range];

        if (typeof day !== 'undefined') {
            diff = day - date.getDay();

            if (diff === 0) {
                diff = 7 * modifier;
            }
            else if (diff > 0 && type === 'last') {
                diff -= 7;
            }
            else if (diff < 0 && type === 'next') {
                diff += 7;
            }

            date.setDate(date.getDate() + diff);
        }
    }
    function process(val) {
        var splt = val.split(' '), // Todo: Reconcile this with regex using \s, taking into account browser issues with split and regexes
            type = splt[0],
            range = splt[1].substring(0, 3),
            typeIsNumber = /\d+/.test(type),
            ago = splt[2] === 'ago',
            num = (type === 'last' ? -1 : 1) * (ago ? -1 : 1);

        if (typeIsNumber) {
            num *= parseInt(type, 10);
        }

        if (ranges.hasOwnProperty(range) && !splt[1].match(/^mon(day|\.)?$/i)) {
            return date['set' + ranges[range]](date['get' + ranges[range]]() + num);
        }
        if (range === 'wee') {
            return date.setDate(date.getDate() + (num * 7));
        }

        if (type === 'next' || type === 'last') {
            lastNext(type, range, num);
        }
        else if (!typeIsNumber) {
            return false;
        }
        return true;
    }

    times = '(years?|months?|weeks?|days?|hours?|minutes?|min|seconds?|sec' +
        '|sunday|sun\\.?|monday|mon\\.?|tuesday|tue\\.?|wednesday|wed\\.?' +
        '|thursday|thu\\.?|friday|fri\\.?|saturday|sat\\.?)';
    regex = '([+-]?\\d+\\s' + times + '|' + '(last|next)\\s' + times + ')(\\sago)?';

    match = text.match(new RegExp(regex, 'gi'));
    if (!match) {
        return false;
    }

    for (i = 0, len = match.length; i < len; i++) {
        if (!process(match[i])) {
            return false;
        }
    }

    // ECMAScript 5 only
    //if (!match.every(process))
    //    return false;

    return (date.getTime() / 1000);
}

function time () {
  // http://kevin.vanzonneveld.net
  // +   original by: GeekFG (http://geekfg.blogspot.com)
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: metjay
  // +   improved by: HKM
  // *     example 1: timeStamp = time();
  // *     results 1: timeStamp > 1000000000 && timeStamp < 2000000000
  return Math.floor(new Date().getTime() / 1000);
}

function date (format, timestamp) {
  // http://kevin.vanzonneveld.net
  // +   original by: Carlos R. L. Rodrigues (http://www.jsfromhell.com)
  // +      parts by: Peter-Paul Koch (http://www.quirksmode.org/js/beat.html)
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: MeEtc (http://yass.meetcweb.com)
  // +   improved by: Brad Touesnard
  // +   improved by: Tim Wiel
  // +   improved by: Bryan Elliott
  // +   improved by: David Randall
  // +      input by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Theriault
  // +  derived from: gettimeofday
  // +      input by: majak
  // +   bugfixed by: majak
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +      input by: Alex
  // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
  // +   improved by: Theriault
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // +   improved by: Theriault
  // +   improved by: Thomas Beaucourt (http://www.webapp.fr)
  // +   improved by: JT
  // +   improved by: Theriault
  // +   improved by: Rafał Kukawski (http://blog.kukawski.pl)
  // +   bugfixed by: omid (http://phpjs.org/functions/380:380#comment_137122)
  // +      input by: Martin
  // +      input by: Alex Wilson
  // +      input by: Haravikk
  // +   improved by: Theriault
  // +   bugfixed by: Chris (http://www.devotis.nl/)
  // %        note 1: Uses global: php_js to store the default timezone
  // %        note 2: Although the function potentially allows timezone info (see notes), it currently does not set
  // %        note 2: per a timezone specified by date_default_timezone_set(). Implementers might use
  // %        note 2: this.php_js.currentTimezoneOffset and this.php_js.currentTimezoneDST set by that function
  // %        note 2: in order to adjust the dates in this function (or our other date functions!) accordingly
  // *     example 1: date('H:m:s \\m \\i\\s \\m\\o\\n\\t\\h', 1062402400);
  // *     returns 1: '09:09:40 m is month'
  // *     example 2: date('F j, Y, g:i a', 1062462400);
  // *     returns 2: 'September 2, 2003, 2:26 am'
  // *     example 3: date('Y W o', 1062462400);
  // *     returns 3: '2003 36 2003'
  // *     example 4: x = date('Y m d', (new Date()).getTime()/1000);
  // *     example 4: (x+'').length == 10 // 2009 01 09
  // *     returns 4: true
  // *     example 5: date('W', 1104534000);
  // *     returns 5: '53'
  // *     example 6: date('B t', 1104534000);
  // *     returns 6: '999 31'
  // *     example 7: date('W U', 1293750000.82); // 2010-12-31
  // *     returns 7: '52 1293750000'
  // *     example 8: date('W', 1293836400); // 2011-01-01
  // *     returns 8: '52'
  // *     example 9: date('W Y-m-d', 1293974054); // 2011-01-02
  // *     returns 9: '52 2011-01-02'
    var that = this,
      jsdate,
      f,
      // Keep this here (works, but for code commented-out
      // below for file size reasons)
      //, tal= [],
      txt_words = ["Sun", "Mon", "Tues", "Wednes", "Thurs", "Fri", "Satur", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
      // trailing backslash -> (dropped)
      // a backslash followed by any character (including backslash) -> the character
      // empty string -> empty string
      formatChr = /\\?(.?)/gi,
      formatChrCb = function (t, s) {
        return f[t] ? f[t]() : s;
      },
      _pad = function (n, c) {
        n = String(n);
        while (n.length < c) {
          n = '0' + n;
        }
        return n;
      };
  f = {
    // Day
    d: function () { // Day of month w/leading 0; 01..31
      return _pad(f.j(), 2);
    },
    D: function () { // Shorthand day name; Mon...Sun
      return f.l().slice(0, 3);
    },
    j: function () { // Day of month; 1..31
      return jsdate.getDate();
    },
    l: function () { // Full day name; Monday...Sunday
      return txt_words[f.w()] + 'day';
    },
    N: function () { // ISO-8601 day of week; 1[Mon]..7[Sun]
      return f.w() || 7;
    },
    S: function(){ // Ordinal suffix for day of month; st, nd, rd, th
      var j = f.j(),
        i = j%10;
      if (i <= 3 && parseInt((j%100)/10, 10) == 1) {
        i = 0;
      }
      return ['st', 'nd', 'rd'][i - 1] || 'th';
    },
    w: function () { // Day of week; 0[Sun]..6[Sat]
      return jsdate.getDay();
    },
    z: function () { // Day of year; 0..365
      var a = new Date(f.Y(), f.n() - 1, f.j()),
        b = new Date(f.Y(), 0, 1);
      return Math.round((a - b) / 864e5);
    },

    // Week
    W: function () { // ISO-8601 week number
      var a = new Date(f.Y(), f.n() - 1, f.j() - f.N() + 3),
        b = new Date(a.getFullYear(), 0, 4);
      return _pad(1 + Math.round((a - b) / 864e5 / 7), 2);
    },

    // Month
    F: function () { // Full month name; January...December
      return txt_words[6 + f.n()];
    },
    m: function () { // Month w/leading 0; 01...12
      return _pad(f.n(), 2);
    },
    M: function () { // Shorthand month name; Jan...Dec
      return f.F().slice(0, 3);
    },
    n: function () { // Month; 1...12
      return jsdate.getMonth() + 1;
    },
    t: function () { // Days in month; 28...31
      return (new Date(f.Y(), f.n(), 0)).getDate();
    },

    // Year
    L: function () { // Is leap year?; 0 or 1
      var j = f.Y();
      return j % 4 === 0 & j % 100 !== 0 | j % 400 === 0;
    },
    o: function () { // ISO-8601 year
      var n = f.n(),
        W = f.W(),
        Y = f.Y();
      return Y + (n === 12 && W < 9 ? 1 : n === 1 && W > 9 ? -1 : 0);
    },
    Y: function () { // Full year; e.g. 1980...2010
      return jsdate.getFullYear();
    },
    y: function () { // Last two digits of year; 00...99
      return f.Y().toString().slice(-2);
    },

    // Time
    a: function () { // am or pm
      return jsdate.getHours() > 11 ? "pm" : "am";
    },
    A: function () { // AM or PM
      return f.a().toUpperCase();
    },
    B: function () { // Swatch Internet time; 000..999
      var H = jsdate.getUTCHours() * 36e2,
        // Hours
        i = jsdate.getUTCMinutes() * 60,
        // Minutes
        s = jsdate.getUTCSeconds(); // Seconds
      return _pad(Math.floor((H + i + s + 36e2) / 86.4) % 1e3, 3);
    },
    g: function () { // 12-Hours; 1..12
      return f.G() % 12 || 12;
    },
    G: function () { // 24-Hours; 0..23
      return jsdate.getHours();
    },
    h: function () { // 12-Hours w/leading 0; 01..12
      return _pad(f.g(), 2);
    },
    H: function () { // 24-Hours w/leading 0; 00..23
      return _pad(f.G(), 2);
    },
    i: function () { // Minutes w/leading 0; 00..59
      return _pad(jsdate.getMinutes(), 2);
    },
    s: function () { // Seconds w/leading 0; 00..59
      return _pad(jsdate.getSeconds(), 2);
    },
    u: function () { // Microseconds; 000000-999000
      return _pad(jsdate.getMilliseconds() * 1000, 6);
    },

    // Timezone
    e: function () { // Timezone identifier; e.g. Atlantic/Azores, ...
      // The following works, but requires inclusion of the very large
      // timezone_abbreviations_list() function.
      
      if( typeof date_default_timezone_get !== 'undefined' ) {
          return that.date_default_timezone_get();    	  
      } else {
          throw 'Not supported (see source code of date() for timezone on how to add support)';    	  
      }

    },
    I: function () { // DST observed?; 0 or 1
      // Compares Jan 1 minus Jan 1 UTC to Jul 1 minus Jul 1 UTC.
      // If they are not equal, then DST is observed.
      var a = new Date(f.Y(), 0),
        // Jan 1
        c = Date.UTC(f.Y(), 0),
        // Jan 1 UTC
        b = new Date(f.Y(), 6),
        // Jul 1
        d = Date.UTC(f.Y(), 6); // Jul 1 UTC
      return ((a - c) !== (b - d)) ? 1 : 0;
    },
    O: function () { // Difference to GMT in hour format; e.g. +0200
      var tzo = jsdate.getTimezoneOffset(),
        a = Math.abs(tzo);
      return (tzo > 0 ? "-" : "+") + _pad(Math.floor(a / 60) * 100 + a % 60, 4);
    },
    P: function () { // Difference to GMT w/colon; e.g. +02:00
      var O = f.O();
      return (O.substr(0, 3) + ":" + O.substr(3, 2));
    },
    T: function () { // Timezone abbreviation; e.g. EST, MDT, ...
      // The following works, but requires inclusion of the very
      // large timezone_abbreviations_list() function.
      var abbr = '', i = 0, os = 0; 
      var defaultVar = 0;
      if (!tal.length) {
        tal = that.timezone_abbreviations_list();
      }
      if (that.php_js && that.php_js.default_timezone) {
        defaultVar = that.php_js.default_timezone;
        for (abbr in tal) {
          for (i=0; i < tal[abbr].length; i++) {
            if (tal[abbr][i].timezone_id === defaultVar) {
              return abbr.toUpperCase();
            }
          }
        }
      }
      for (abbr in tal) {
        for (i = 0; i < tal[abbr].length; i++) {
          os = -jsdate.getTimezoneOffset() * 60;
          if (tal[abbr][i].offset === os) {
            return abbr.toUpperCase();
          }
        }
      }
      return 'UTC';
    },
    Z: function () { // Timezone offset in seconds (-43200...50400)
      return -jsdate.getTimezoneOffset() * 60;
    },

    // Full Date/Time
    c: function () { // ISO-8601 date.
      return 'Y-m-d\\TH:i:sP'.replace(formatChr, formatChrCb);
    },
    r: function () { // RFC 2822
      return 'D, d M Y H:i:s O'.replace(formatChr, formatChrCb);
    },
    U: function () { // Seconds since UNIX epoch
      return jsdate / 1000 | 0;
    }
  };
  this.date = function (format, timestamp) {
    that = this;
    jsdate = (timestamp === undefined ? new Date() : // Not provided
      (timestamp instanceof Date) ? new Date(timestamp) : // JS Date()
      new Date(timestamp * 1000) // UNIX timestamp (auto-convert to int)
    );
    return format.replace(formatChr, formatChrCb);
  };
  return this.date(format, timestamp);
}

function str_ireplace (search, replace, subject) {
  // http://kevin.vanzonneveld.net
  // +   original by: Martijn Wieringa
  // +      input by: penutbutterjelly
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +    tweaked by: Jack
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   bugfixed by: Onno Marsman
  // +      input by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   bugfixed by: Philipp Lenssen
  // *     example 1: str_ireplace('l', 'l', 'HeLLo');
  // *     returns 1: 'Hello'
  // *     example 2: str_ireplace('$', 'foo', '$bar');
  // *     returns 2: 'foobar'
  var i, k = '';
  var searchl = 0;
  var reg;

  var escapeRegex = function (s) {
    return s.replace(/([\\\^\$*+\[\]?{}.=!:(|)])/g, '\\$1');
  };

  search += '';
  searchl = search.length;
  if (Object.prototype.toString.call(replace) !== '[object Array]') {
    replace = [replace];
    if (Object.prototype.toString.call(search) === '[object Array]') {
      // If search is an array and replace is a string,
      // then this replacement string is used for every value of search
      while (searchl > replace.length) {
        replace[replace.length] = replace[0];
      }
    }
  }

  if (Object.prototype.toString.call(search) !== '[object Array]') {
    search = [search];
  }
  while (search.length > replace.length) {
    // If replace has fewer values than search,
    // then an empty string is used for the rest of replacement values
    replace[replace.length] = '';
  }

  if (Object.prototype.toString.call(subject) === '[object Array]') {
    // If subject is an array, then the search and replace is performed
    // with every entry of subject , and the return value is an array as well.
    for (k in subject) {
      if (subject.hasOwnProperty(k)) {
        subject[k] = str_ireplace(search, replace, subject[k]);
      }
    }
    return subject;
  }

  searchl = search.length;
  for (i = 0; i < searchl; i++) {
    reg = new RegExp(escapeRegex(search[i]), 'gi');
    subject = subject.replace(reg, replace[i]);
  }

  return subject;
}

function str_replace (search, replace, subject, count) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Gabriel Paderni
  // +   improved by: Philip Peterson
  // +   improved by: Simon Willison (http://simonwillison.net)
  // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
  // +   bugfixed by: Anton Ongson
  // +      input by: Onno Marsman
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +    tweaked by: Onno Marsman
  // +      input by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   input by: Oleg Eremeev
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Oleg Eremeev
  // %          note 1: The count parameter must be passed as a string in order
  // %          note 1:  to find a global variable in which the result will be given
  // *     example 1: str_replace(' ', '.', 'Kevin van Zonneveld');
  // *     returns 1: 'Kevin.van.Zonneveld'
  // *     example 2: str_replace(['{name}', 'l'], ['hello', 'm'], '{name}, lars');
  // *     returns 2: 'hemmo, mars'
  var i = 0,
    j = 0,
    temp = '',
    repl = '',
    sl = 0,
    fl = 0,
    f = [].concat(search),
    r = [].concat(replace),
    s = subject,
    ra = Object.prototype.toString.call(r) === '[object Array]',
    sa = Object.prototype.toString.call(s) === '[object Array]';
  s = [].concat(s);
  if (count) {
    this.window[count] = 0;
  }

  for (i = 0, sl = s.length; i < sl; i++) {
    if (s[i] === '') {
      continue;
    }
    for (j = 0, fl = f.length; j < fl; j++) {
      temp = s[i] + '';
      repl = ra ? (r[j] !== undefined ? r[j] : '') : r[0];
      s[i] = (temp).split(f[j]).join(repl);
      if (count && s[i] !== temp) {
        this.window[count] += (temp.length - s[i].length) / f[j].length;
      }
    }
  }
  return sa ? s : s[0];
}

function array_intersect (arr1) {
  // http://kevin.vanzonneveld.net
  // +   original by: Brett Zamir (http://brett-zamir.me)
  // %        note 1: These only output associative arrays (would need to be
  // %        note 1: all numeric and counting from zero to be numeric)
  // *     example 1: $array1 = {'a' : 'green', 0:'red', 1: 'blue'};
  // *     example 1: $array2 = {'b' : 'green', 0:'yellow', 1:'red'};
  // *     example 1: $array3 = ['green', 'red'];
  // *     example 1: $result = array_intersect($array1, $array2, $array3);
  // *     returns 1: {0: 'red', a: 'green'}
  var retArr = {},
    argl = arguments.length,
    arglm1 = argl - 1,
    k1 = '',
    arr = {},
    i = 0,
    k = '';

  arr1keys: for (k1 in arr1) {
    arrs: for (i = 1; i < argl; i++) {
      arr = arguments[i];
      for (k in arr) {
        if (arr[k] === arr1[k1]) {
          if (i === arglm1) {
            retArr[k1] = arr1[k1];
          }
          // If the innermost loop always leads at least once to an equal value, continue the loop until done
          continue arrs;
        }
      }
      // If it reaches here, it wasn't found in at least one array, so try next value
      continue arr1keys;
    }
  }

  return retArr;
}

function implode (glue, pieces) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Waldo Malqui Silva
  // +   improved by: Itsacon (http://www.itsacon.net/)
  // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
  // *     example 1: implode(' ', ['Kevin', 'van', 'Zonneveld']);
  // *     returns 1: 'Kevin van Zonneveld'
  // *     example 2: implode(' ', {first:'Kevin', last: 'van Zonneveld'});
  // *     returns 2: 'Kevin van Zonneveld'
  var i = '',
    retVal = '',
    tGlue = '';
  if (arguments.length === 1) {
    pieces = glue;
    glue = '';
  }
  if (typeof pieces === 'object') {
    if (Object.prototype.toString.call(pieces) === '[object Array]') {
      return pieces.join(glue);
    }
    for (i in pieces) {
      retVal += tGlue + pieces[i];
      tGlue = glue;
    }
    return retVal;
  }
  return pieces;
}

function in_array (needle, haystack, argStrict) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: vlado houba
  // +   input by: Billy
  // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
  // *     example 1: in_array('van', ['Kevin', 'van', 'Zonneveld']);
  // *     returns 1: true
  // *     example 2: in_array('vlado', {0: 'Kevin', vlado: 'van', 1: 'Zonneveld'});
  // *     returns 2: false
  // *     example 3: in_array(1, ['1', '2', '3']);
  // *     returns 3: true
  // *     example 3: in_array(1, ['1', '2', '3'], false);
  // *     returns 3: true
  // *     example 4: in_array(1, ['1', '2', '3'], true);
  // *     returns 4: false
  var key = '',
    strict = !! argStrict;

  if (strict) {
    for (key in haystack) {
      if (haystack[key] === needle) {
        return true;
      }
    }
  } else {
    for (key in haystack) {
      if (haystack[key] == needle) {
        return true;
      }
    }
  }

  return false;
}

// @link	http://blog.snowfinch.net/post/3254029029/uuid-v4-js
function uuid() {
  var uuid = "", i, random;
  for (i = 0; i < 32; i++) {
    random = Math.random() * 16 | 0;

    if (i == 8 || i == 12 || i == 16 || i == 20) {
      uuid += "-"
    }
    uuid += (i == 12 ? 4 : (i == 16 ? (random & 3 | 8) : random)).toString(16);
  }
  return uuid;
}

function count (mixed_var, mode) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +      input by: Waldo Malqui Silva
  // +   bugfixed by: Soren Hansen
  // +      input by: merabi
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Olivier Louvignes (http://mg-crea.com/)
  // *     example 1: count([[0,0],[0,-4]], 'COUNT_RECURSIVE');
  // *     returns 1: 6
  // *     example 2: count({'one' : [1,2,3,4,5]}, 'COUNT_RECURSIVE');
  // *     returns 2: 6
  var key, cnt = 0;

  if (mixed_var === null || typeof mixed_var === 'undefined') {
    return 0;
  } else if (mixed_var.constructor !== Array && mixed_var.constructor !== Object) {
    return 1;
  }

  if (mode === 'COUNT_RECURSIVE') {
    mode = 1;
  }
  if (mode != 1) {
    mode = 0;
  }

  for (key in mixed_var) {
    if (mixed_var.hasOwnProperty(key)) {
      cnt++;
      if (mode == 1 && mixed_var[key] && (mixed_var[key].constructor === Array || mixed_var[key].constructor === Object)) {
        cnt += this.count(mixed_var[key], 1);
      }
    }
  }

  return cnt;
}

function explode (delimiter, string, limit) {
  if ( arguments.length < 2 || typeof delimiter === 'undefined' || typeof string === 'undefined' ) return null;
  if ( delimiter === '' || delimiter === false || delimiter === null) return false;
  if ( typeof delimiter === 'function' || typeof delimiter === 'object' || typeof string === 'function' || typeof string === 'object'){
    return { 0: '' };
  }
  if ( delimiter === true ) delimiter = '1';

  // Here we go...
  delimiter += '';
  string += '';

  var s = string.split( delimiter );


  if ( typeof limit === 'undefined' ) return s;

  // Support for limit
  if ( limit === 0 ) limit = 1;

  // Positive limit
  if ( limit > 0 ){
    if ( limit >= s.length ) return s;
    return s.slice( 0, limit - 1 ).concat( [ s.slice( limit - 1 ).join( delimiter ) ] );
  }

  // Negative limit
  if ( -limit >= s.length ) return [];

  s.splice( s.length + limit );
  return s;
}

function array_rand (input, num_req) {
  // http://kevin.vanzonneveld.net
  // +   original by: Waldo Malqui Silva
  // *     example 1: array_rand( ['Kevin'], 1 );
  // *     returns 1: 0
  var indexes = [];
  var ticks = num_req || 1;
  var checkDuplicate = function (input, value) {
    var exist = false,
      index = 0,
      il = input.length;
    while (index < il) {
      if (input[index] === value) {
        exist = true;
        break;
      }
      index++;
    }
    return exist;
  };

  if (Object.prototype.toString.call(input) === '[object Array]' && ticks <= input.length) {
    while (true) {
      var rand = Math.floor((Math.random() * input.length));
      if (indexes.length === ticks) {
        break;
      }
      if (!checkDuplicate(indexes, rand)) {
        indexes.push(rand);
      }
    }
  } else {
    indexes = null;
  }

  return ((ticks == 1) ? indexes.join() : indexes);
}

function is_null (mixed_var) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // *     example 1: is_null('23');
  // *     returns 1: false
  // *     example 2: is_null(null);
  // *     returns 2: true
  return (mixed_var === null);
}

function utf8_encode (argString) {
  // http://kevin.vanzonneveld.net
  // +   original by: Webtoolkit.info (http://www.webtoolkit.info/)
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: sowberry
  // +    tweaked by: Jack
  // +   bugfixed by: Onno Marsman
  // +   improved by: Yves Sucaet
  // +   bugfixed by: Onno Marsman
  // +   bugfixed by: Ulrich
  // +   bugfixed by: Rafal Kukawski
  // +   improved by: kirilloid
  // +   bugfixed by: kirilloid
  // *     example 1: utf8_encode('Kevin van Zonneveld');
  // *     returns 1: 'Kevin van Zonneveld'

  if (argString === null || typeof argString === "undefined") {
    return "";
  }

  var string = (argString + ''); // .replace(/\r\n/g, "\n").replace(/\r/g, "\n");
  var utftext = '',
    start, end, stringl = 0;

  start = end = 0;
  stringl = string.length;
  for (var n = 0; n < stringl; n++) {
    var c1 = string.charCodeAt(n);
    var enc = null;

    if (c1 < 128) {
      end++;
    } else if (c1 > 127 && c1 < 2048) {
      enc = String.fromCharCode(
         (c1 >> 6)        | 192,
        ( c1        & 63) | 128
      );
    } else if (c1 & 0xF800 != 0xD800) {
      enc = String.fromCharCode(
         (c1 >> 12)       | 224,
        ((c1 >> 6)  & 63) | 128,
        ( c1        & 63) | 128
      );
    } else { // surrogate pairs
      if (c1 & 0xFC00 != 0xD800) { throw new RangeError("Unmatched trail surrogate at " + n); }
      var c2 = string.charCodeAt(++n);
      if (c2 & 0xFC00 != 0xDC00) { throw new RangeError("Unmatched lead surrogate at " + (n-1)); }
      c1 = ((c1 & 0x3FF) << 10) + (c2 & 0x3FF) + 0x10000;
      enc = String.fromCharCode(
         (c1 >> 18)       | 240,
        ((c1 >> 12) & 63) | 128,
        ((c1 >> 6)  & 63) | 128,
        ( c1        & 63) | 128
      );
    }
    if (enc !== null) {
      if (end > start) {
        utftext += string.slice(start, end);
      }
      utftext += enc;
      start = end = n + 1;
    }
  }

  if (end > start) {
    utftext += string.slice(start, stringl);
  }

  return utftext;
}

function utf8_decode (str_data) {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Webtoolkit.info (http://www.webtoolkit.info/)
	  // +      input by: Aman Gupta
	  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +   improved by: Norman "zEh" Fuchs
	  // +   bugfixed by: hitwork
	  // +   bugfixed by: Onno Marsman
	  // +      input by: Brett Zamir (http://brett-zamir.me)
	  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +   bugfixed by: kirilloid
	  // *     example 1: utf8_decode('Kevin van Zonneveld');
	  // *     returns 1: 'Kevin van Zonneveld'

	  var tmp_arr = [],
	    i = 0,
	    ac = 0,
	    c1 = 0,
	    c2 = 0,
	    c3 = 0,
	    c4 = 0;

	  str_data += '';

	  while (i < str_data.length) {
	    c1 = str_data.charCodeAt(i);
	    if (c1 <= 191) {
	      tmp_arr[ac++] = String.fromCharCode(c1);
	      i++;
	    } else if (c1 <= 223) {
	      c2 = str_data.charCodeAt(i + 1);
	      tmp_arr[ac++] = String.fromCharCode(((c1 & 31) << 6) | (c2 & 63));
	      i += 2;
	    } else if (c1 <= 239) {
	      // http://en.wikipedia.org/wiki/UTF-8#Codepage_layout
	      c2 = str_data.charCodeAt(i + 1);
	      c3 = str_data.charCodeAt(i + 2);
	      tmp_arr[ac++] = String.fromCharCode(((c1 & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
	      i += 3;
	    } else {
	      c2 = str_data.charCodeAt(i + 1);
	      c3 = str_data.charCodeAt(i + 2);
	      c4 = str_data.charCodeAt(i + 3);
	      c1 = ((c1 & 7) << 18) | ((c2 & 63) << 12) | ((c3 & 63) << 6) | (c4 & 63);
	      c1 -= 0x10000;
	      tmp_arr[ac++] = String.fromCharCode(0xD800 | ((c1>>10) & 0x3FF));
	      tmp_arr[ac++] = String.fromCharCode(0xDC00 | (c1 & 0x3FF));
	      i += 4;
	    }
	  }

	  return tmp_arr.join('');
}

function sha1 (str) {
  // http://kevin.vanzonneveld.net
  // +   original by: Webtoolkit.info (http://www.webtoolkit.info/)
  // + namespaced by: Michael White (http://getsprink.com)
  // +      input by: Brett Zamir (http://brett-zamir.me)
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // -    depends on: utf8_encode
  // *     example 1: sha1('Kevin van Zonneveld');
  // *     returns 1: '54916d2e62f65b3afa6e192e6a601cdbe5cb5897'
  var rotate_left = function (n, s) {
    var t4 = (n << s) | (n >>> (32 - s));
    return t4;
  };

/*var lsb_hex = function (val) { // Not in use; needed?
    var str="";
    var i;
    var vh;
    var vl;

    for ( i=0; i<=6; i+=2 ) {
      vh = (val>>>(i*4+4))&0x0f;
      vl = (val>>>(i*4))&0x0f;
      str += vh.toString(16) + vl.toString(16);
    }
    return str;
  };*/

  var cvt_hex = function (val) {
    var str = "";
    var i;
    var v;

    for (i = 7; i >= 0; i--) {
      v = (val >>> (i * 4)) & 0x0f;
      str += v.toString(16);
    }
    return str;
  };

  var blockstart;
  var i, j;
  var W = new Array(80);
  var H0 = 0x67452301;
  var H1 = 0xEFCDAB89;
  var H2 = 0x98BADCFE;
  var H3 = 0x10325476;
  var H4 = 0xC3D2E1F0;
  var A, B, C, D, E;
  var temp;

  str = this.utf8_encode(str);
  var str_len = str.length;

  var word_array = [];
  for (i = 0; i < str_len - 3; i += 4) {
    j = str.charCodeAt(i) << 24 | str.charCodeAt(i + 1) << 16 | str.charCodeAt(i + 2) << 8 | str.charCodeAt(i + 3);
    word_array.push(j);
  }

  switch (str_len % 4) {
  case 0:
    i = 0x080000000;
    break;
  case 1:
    i = str.charCodeAt(str_len - 1) << 24 | 0x0800000;
    break;
  case 2:
    i = str.charCodeAt(str_len - 2) << 24 | str.charCodeAt(str_len - 1) << 16 | 0x08000;
    break;
  case 3:
    i = str.charCodeAt(str_len - 3) << 24 | str.charCodeAt(str_len - 2) << 16 | str.charCodeAt(str_len - 1) << 8 | 0x80;
    break;
  }

  word_array.push(i);

  while ((word_array.length % 16) != 14) {
    word_array.push(0);
  }

  word_array.push(str_len >>> 29);
  word_array.push((str_len << 3) & 0x0ffffffff);

  for (blockstart = 0; blockstart < word_array.length; blockstart += 16) {
    for (i = 0; i < 16; i++) {
      W[i] = word_array[blockstart + i];
    }
    for (i = 16; i <= 79; i++) {
      W[i] = rotate_left(W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16], 1);
    }


    A = H0;
    B = H1;
    C = H2;
    D = H3;
    E = H4;

    for (i = 0; i <= 19; i++) {
      temp = (rotate_left(A, 5) + ((B & C) | (~B & D)) + E + W[i] + 0x5A827999) & 0x0ffffffff;
      E = D;
      D = C;
      C = rotate_left(B, 30);
      B = A;
      A = temp;
    }

    for (i = 20; i <= 39; i++) {
      temp = (rotate_left(A, 5) + (B ^ C ^ D) + E + W[i] + 0x6ED9EBA1) & 0x0ffffffff;
      E = D;
      D = C;
      C = rotate_left(B, 30);
      B = A;
      A = temp;
    }

    for (i = 40; i <= 59; i++) {
      temp = (rotate_left(A, 5) + ((B & C) | (B & D) | (C & D)) + E + W[i] + 0x8F1BBCDC) & 0x0ffffffff;
      E = D;
      D = C;
      C = rotate_left(B, 30);
      B = A;
      A = temp;
    }

    for (i = 60; i <= 79; i++) {
      temp = (rotate_left(A, 5) + (B ^ C ^ D) + E + W[i] + 0xCA62C1D6) & 0x0ffffffff;
      E = D;
      D = C;
      C = rotate_left(B, 30);
      B = A;
      A = temp;
    }

    H0 = (H0 + A) & 0x0ffffffff;
    H1 = (H1 + B) & 0x0ffffffff;
    H2 = (H2 + C) & 0x0ffffffff;
    H3 = (H3 + D) & 0x0ffffffff;
    H4 = (H4 + E) & 0x0ffffffff;
  }

  temp = cvt_hex(H0) + cvt_hex(H1) + cvt_hex(H2) + cvt_hex(H3) + cvt_hex(H4);
  return temp.toLowerCase();
}

function sizeof (mixed_var, mode) {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Philip Peterson
	  // -    depends on: count
	  // *     example 1: sizeof([[0,0],[0,-4]], 'COUNT_RECURSIVE');
	  // *     returns 1: 6
	  // *     example 2: sizeof({'one' : [1,2,3,4,5]}, 'COUNT_RECURSIVE');
	  // *     returns 2: 6
	  return this.count(mixed_var, mode);
}

function ksort (inputArr, sort_flags) {
  // http://kevin.vanzonneveld.net
  // +   original by: GeekFG (http://geekfg.blogspot.com)
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // %          note 1: The examples are correct, this is a new way
  // %        note 2: This function deviates from PHP in returning a copy of the array instead
  // %        note 2: of acting by reference and returning true; this was necessary because
  // %        note 2: IE does not allow deleting and re-adding of properties without caching
  // %        note 2: of property position; you can set the ini of "phpjs.strictForIn" to true to
  // %        note 2: get the PHP behavior, but use this only if you are in an environment
  // %        note 2: such as Firefox extensions where for-in iteration order is fixed and true
  // %        note 2: property deletion is supported. Note that we intend to implement the PHP
  // %        note 2: behavior by default if IE ever does allow it; only gives shallow copy since
  // %        note 2: is by reference in PHP anyways
  // %        note 3: Since JS objects' keys are always strings, and (the
  // %        note 3: default) SORT_REGULAR flag distinguishes by key type,
  // %        note 3: if the content is a numeric string, we treat the
  // %        note 3: "original type" as numeric.
  // -    depends on: i18n_loc_get_default
  // -    depends on: strnatcmp
  // *     example 1: data = {d: 'lemon', a: 'orange', b: 'banana', c: 'apple'};
  // *     example 1: data = ksort(data);
  // *     results 1: {a: 'orange', b: 'banana', c: 'apple', d: 'lemon'}
  // *     example 2: ini_set('phpjs.strictForIn', true);
  // *     example 2: data = {2: 'van', 3: 'Zonneveld', 1: 'Kevin'};
  // *     example 2: ksort(data);
  // *     results 2: data == {1: 'Kevin', 2: 'van', 3: 'Zonneveld'}
  // *     returns 2: true
  var tmp_arr = {},
    keys = [],
    sorter, i, k, that = this,
    strictForIn = false,
    populateArr = {};

  switch (sort_flags) {
  case 'SORT_STRING':
    // compare items as strings
    sorter = function (a, b) {
      return that.strnatcmp(a, b);
    };
    break;
  case 'SORT_LOCALE_STRING':
    // compare items as strings, based on the current locale (set with  i18n_loc_set_default() as of PHP6)
    var loc = this.i18n_loc_get_default();
    sorter = this.php_js.i18nLocales[loc].sorting;
    break;
  case 'SORT_NUMERIC':
    // compare items numerically
    sorter = function (a, b) {
      return ((a + 0) - (b + 0));
    };
    break;
    // case 'SORT_REGULAR': // compare items normally (don't change types)
  default:
    sorter = function (a, b) {
      var aFloat = parseFloat(a),
        bFloat = parseFloat(b),
        aNumeric = aFloat + '' === a,
        bNumeric = bFloat + '' === b;
      if (aNumeric && bNumeric) {
        return aFloat > bFloat ? 1 : aFloat < bFloat ? -1 : 0;
      } else if (aNumeric && !bNumeric) {
        return 1;
      } else if (!aNumeric && bNumeric) {
        return -1;
      }
      return a > b ? 1 : a < b ? -1 : 0;
    };
    break;
  }

  // Make a list of key names
  for (k in inputArr) {
    if (inputArr.hasOwnProperty(k)) {
      keys.push(k);
    }
  }
  keys.sort(sorter);

  // BEGIN REDUNDANT
  this.php_js = this.php_js || {};
  this.php_js.ini = this.php_js.ini || {};
  // END REDUNDANT
  strictForIn = this.php_js.ini['phpjs.strictForIn'] && this.php_js.ini['phpjs.strictForIn'].local_value && this.php_js.ini['phpjs.strictForIn'].local_value !== 'off';
  populateArr = strictForIn ? inputArr : populateArr;

  // Rebuild array with sorted key names
  for (i = 0; i < keys.length; i++) {
    k = keys[i];
    tmp_arr[k] = inputArr[k];
    if (strictForIn) {
      delete inputArr[k];
    }
  }
  for (i in tmp_arr) {
    if (tmp_arr.hasOwnProperty(i)) {
      populateArr[i] = tmp_arr[i];
    }
  }

  return strictForIn || populateArr;
}

function array_merge () {
  // http://kevin.vanzonneveld.net
  // +   original by: Brett Zamir (http://brett-zamir.me)
  // +   bugfixed by: Nate
  // +   input by: josh
  // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
  // *     example 1: arr1 = {"color": "red", 0: 2, 1: 4}
  // *     example 1: arr2 = {0: "a", 1: "b", "color": "green", "shape": "trapezoid", 2: 4}
  // *     example 1: array_merge(arr1, arr2)
  // *     returns 1: {"color": "green", 0: 2, 1: 4, 2: "a", 3: "b", "shape": "trapezoid", 4: 4}
  // *     example 2: arr1 = []
  // *     example 2: arr2 = {1: "data"}
  // *     example 2: array_merge(arr1, arr2)
  // *     returns 2: {0: "data"}
  var args = Array.prototype.slice.call(arguments),
    argl = args.length,
    arg,
    retObj = {},
    k = '',
    argil = 0,
    j = 0,
    i = 0,
    ct = 0,
    toStr = Object.prototype.toString,
    retArr = true;

  for (i = 0; i < argl; i++) {
    if (toStr.call(args[i]) !== '[object Array]') {
      retArr = false;
      break;
    }
  }

  if (retArr) {
    retArr = [];
    for (i = 0; i < argl; i++) {
      retArr = retArr.concat(args[i]);
    }
    return retArr;
  }

  for (i = 0, ct = 0; i < argl; i++) {
    arg = args[i];
    if (toStr.call(arg) === '[object Array]') {
      for (j = 0, argil = arg.length; j < argil; j++) {
        retObj[ct++] = arg[j];
      }
    }
    else {
      for (k in arg) {
        if (arg.hasOwnProperty(k)) {
          if (parseInt(k, 10) + '' === k) {
            retObj[ct++] = arg[k];
          }
          else {
            retObj[k] = arg[k];
          }
        }
      }
    }
  }
  return retObj;
}

function empty (mixed_var) {
  // Checks if the argument variable is empty
  // undefined, null, false, number 0, empty string,
  // string "0", objects without properties and empty arrays
  // are considered empty
  //
  // http://kevin.vanzonneveld.net
  // +   original by: Philippe Baumann
  // +      input by: Onno Marsman
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +      input by: LH
  // +   improved by: Onno Marsman
  // +   improved by: Francesco
  // +   improved by: Marc Jansen
  // +      input by: Stoyan Kyosev (http://www.svest.org/)
  // +   improved by: Rafal Kukawski
  // *     example 1: empty(null);
  // *     returns 1: true
  // *     example 2: empty(undefined);
  // *     returns 2: true
  // *     example 3: empty([]);
  // *     returns 3: true
  // *     example 4: empty({});
  // *     returns 4: true
  // *     example 5: empty({'aFunc' : function () { alert('humpty'); } });
  // *     returns 5: false
  var undef, key, i, len;
  var emptyValues = [undef, null, false, 0, "", "0"];

  for (i = 0, len = emptyValues.length; i < len; i++) {
    if (mixed_var === emptyValues[i]) {
      return true;
    }
  }

  if (typeof mixed_var === "object") {
    for (key in mixed_var) {
      // TODO: should we check for own properties only?
      //if (mixed_var.hasOwnProperty(key)) {
      return false;
      //}
    }
    return true;
  }

  return false;
}

function array_key_exists (key, search) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Felix Geisendoerfer (http://www.debuggable.com/felix)
  // *     example 1: array_key_exists('kevin', {'kevin': 'van Zonneveld'});
  // *     returns 1: true
  // input sanitation
  if (!search || (search.constructor !== Array && search.constructor !== Object)) {
    return false;
  }

  return key in search;
}

function strtolower (str) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: Onno Marsman
  // *     example 1: strtolower('Kevin van Zonneveld');
  // *     returns 1: 'kevin van zonneveld'
  return (str + '').toLowerCase();
}

function is_int (mixed_var) {
  // http://kevin.vanzonneveld.net
  // +   original by: Alex
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +    revised by: Matt Bradley
  // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: WebDevHobo (http://webdevhobo.blogspot.com/)
  // +   improved by: Rafal Kukawski (http://blog.kukawski.pl)
  // %        note 1: 1.0 is simplified to 1 before it can be accessed by the function, this makes
  // %        note 1: it different from the PHP implementation. We can't fix this unfortunately.
  // *     example 1: is_int(23)
  // *     returns 1: true
  // *     example 2: is_int('23')
  // *     returns 2: false
  // *     example 3: is_int(23.5)
  // *     returns 3: false
  // *     example 4: is_int(true)
  // *     returns 4: false

  return mixed_var === +mixed_var && isFinite(mixed_var) && !(mixed_var % 1);
}

function rand (min, max) {
  // http://kevin.vanzonneveld.net
  // +   original by: Leslie Hoare
  // +   bugfixed by: Onno Marsman
  // %          note 1: See the commented out code below for a version which will work with our experimental (though probably unnecessary) srand() function)
  // *     example 1: rand(1, 1);
  // *     returns 1: 1
  var argc = arguments.length;
  if (argc === 0) {
    min = 0;
    max = 2147483647;
  } else if (argc === 1) {
    throw new Error('Warning: rand() expects exactly 2 parameters, 1 given');
  }
  return Math.floor(Math.random() * (max - min + 1)) + min;

/*
  // See note above for an explanation of the following alternative code

  // +   reimplemented by: Brett Zamir (http://brett-zamir.me)
  // -    depends on: srand
  // %          note 1: This is a very possibly imperfect adaptation from the PHP source code
  var rand_seed, ctx, PHP_RAND_MAX=2147483647; // 0x7fffffff

  if (!this.php_js || this.php_js.rand_seed === undefined) {
    this.srand();
  }
  rand_seed = this.php_js.rand_seed;

  var argc = arguments.length;
  if (argc === 1) {
    throw new Error('Warning: rand() expects exactly 2 parameters, 1 given');
  }

  var do_rand = function (ctx) {
    return ((ctx * 1103515245 + 12345) % (PHP_RAND_MAX + 1));
  };

  var php_rand = function (ctxArg) { // php_rand_r
    this.php_js.rand_seed = do_rand(ctxArg);
    return parseInt(this.php_js.rand_seed, 10);
  };

  var number = php_rand(rand_seed);

  if (argc === 2) {
    number = min + parseInt(parseFloat(parseFloat(max) - min + 1.0) * (number/(PHP_RAND_MAX + 1.0)), 10);
  }
  return number;
  */
}

function trim (str, charlist) {
  // http://kevin.vanzonneveld.net
  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +   improved by: mdsjack (http://www.mdsjack.bo.it)
  // +   improved by: Alexander Ermolaev (http://snippets.dzone.com/user/AlexanderErmolaev)
  // +      input by: Erkekjetter
  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  // +      input by: DxGx
  // +   improved by: Steven Levithan (http://blog.stevenlevithan.com)
  // +    tweaked by: Jack
  // +   bugfixed by: Onno Marsman
  // *     example 1: trim('    Kevin van Zonneveld    ');
  // *     returns 1: 'Kevin van Zonneveld'
  // *     example 2: trim('Hello World', 'Hdle');
  // *     returns 2: 'o Wor'
  // *     example 3: trim(16, 1);
  // *     returns 3: 6
  var whitespace, l = 0,
    i = 0;
  str += '';

  if (!charlist) {
    // default list
    whitespace = " \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000";
  } else {
    // preg_quote custom list
    charlist += '';
    whitespace = charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '$1');
  }

  l = str.length;
  for (i = 0; i < l; i++) {
    if (whitespace.indexOf(str.charAt(i)) === -1) {
      str = str.substring(i);
      break;
    }
  }

  l = str.length;
  for (i = l - 1; i >= 0; i--) {
    if (whitespace.indexOf(str.charAt(i)) === -1) {
      str = str.substring(0, i + 1);
      break;
    }
  }

  return whitespace.indexOf(str.charAt(0)) === -1 ? str : '';
}

function strlen (string) {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +   improved by: Sakimori
	  // +      input by: Kirk Strobeck
	  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +   bugfixed by: Onno Marsman
	  // +    revised by: Brett Zamir (http://brett-zamir.me)
	  // %        note 1: May look like overkill, but in order to be truly faithful to handling all Unicode
	  // %        note 1: characters and to this function in PHP which does not count the number of bytes
	  // %        note 1: but counts the number of characters, something like this is really necessary.
	  // *     example 1: strlen('Kevin van Zonneveld');
	  // *     returns 1: 19
	  // *     example 2: strlen('A\ud87e\udc04Z');
	  // *     returns 2: 3
	  var str = string + '';
	  var i = 0,
	    chr = '',
	    lgth = 0;

	  if (!this.php_js || !this.php_js.ini || !this.php_js.ini['unicode.semantics'] || this.php_js.ini['unicode.semantics'].local_value.toLowerCase() !== 'on') {
	    return string.length;
	  }

	  var getWholeChar = function (str, i) {
	    var code = str.charCodeAt(i);
	    var next = '',
	      prev = '';
	    if (0xD800 <= code && code <= 0xDBFF) { // High surrogate (could change last hex to 0xDB7F to treat high private surrogates as single characters)
	      if (str.length <= (i + 1)) {
	        throw 'High surrogate without following low surrogate';
	      }
	      next = str.charCodeAt(i + 1);
	      if (0xDC00 > next || next > 0xDFFF) {
	        throw 'High surrogate without following low surrogate';
	      }
	      return str.charAt(i) + str.charAt(i + 1);
	    } else if (0xDC00 <= code && code <= 0xDFFF) { // Low surrogate
	      if (i === 0) {
	        throw 'Low surrogate without preceding high surrogate';
	      }
	      prev = str.charCodeAt(i - 1);
	      if (0xD800 > prev || prev > 0xDBFF) { //(could change last hex to 0xDB7F to treat high private surrogates as single characters)
	        throw 'Low surrogate without preceding high surrogate';
	      }
	      return false; // We can pass over low surrogates now as the second component in a pair which we have already processed
	    }
	    return str.charAt(i);
	  };

	  for (i = 0, lgth = 0; i < str.length; i++) {
	    if ((chr = getWholeChar(str, i)) === false) {
	      continue;
	    } // Adapt this line at the top of any loop, passing in the whole string and the current iteration and returning a variable to represent the individual character; purpose is to treat the first part of a surrogate pair as the whole character and then ignore the second part
	    lgth++;
	  }
	  return lgth;
}

//START:	Base64
/*
	Copyright Vassilis Petroulias [DRDigit]
	
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	
	       http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
	
	@link	http://jsbase64.codeplex.com
*/
var B64 = {
    alphabet: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=',
    lookup: null,
    ie: /MSIE /.test(navigator.userAgent),
    ieo: /MSIE [67]/.test(navigator.userAgent),
    encode: function (s) {
        var buffer = B64.toUtf8(s),
            position = -1,
            len = buffer.length,
            nan0, nan1, nan2, enc = [, , , ];
        if (B64.ie) {
            var result = [];
            while (++position < len) {
                nan0 = buffer[position];
                nan1 = buffer[++position];
                enc[0] = nan0 >> 2;
                enc[1] = ((nan0 & 3) << 4) | (nan1 >> 4);
                if (isNaN(nan1))
                    enc[2] = enc[3] = 64;
                else {
                    nan2 = buffer[++position];
                    enc[2] = ((nan1 & 15) << 2) | (nan2 >> 6);
                    enc[3] = (isNaN(nan2)) ? 64 : nan2 & 63;
                }
                result.push(B64.alphabet.charAt(enc[0]), B64.alphabet.charAt(enc[1]), B64.alphabet.charAt(enc[2]), B64.alphabet.charAt(enc[3]));
            }
            return result.join('');
        } else {
            var result = '';
            while (++position < len) {
                nan0 = buffer[position];
                nan1 = buffer[++position];
                enc[0] = nan0 >> 2;
                enc[1] = ((nan0 & 3) << 4) | (nan1 >> 4);
                if (isNaN(nan1))
                    enc[2] = enc[3] = 64;
                else {
                    nan2 = buffer[++position];
                    enc[2] = ((nan1 & 15) << 2) | (nan2 >> 6);
                    enc[3] = (isNaN(nan2)) ? 64 : nan2 & 63;
                }
                result += B64.alphabet[enc[0]] + B64.alphabet[enc[1]] + B64.alphabet[enc[2]] + B64.alphabet[enc[3]];
            }
            return result;
        }
    },
    decode: function (s) {
        if (s.length % 4)
            throw new Error("InvalidCharacterError: 'B64.decode' failed: The string to be decoded is not correctly encoded.");
        var buffer = B64.fromUtf8(s),
            position = 0,
            len = buffer.length;
        if (B64.ieo) {
            var result = [];
            while (position < len) {
                if (buffer[position] < 128) 
                    result.push(String.fromCharCode(buffer[position++]));
                else if (buffer[position] > 191 && buffer[position] < 224) 
                    result.push(String.fromCharCode(((buffer[position++] & 31) << 6) | (buffer[position++] & 63)));
                else 
                    result.push(String.fromCharCode(((buffer[position++] & 15) << 12) | ((buffer[position++] & 63) << 6) | (buffer[position++] & 63)));
            }
            return result.join('');
        } else {
            var result = '';
            while (position < len) {
                if (buffer[position] < 128) 
                    result += String.fromCharCode(buffer[position++]);
                else if (buffer[position] > 191 && buffer[position] < 224) 
                    result += String.fromCharCode(((buffer[position++] & 31) << 6) | (buffer[position++] & 63));
                else 
                    result += String.fromCharCode(((buffer[position++] & 15) << 12) | ((buffer[position++] & 63) << 6) | (buffer[position++] & 63));
            }
            return result;
        }
    },
    toUtf8: function (s) {
        var position = -1,
            len = s.length,
            chr, buffer = [];
        if (/^[\x00-\x7f]*$/.test(s)) while (++position < len)
            buffer.push(s.charCodeAt(position));
        else while (++position < len) {
            chr = s.charCodeAt(position);
            if (chr < 128) 
                buffer.push(chr);
            else if (chr < 2048) 
                buffer.push((chr >> 6) | 192, (chr & 63) | 128);
            else 
                buffer.push((chr >> 12) | 224, ((chr >> 6) & 63) | 128, (chr & 63) | 128);
        }
        return buffer;
    },
    fromUtf8: function (s) {
        var position = -1,
            len, buffer = [],
            enc = [, , , ];
        if (!B64.lookup) {
            len = B64.alphabet.length;
            B64.lookup = {};
            while (++position < len)
                B64.lookup[B64.alphabet.charAt(position)] = position;
            position = -1;
        }
        len = s.length;
        while (++position < len) {
            enc[0] = B64.lookup[s.charAt(position)];
            enc[1] = B64.lookup[s.charAt(++position)];
            buffer.push((enc[0] << 2) | (enc[1] >> 4));
            enc[2] = B64.lookup[s.charAt(++position)];
            if (enc[2] == 64) 
                break;
            buffer.push(((enc[1] & 15) << 4) | (enc[2] >> 2));
            enc[3] = B64.lookup[s.charAt(++position)];
            if (enc[3] == 64) 
                break;
            buffer.push(((enc[2] & 3) << 6) | enc[3]);
        }
        return buffer;
    }
};
// END:		Base64

function timezone_abbreviations_list () {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Brett Zamir (http://brett-zamir.me)
	  // +      input by: ChaosNo1
	  // +    revised by: Theriault
	  // +    improved by: Brett Zamir (http://brett-zamir.me)
	  // %        note 1: Based on timezonemap.h from PHP 5.3
	  // *     example 1: var list = timezone_abbreviations_list()
	  // *     example 1: list['acst'][0].timezone_id
	  // *     returns 1: 'America/Porto_Acre'
	  var list = {},
	    i = 0,
	    j = 0,
	    len = 0,
	    jlen = 0,
	    indice = '',
	    curr = '',
	    currSub = '',
	    currSubPrefix = '',
	    timezone_id = '',
	    tzo = 0,
	    dst = false;

	  // BEGIN STATIC
	  try { // We can't try to access on window, since it might not exist in some environments, and if we use "this.window"
	    //    we risk adding another copy if different window objects are associated with the namespaced object
	    php_js_shared; // Will be private static variable in namespaced version or global in non-namespaced
	    //   version since we wish to share this across all instances
	  } catch (e) {
	    php_js_shared = {};
	  }

	  // An array of arrays. The index of each array is the relative
	  // abbreviation from the abbreviations array below. Each sub array
	  // consists of 2 to 4 values. The first value will be DST. The
	  // second value is the index of the value in the offsets array.
	  // The third value is the timezone ID if applicable. Null is
	  // returned if their is no value. The fourth value is the index
	  // of the prefix to use for the timezone ID if applicable.
	  if (!php_js_shared.tz_abbrs) { // This should really be static, but we can at least avoid rebuilding the array each time
	    php_js_shared.tz_abbrs = [
	      [
	        [1, 14, "Porto_Acre", 9],
	        [1, 14, "Eirunepe", 9],
	        [1, 14, "Rio_Branco", 9],
	        [1, 14, "Acre", 15]
	      ],
	      [
	        [0, 11, "Porto_Acre", 9],
	        [0, 11, "Eirunepe", 9],
	        [0, 11, "Rio_Branco", 9],
	        [0, 11, "Acre", 15]
	      ],
	      [
	        [1, 25, "Goose_Bay", 9],
	        [1, 25, "Pangnirtung", 9]
	      ],
	      [
	        [1, 22, "Halifax", 9],
	        [1, 22, "Barbados", 9],
	        [1, 22, "Blanc-Sablon", 9],
	        [1, 22, "Glace_Bay", 9],
	        [1, 22, "Goose_Bay", 9],
	        [1, 22, "Martinique", 9],
	        [1, 22, "Moncton", 9],
	        [1, 22, "Pangnirtung", 9],
	        [1, 22, "Thule", 9],
	        [1, 22, "Bermuda", 13],
	        [1, 22, "Atlantic", 16],
	        [1, 51, "Baghdad", 12]
	      ],
	      [
	        [0, 52, "Kabul", 12]
	      ],
	      [
	        [1, 6, "Anchorage", 9],
	        [1, 6, "Alaska"]
	      ],
	      [
	        [0, 4, "Anchorage", 9],
	        [0, 4, "Adak", 9],
	        [0, 4, "Atka", 9],
	        [0, 4, "Alaska"],
	        [0, 4, "Aleutian"]
	      ],
	      [
	        [1, 7, "Anchorage", 9],
	        [1, 7, "Juneau", 9],
	        [1, 7, "Nome", 9],
	        [1, 7, "Yakutat", 9],
	        [1, 7, "Alaska"]
	      ],
	      [
	        [0, 6, "Anchorage", 9],
	        [0, 6, "Juneau", 9],
	        [0, 6, "Nome", 9],
	        [0, 6, "Yakutat", 9],
	        [0, 6, "Alaska"]
	      ],
	      [
	        [1, 57, "Aqtobe", 12]
	      ],
	      [
	        [0, 51, "Aqtobe", 12],
	        [0, 54, "Aqtobe", 12],
	        [0, 57, "Aqtobe", 12]
	      ],
	      [
	        [1, 59, "Almaty", 12]
	      ],
	      [
	        [0, 54, "Almaty", 12],
	        [0, 57, "Almaty", 12]
	      ],
	      [
	        [1, 51, "Yerevan", 12],
	        [1, 54, "Yerevan", 12],
	        [1, 22, "Boa_Vista", 9],
	        [1, 22, "Campo_Grande", 9],
	        [1, 22, "Cuiaba", 9],
	        [1, 22, "Manaus", 9],
	        [1, 22, "Porto_Velho", 9],
	        [1, 22, "West", 15]
	      ],
	      [
	        [0, 47, "Yerevan", 12],
	        [0, 51, "Yerevan", 12],
	        [0, 14, "Boa_Vista", 9],
	        [0, 14, "Campo_Grande", 9],
	        [0, 14, "Cuiaba", 9],
	        [0, 14, "Manaus", 9],
	        [0, 14, "Porto_Velho", 9],
	        [0, 14, "West", 15],
	        [0, 32, "Amsterdam", 18]
	      ],
	      [
	        [1, 76, "Anadyr", 12],
	        [1, 79, "Anadyr", 12],
	        [1, 81, "Anadyr", 12]
	      ],
	      [
	        [0, 74, "Anadyr", 12],
	        [0, 76, "Anadyr", 12],
	        [0, 79, "Anadyr", 12]
	      ],
	      [
	        [0, 13, "Curacao", 9],
	        [0, 13, "Aruba", 9]
	      ],
	      [
	        [1, 22, "Halifax", 9],
	        [1, 22, "Blanc-Sablon", 9],
	        [1, 22, "Glace_Bay", 9],
	        [1, 22, "Moncton", 9],
	        [1, 22, "Pangnirtung", 9],
	        [1, 22, "Puerto_Rico", 9],
	        [1, 22, "Atlantic", 16]
	      ],
	      [
	        [1, 54, "Aqtau", 12],
	        [1, 57, "Aqtau", 12],
	        [1, 57, "Aqtobe", 12]
	      ],
	      [
	        [0, 51, "Aqtau", 12],
	        [0, 54, "Aqtau", 12],
	        [0, 54, "Aqtobe", 12]
	      ],
	      [
	        [1, 22, "Buenos_Aires", 9],
	        [1, 25, "Buenos_Aires", 9],
	        [1, 22, "Buenos_Aires", 2],
	        [1, 22, "Catamarca", 2],
	        [1, 22, "ComodRivadavia", 2],
	        [1, 22, "Cordoba", 2],
	        [1, 22, "Jujuy", 2],
	        [1, 22, "La_Rioja", 2],
	        [1, 22, "Mendoza", 2],
	        [1, 22, "Rio_Gallegos", 2],
	        [1, 22, "San_Juan", 2],
	        [1, 22, "Tucuman", 2],
	        [1, 22, "Ushuaia", 2],
	        [1, 22, "Catamarca", 9],
	        [1, 22, "Cordoba", 9],
	        [1, 22, "Jujuy", 9],
	        [1, 22, "Mendoza", 9],
	        [1, 22, "Rosario", 9],
	        [1, 22, "Palmer", 10],
	        [1, 25, "Buenos_Aires", 2],
	        [1, 25, "Catamarca", 2],
	        [1, 25, "ComodRivadavia", 2],
	        [1, 25, "Cordoba", 2],
	        [1, 25, "Jujuy", 2],
	        [1, 25, "La_Rioja", 2],
	        [1, 25, "Mendoza", 2],
	        [1, 25, "Rio_Gallegos", 2],
	        [1, 25, "San_Juan", 2],
	        [1, 25, "Tucuman", 2],
	        [1, 25, "Ushuaia", 2],
	        [1, 25, "Catamarca", 9],
	        [1, 25, "Cordoba", 9],
	        [1, 25, "Jujuy", 9],
	        [1, 25, "Mendoza", 9],
	        [1, 25, "Rosario", 9],
	        [1, 25, "Palmer", 10]
	      ],
	      [
	        [0, 22, "Buenos_Aires", 9],
	        [0, 14, "Buenos_Aires", 9],
	        [0, 22, "Buenos_Aires", 2],
	        [0, 22, "Catamarca", 2],
	        [0, 22, "ComodRivadavia", 2],
	        [0, 22, "Cordoba", 2],
	        [0, 22, "Jujuy", 2],
	        [0, 22, "La_Rioja", 2],
	        [0, 22, "Mendoza", 2],
	        [0, 22, "Rio_Gallegos", 2],
	        [0, 22, "San_Juan", 2],
	        [0, 22, "Tucuman", 2],
	        [0, 22, "Ushuaia", 2],
	        [0, 22, "Catamarca", 9],
	        [0, 22, "Cordoba", 9],
	        [0, 22, "Jujuy", 9],
	        [0, 22, "Mendoza", 9],
	        [0, 22, "Rosario", 9],
	        [0, 22, "Palmer", 10],
	        [0, 14, "Buenos_Aires", 2],
	        [0, 14, "Catamarca", 2],
	        [0, 14, "ComodRivadavia", 2],
	        [0, 14, "Cordoba", 2],
	        [0, 14, "Jujuy", 2],
	        [0, 14, "La_Rioja", 2],
	        [0, 14, "Mendoza", 2],
	        [0, 14, "Rio_Gallegos", 2],
	        [0, 14, "San_Juan", 2],
	        [0, 14, "Tucuman", 2],
	        [0, 14, "Ushuaia", 2],
	        [0, 14, "Catamarca", 9],
	        [0, 14, "Cordoba", 9],
	        [0, 14, "Jujuy", 9],
	        [0, 14, "Mendoza", 9],
	        [0, 14, "Rosario", 9],
	        [0, 14, "Palmer", 10]
	      ],
	      [
	        [1, 54, "Ashkhabad", 12],
	        [1, 57, "Ashkhabad", 12],
	        [1, 54, "Ashgabat", 12],
	        [1, 57, "Ashgabat", 12]
	      ],
	      [
	        [0, 51, "Ashkhabad", 12],
	        [0, 54, "Ashkhabad", 12],
	        [0, 51, "Ashgabat", 12],
	        [0, 54, "Ashgabat", 12]
	      ],
	      [
	        [0, 47, "Riyadh", 12],
	        [0, 14, "Anguilla", 9],
	        [0, 14, "Antigua", 9],
	        [0, 14, "Aruba", 9],
	        [0, 14, "Barbados", 9],
	        [0, 14, "Blanc-Sablon", 9],
	        [0, 14, "Curacao", 9],
	        [0, 14, "Dominica", 9],
	        [0, 14, "Glace_Bay", 9],
	        [0, 14, "Goose_Bay", 9],
	        [0, 14, "Grenada", 9],
	        [0, 14, "Guadeloupe", 9],
	        [0, 14, "Halifax", 9],
	        [0, 14, "Martinique", 9],
	        [0, 14, "Miquelon", 9],
	        [0, 14, "Moncton", 9],
	        [0, 14, "Montserrat", 9],
	        [0, 14, "Pangnirtung", 9],
	        [0, 14, "Port_of_Spain", 9],
	        [0, 14, "Puerto_Rico", 9],
	        [0, 14, "Santo_Domingo", 9],
	        [0, 14, "St_Kitts", 9],
	        [0, 14, "St_Lucia", 9],
	        [0, 14, "St_Thomas", 9],
	        [0, 14, "St_Vincent", 9],
	        [0, 14, "Thule", 9],
	        [0, 14, "Tortola", 9],
	        [0, 14, "Virgin", 9],
	        [0, 14, "Bermuda", 13],
	        [0, 14, "Atlantic", 16],
	        [0, 47, "Aden", 12],
	        [0, 47, "Baghdad", 12],
	        [0, 47, "Bahrain", 12],
	        [0, 47, "Kuwait", 12],
	        [0, 47, "Qatar", 12]
	      ],
	      [
	        [1, 22, "Halifax", 9],
	        [1, 22, "Blanc-Sablon", 9],
	        [1, 22, "Glace_Bay", 9],
	        [1, 22, "Moncton", 9],
	        [1, 22, "Pangnirtung", 9],
	        [1, 22, "Puerto_Rico", 9],
	        [1, 22, "Atlantic", 16]
	      ],
	      [
	        [1, 31, "Azores", 13]
	      ],
	      [
	        [1, 28, "Azores", 13],
	        [1, 31, "Azores", 13]
	      ],
	      [
	        [0, 28, "Azores", 13],
	        [0, 25, "Azores", 13]
	      ],
	      [
	        [1, 51, "Baku", 12],
	        [1, 54, "Baku", 12]
	      ],
	      [
	        [0, 47, "Baku", 12],
	        [0, 51, "Baku", 12]
	      ],
	      [
	        [1, 51, "Baku", 12],
	        [1, 54, "Baku", 12]
	      ],
	      [
	        [0, 47, "Baku", 12],
	        [0, 51, "Baku", 12]
	      ],
	      [
	        [1, 42, "London", 18],
	        [1, 42, "Belfast", 18],
	        [1, 42, "Gibraltar", 18],
	        [1, 42, "Guernsey", 18],
	        [1, 42, "Isle_of_Man", 18],
	        [1, 42, "Jersey", 18],
	        [1, 42, "GB"],
	        [1, 42, "GB-Eire"]
	      ],
	      [
	        [1, 4, "Adak", 9],
	        [1, 4, "Atka", 9],
	        [1, 4, "Nome", 9],
	        [1, 4, "Aleutian"],
	        [0, 57, "Dacca", 12],
	        [0, 57, "Dhaka", 12]
	      ],
	      [
	        [0, 43, "Mogadishu"],
	        [0, 43, "Kampala"],
	        [0, 43, "Nairobi"]
	      ],
	      [
	        [0, 46, "Nairobi"],
	        [0, 46, "Dar_es_Salaam"],
	        [0, 46, "Kampala"]
	      ],
	      [
	        [0, 15, "Barbados", 9],
	        [0, 27, "Banjul"],
	        [0, 41, "Tiraspol", 18],
	        [0, 41, "Chisinau", 18]
	      ],
	      [
	        [0, 63, "Brunei", 12],
	        [0, 65, "Brunei", 12]
	      ],
	      [
	        [1, 66, "Kuching", 12]
	      ],
	      [
	        [0, 63, "Kuching", 12],
	        [0, 65, "Kuching", 12]
	      ],
	      [
	        [1, 19, "La_Paz", 9]
	      ],
	      [
	        [0, 14, "La_Paz", 9]
	      ],
	      [
	        [1, 25, "Sao_Paulo", 9],
	        [1, 25, "Araguaina", 9],
	        [1, 25, "Bahia", 9],
	        [1, 25, "Belem", 9],
	        [1, 25, "Fortaleza", 9],
	        [1, 25, "Maceio", 9],
	        [1, 25, "Recife", 9],
	        [1, 25, "East", 15]
	      ],
	      [
	        [0, 22, "Sao_Paulo", 9],
	        [0, 22, "Araguaina", 9],
	        [0, 22, "Bahia", 9],
	        [0, 22, "Belem", 9],
	        [0, 22, "Fortaleza", 9],
	        [0, 22, "Maceio", 9],
	        [0, 22, "Recife", 9],
	        [0, 22, "East", 15]
	      ],
	      [
	        [0, 35, "London", 18],
	        [1, 35, "London", 18],
	        [0, 2, "Adak", 9],
	        [0, 2, "Atka", 9],
	        [0, 2, "Nome", 9],
	        [0, 2, "Midway", 21],
	        [0, 2, "Pago_Pago", 21],
	        [0, 2, "Samoa", 21],
	        [0, 2, "Aleutian"],
	        [0, 2, "Samoa"],
	        [0, 35, "Belfast", 18],
	        [0, 35, "Guernsey", 18],
	        [0, 35, "Isle_of_Man", 18],
	        [0, 35, "Jersey", 18],
	        [0, 35, "GB"],
	        [0, 35, "GB-Eire"],
	        [1, 35, "Eire"],
	        [1, 35, "Belfast", 18],
	        [1, 35, "Dublin", 18],
	        [1, 35, "Gibraltar", 18],
	        [1, 35, "Guernsey", 18],
	        [1, 35, "Isle_of_Man", 18],
	        [1, 35, "Jersey", 18],
	        [1, 35, "GB"],
	        [1, 35, "GB-Eire"]
	      ],
	      [
	        [0, 57, "Thimbu", 12],
	        [0, 57, "Thimphu", 12]
	      ],
	      [
	        [0, 58, "Calcutta", 12],
	        [0, 58, "Dacca", 12],
	        [0, 58, "Dhaka", 12],
	        [0, 58, "Rangoon", 12]
	      ],
	      [
	        [0, 28, "Canary", 13]
	      ],
	      [
	        [1, 6, "Anchorage", 9],
	        [1, 6, "Alaska"]
	      ],
	      [
	        [0, 70, "Adelaide", 14],
	        [1, 47, "Gaborone"],
	        [1, 47, "Khartoum"]
	      ],
	      [
	        [0, 4, "Anchorage", 9],
	        [0, 4, "Alaska"],
	        [0, 42, "Khartoum"],
	        [0, 42, "Blantyre"],
	        [0, 42, "Gaborone"],
	        [0, 42, "Harare"],
	        [0, 42, "Kigali"],
	        [0, 42, "Lusaka"],
	        [0, 42, "Maputo"],
	        [0, 42, "Windhoek"]
	      ],
	      [
	        [1, 6, "Anchorage", 9],
	        [1, 6, "Alaska"]
	      ],
	      [
	        [1, 14, "Rankin_Inlet", 9]
	      ],
	      [
	        [1, 11, "Chicago", 9],
	        [1, 14, "Havana", 9],
	        [1, 14, "Cuba"],
	        [1, 11, "Atikokan", 9],
	        [1, 11, "Belize", 9],
	        [1, 11, "Cambridge_Bay", 9],
	        [1, 11, "Cancun", 9],
	        [1, 11, "Chihuahua", 9],
	        [1, 11, "Coral_Harbour", 9],
	        [1, 11, "Costa_Rica", 9],
	        [1, 11, "El_Salvador", 9],
	        [1, 11, "Fort_Wayne", 9],
	        [1, 11, "Guatemala", 9],
	        [1, 11, "Indianapolis", 4],
	        [1, 11, "Knox", 4],
	        [1, 11, "Marengo", 4],
	        [1, 11, "Petersburg", 4],
	        [1, 11, "Vevay", 4],
	        [1, 11, "Vincennes", 4],
	        [1, 11, "Winamac", 4],
	        [1, 11, "Indianapolis", 9],
	        [1, 11, "Iqaluit", 9],
	        [1, 11, "Louisville", 6],
	        [1, 11, "Monticello", 6],
	        [1, 11, "Knox_IN", 9],
	        [1, 11, "Louisville", 9],
	        [1, 11, "Managua", 9],
	        [1, 11, "Menominee", 9],
	        [1, 11, "Merida", 9],
	        [1, 11, "Mexico_City", 9],
	        [1, 11, "Monterrey", 9],
	        [1, 11, "Center", 8],
	        [1, 11, "New_Salem", 8],
	        [1, 11, "Pangnirtung", 9],
	        [1, 11, "Rainy_River", 9],
	        [1, 11, "Rankin_Inlet", 9],
	        [1, 11, "Tegucigalpa", 9],
	        [1, 11, "Winnipeg", 9],
	        [1, 11, "Central", 16],
	        [1, 11, "CST6CDT"],
	        [1, 11, "General", 20],
	        [1, 11, "Central"],
	        [1, 11, "East-Indiana"],
	        [1, 11, "Indiana-Starke"],
	        [1, 69, "Shanghai", 12],
	        [1, 69, "Chongqing", 12],
	        [1, 69, "Chungking", 12],
	        [1, 69, "Harbin", 12],
	        [1, 69, "Kashgar", 12],
	        [1, 69, "Taipei", 12],
	        [1, 69, "Urumqi", 12],
	        [1, 69, "PRC"],
	        [1, 69, "ROC"]
	      ],
	      [
	        [1, 47, "Berlin", 18],
	        [1, 47, "CET"]
	      ],
	      [
	        [1, 42, "Berlin", 18],
	        [1, 47, "Kaliningrad", 18],
	        [1, 42, "Algiers"],
	        [1, 42, "Ceuta"],
	        [1, 42, "Tripoli"],
	        [1, 42, "Tunis"],
	        [1, 42, "Longyearbyen", 11],
	        [1, 42, "Jan_Mayen", 13],
	        [1, 42, "CET"],
	        [1, 42, "Amsterdam", 18],
	        [1, 42, "Andorra", 18],
	        [1, 42, "Athens", 18],
	        [1, 42, "Belgrade", 18],
	        [1, 42, "Bratislava", 18],
	        [1, 42, "Brussels", 18],
	        [1, 42, "Budapest", 18],
	        [1, 42, "Chisinau", 18],
	        [1, 42, "Copenhagen", 18],
	        [1, 42, "Gibraltar", 18],
	        [1, 42, "Kaliningrad", 18],
	        [1, 42, "Kiev", 18],
	        [1, 42, "Lisbon", 18],
	        [1, 42, "Ljubljana", 18],
	        [1, 42, "Luxembourg", 18],
	        [1, 42, "Madrid", 18],
	        [1, 42, "Malta", 18],
	        [1, 42, "Minsk", 18],
	        [1, 42, "Monaco", 18],
	        [1, 42, "Oslo", 18],
	        [1, 42, "Paris", 18],
	        [1, 42, "Podgorica", 18],
	        [1, 42, "Prague", 18],
	        [1, 42, "Riga", 18],
	        [1, 42, "Rome", 18],
	        [1, 42, "San_Marino", 18],
	        [1, 42, "Sarajevo", 18],
	        [1, 42, "Simferopol", 18],
	        [1, 42, "Skopje", 18],
	        [1, 42, "Sofia", 18],
	        [1, 42, "Stockholm", 18],
	        [1, 42, "Tallinn", 18],
	        [1, 42, "Tirane", 18],
	        [1, 42, "Tiraspol", 18],
	        [1, 42, "Uzhgorod", 18],
	        [1, 42, "Vaduz", 18],
	        [1, 42, "Vatican", 18],
	        [1, 42, "Vienna", 18],
	        [1, 42, "Vilnius", 18],
	        [1, 42, "Warsaw", 18],
	        [1, 42, "Zagreb", 18],
	        [1, 42, "Zaporozhye", 18],
	        [1, 42, "Zurich", 18],
	        [1, 42, "Libya"],
	        [1, 42, "Poland"],
	        [1, 42, "Portugal"],
	        [1, 42, "WET"]
	      ],
	      [
	        [0, 35, "Berlin", 18],
	        [0, 35, "Algiers"],
	        [0, 35, "Casablanca"],
	        [0, 35, "Ceuta"],
	        [0, 35, "Tripoli"],
	        [0, 35, "Tunis"],
	        [0, 35, "Longyearbyen", 11],
	        [0, 35, "Jan_Mayen", 13],
	        [0, 35, "CET"],
	        [0, 35, "Amsterdam", 18],
	        [0, 35, "Andorra", 18],
	        [0, 35, "Athens", 18],
	        [0, 35, "Belgrade", 18],
	        [0, 35, "Bratislava", 18],
	        [0, 35, "Brussels", 18],
	        [0, 35, "Budapest", 18],
	        [0, 35, "Chisinau", 18],
	        [0, 35, "Copenhagen", 18],
	        [0, 35, "Gibraltar", 18],
	        [0, 35, "Kaliningrad", 18],
	        [0, 35, "Kiev", 18],
	        [0, 35, "Lisbon", 18],
	        [0, 35, "Ljubljana", 18],
	        [0, 35, "Luxembourg", 18],
	        [0, 35, "Madrid", 18],
	        [0, 35, "Malta", 18],
	        [0, 35, "Minsk", 18],
	        [0, 35, "Monaco", 18],
	        [0, 35, "Oslo", 18],
	        [0, 35, "Paris", 18],
	        [0, 35, "Podgorica", 18],
	        [0, 35, "Prague", 18],
	        [0, 35, "Riga", 18],
	        [0, 35, "Rome", 18],
	        [0, 35, "San_Marino", 18],
	        [0, 35, "Sarajevo", 18],
	        [0, 35, "Simferopol", 18],
	        [0, 35, "Skopje", 18],
	        [0, 35, "Sofia", 18],
	        [0, 35, "Stockholm", 18],
	        [0, 35, "Tallinn", 18],
	        [0, 35, "Tirane", 18],
	        [0, 35, "Tiraspol", 18],
	        [0, 35, "Uzhgorod", 18],
	        [0, 35, "Vaduz", 18],
	        [0, 35, "Vatican", 18],
	        [0, 35, "Vienna", 18],
	        [0, 35, "Vilnius", 18],
	        [0, 35, "Warsaw", 18],
	        [0, 35, "Zagreb", 18],
	        [0, 35, "Zaporozhye", 18],
	        [0, 35, "Zurich", 18],
	        [0, 35, "Libya"],
	        [0, 35, "Poland"],
	        [0, 35, "Portugal"],
	        [0, 35, "WET"],
	        [0, 42, "Kaliningrad", 18]
	      ],
	      [
	        [1, 28, "Scoresbysund", 9]
	      ],
	      [
	        [0, 25, "Scoresbysund", 9]
	      ],
	      [
	        [1, 80, "Chatham", 21],
	        [1, 80, "NZ-CHAT"]
	      ],
	      [
	        [0, 78, "Chatham", 21],
	        [0, 78, "NZ-CHAT"]
	      ],
	      [
	        [0, 67, "Harbin", 12],
	        [0, 69, "Harbin", 12]
	      ],
	      [
	        [1, 10, "Belize", 9]
	      ],
	      [
	        [1, 72, "Choibalsan", 12]
	      ],
	      [
	        [0, 69, "Choibalsan", 12]
	      ],
	      [
	        [0, 65, "Dili", 12],
	        [0, 65, "Makassar", 12],
	        [0, 65, "Pontianak", 12],
	        [0, 65, "Ujung_Pandang", 12]
	      ],
	      [
	        [0, 69, "Sakhalin", 12]
	      ],
	      [
	        [1, 5, "Rarotonga", 21]
	      ],
	      [
	        [0, 4, "Rarotonga", 21]
	      ],
	      [
	        [1, 22, "Santiago", 9],
	        [1, 14, "Santiago", 9],
	        [1, 22, "Palmer", 10],
	        [1, 22, "Continental", 17],
	        [1, 14, "Continental", 17]
	      ],
	      [
	        [0, 14, "Santiago", 9],
	        [0, 11, "Santiago", 9],
	        [0, 14, "Palmer", 10],
	        [0, 14, "Continental", 17],
	        [0, 11, "Continental", 17]
	      ],
	      [
	        [1, 14, "Bogota", 9]
	      ],
	      [
	        [0, 11, "Bogota", 9]
	      ],
	      [
	        [1, 11, "Chicago", 9],
	        [1, 11, "Atikokan", 9],
	        [1, 11, "Coral_Harbour", 9],
	        [1, 11, "Fort_Wayne", 9],
	        [1, 11, "Indianapolis", 4],
	        [1, 11, "Knox", 4],
	        [1, 11, "Marengo", 4],
	        [1, 11, "Petersburg", 4],
	        [1, 11, "Vevay", 4],
	        [1, 11, "Vincennes", 4],
	        [1, 11, "Winamac", 4],
	        [1, 11, "Indianapolis", 9],
	        [1, 11, "Louisville", 6],
	        [1, 11, "Monticello", 6],
	        [1, 11, "Knox_IN", 9],
	        [1, 11, "Louisville", 9],
	        [1, 11, "Menominee", 9],
	        [1, 11, "Rainy_River", 9],
	        [1, 11, "Rankin_Inlet", 9],
	        [1, 11, "Winnipeg", 9],
	        [1, 11, "Central", 16],
	        [1, 11, "CST6CDT"],
	        [1, 11, "Central"],
	        [1, 11, "East-Indiana"],
	        [1, 11, "Indiana-Starke"]
	      ],
	      [
	        [0, 9, "Chicago", 9],
	        [0, 11, "Havana", 9],
	        [0, 11, "Cuba"],
	        [0, 9, "Atikokan", 9],
	        [0, 9, "Belize", 9],
	        [0, 9, "Cambridge_Bay", 9],
	        [0, 9, "Cancun", 9],
	        [0, 9, "Chihuahua", 9],
	        [0, 9, "Coral_Harbour", 9],
	        [0, 9, "Costa_Rica", 9],
	        [0, 9, "Detroit", 9],
	        [0, 9, "El_Salvador", 9],
	        [0, 9, "Fort_Wayne", 9],
	        [0, 9, "Guatemala", 9],
	        [0, 9, "Hermosillo", 9],
	        [0, 9, "Indianapolis", 4],
	        [0, 9, "Knox", 4],
	        [0, 9, "Marengo", 4],
	        [0, 9, "Petersburg", 4],
	        [0, 9, "Vevay", 4],
	        [0, 9, "Vincennes", 4],
	        [0, 9, "Winamac", 4],
	        [0, 9, "Indianapolis", 9],
	        [0, 9, "Iqaluit", 9],
	        [0, 9, "Louisville", 6],
	        [0, 9, "Monticello", 6],
	        [0, 9, "Knox_IN", 9],
	        [0, 9, "Louisville", 9],
	        [0, 9, "Managua", 9],
	        [0, 9, "Mazatlan", 9],
	        [0, 9, "Menominee", 9],
	        [0, 9, "Merida", 9],
	        [0, 9, "Mexico_City", 9],
	        [0, 9, "Monterrey", 9],
	        [0, 9, "Center", 8],
	        [0, 9, "New_Salem", 8],
	        [0, 9, "Pangnirtung", 9],
	        [0, 9, "Rainy_River", 9],
	        [0, 9, "Rankin_Inlet", 9],
	        [0, 9, "Regina", 9],
	        [0, 9, "Swift_Current", 9],
	        [0, 9, "Tegucigalpa", 9],
	        [0, 9, "Winnipeg", 9],
	        [0, 9, "Central", 16],
	        [0, 9, "East-Saskatchewan", 16],
	        [0, 9, "Saskatchewan", 16],
	        [0, 9, "CST6CDT"],
	        [0, 9, "BajaSur", 20],
	        [0, 9, "General", 20],
	        [0, 9, "Central"],
	        [0, 9, "East-Indiana"],
	        [0, 9, "Indiana-Starke"],
	        [0, 9, "Michigan"],
	        [0, 65, "Chongqing", 12],
	        [0, 65, "Chungking", 12],
	        [0, 65, "Harbin", 12],
	        [0, 65, "Kashgar", 12],
	        [0, 65, "Macao", 12],
	        [0, 65, "Macau", 12],
	        [0, 65, "Shanghai", 12],
	        [0, 65, "Taipei", 12],
	        [0, 65, "Urumqi", 12],
	        [0, 65, "PRC"],
	        [0, 65, "ROC"],
	        [0, 70, "Jayapura", 12],
	        [0, 70, "Adelaide", 14],
	        [0, 70, "Broken_Hill", 14],
	        [0, 70, "Darwin", 14],
	        [0, 70, "North", 14],
	        [0, 70, "South", 14],
	        [0, 70, "Yancowinna", 14],
	        [1, 73, "Adelaide", 14],
	        [1, 73, "Broken_Hill", 14],
	        [1, 73, "Darwin", 14],
	        [1, 73, "North", 14],
	        [1, 73, "South", 14],
	        [1, 73, "Yancowinna", 14]
	      ],
	      [
	        [1, 28, "Cape_Verde", 13]
	      ],
	      [
	        [0, 28, "Cape_Verde", 13],
	        [0, 25, "Cape_Verde", 13]
	      ],
	      [
	        [0, 68, "Eucla", 14],
	        [1, 71, "Eucla", 14]
	      ],
	      [
	        [1, 11, "Chicago", 9],
	        [1, 11, "Atikokan", 9],
	        [1, 11, "Coral_Harbour", 9],
	        [1, 11, "Fort_Wayne", 9],
	        [1, 11, "Indianapolis", 4],
	        [1, 11, "Knox", 4],
	        [1, 11, "Marengo", 4],
	        [1, 11, "Petersburg", 4],
	        [1, 11, "Vevay", 4],
	        [1, 11, "Vincennes", 4],
	        [1, 11, "Winamac", 4],
	        [1, 11, "Indianapolis", 9],
	        [1, 11, "Louisville", 6],
	        [1, 11, "Monticello", 6],
	        [1, 11, "Knox_IN", 9],
	        [1, 11, "Louisville", 9],
	        [1, 11, "Menominee", 9],
	        [1, 11, "Mexico_City", 9],
	        [1, 11, "Rainy_River", 9],
	        [1, 11, "Rankin_Inlet", 9],
	        [1, 11, "Winnipeg", 9],
	        [1, 11, "Central", 16],
	        [1, 11, "CST6CDT"],
	        [1, 11, "General", 20],
	        [1, 11, "Central"],
	        [1, 11, "East-Indiana"],
	        [1, 11, "Indiana-Starke"]
	      ],
	      [
	        [0, 72, "Guam", 21],
	        [0, 72, "Saipan", 21]
	      ],
	      [
	        [0, 57, "Dacca", 12],
	        [0, 57, "Dhaka", 12]
	      ],
	      [
	        [0, 59, "Davis", 10]
	      ],
	      [
	        [0, 72, "DumontDUrville", 10]
	      ],
	      [
	        [1, 57, "Dushanbe", 12],
	        [1, 59, "Dushanbe", 12]
	      ],
	      [
	        [0, 54, "Dushanbe", 12],
	        [0, 57, "Dushanbe", 12]
	      ],
	      [
	        [1, 11, "EasterIsland", 17],
	        [1, 9, "EasterIsland", 17],
	        [1, 11, "Easter", 21],
	        [1, 9, "Easter", 21]
	      ],
	      [
	        [0, 9, "EasterIsland", 17],
	        [0, 8, "EasterIsland", 17],
	        [0, 9, "Easter", 21],
	        [0, 8, "Easter", 21],
	        [1, 51, "Antananarivo", 19]
	      ],
	      [
	        [0, 47, "Khartoum"],
	        [0, 47, "Addis_Ababa"],
	        [0, 47, "Asmara"],
	        [0, 47, "Asmera"],
	        [0, 47, "Dar_es_Salaam"],
	        [0, 47, "Djibouti"],
	        [0, 47, "Kampala"],
	        [0, 47, "Mogadishu"],
	        [0, 47, "Nairobi"],
	        [0, 47, "Antananarivo", 19],
	        [0, 47, "Comoro", 19],
	        [0, 47, "Mayotte", 19]
	      ],
	      [
	        [0, 11, "Guayaquil", 9],
	        [0, 11, "Galapagos", 21]
	      ],
	      [
	        [1, 22, "Iqaluit", 9]
	      ],
	      [
	        [1, 14, "New_York", 9],
	        [1, 14, "Cancun", 9],
	        [1, 14, "Detroit", 9],
	        [1, 14, "Fort_Wayne", 9],
	        [1, 14, "Grand_Turk", 9],
	        [1, 14, "Indianapolis", 4],
	        [1, 14, "Marengo", 4],
	        [1, 14, "Vevay", 4],
	        [1, 14, "Vincennes", 4],
	        [1, 14, "Winamac", 4],
	        [1, 14, "Indianapolis", 9],
	        [1, 14, "Iqaluit", 9],
	        [1, 14, "Jamaica", 9],
	        [1, 14, "Louisville", 6],
	        [1, 14, "Monticello", 6],
	        [1, 14, "Louisville", 9],
	        [1, 14, "Montreal", 9],
	        [1, 14, "Nassau", 9],
	        [1, 14, "Nipigon", 9],
	        [1, 14, "Pangnirtung", 9],
	        [1, 14, "Port-au-Prince", 9],
	        [1, 14, "Santo_Domingo", 9],
	        [1, 14, "Thunder_Bay", 9],
	        [1, 14, "Toronto", 9],
	        [1, 14, "Eastern", 16],
	        [1, 14, "EST"],
	        [1, 14, "EST5EDT"],
	        [1, 14, "Jamaica"],
	        [1, 14, "East-Indiana"],
	        [1, 14, "Eastern"],
	        [1, 14, "Michigan"]
	      ],
	      [
	        [1, 47, "Helsinki", 18],
	        [1, 47, "Cairo"],
	        [1, 47, "Amman", 12],
	        [1, 47, "Beirut", 12],
	        [1, 47, "Damascus", 12],
	        [1, 47, "Gaza", 12],
	        [1, 47, "Istanbul", 12],
	        [1, 47, "Nicosia", 12],
	        [1, 47, "EET"],
	        [1, 47, "Egypt"],
	        [1, 47, "Athens", 18],
	        [1, 47, "Bucharest", 18],
	        [1, 47, "Chisinau", 18],
	        [1, 47, "Istanbul", 18],
	        [1, 47, "Kaliningrad", 18],
	        [1, 47, "Kiev", 18],
	        [1, 47, "Mariehamn", 18],
	        [1, 47, "Minsk", 18],
	        [1, 47, "Moscow", 18],
	        [1, 47, "Nicosia", 18],
	        [1, 47, "Riga", 18],
	        [1, 47, "Simferopol", 18],
	        [1, 47, "Sofia", 18],
	        [1, 47, "Tallinn", 18],
	        [1, 47, "Tiraspol", 18],
	        [1, 47, "Uzhgorod", 18],
	        [1, 47, "Vilnius", 18],
	        [1, 47, "Warsaw", 18],
	        [1, 47, "Zaporozhye", 18],
	        [1, 47, "Poland"],
	        [1, 47, "Turkey"],
	        [1, 47, "W-SU"]
	      ],
	      [
	        [0, 42, "Helsinki", 18],
	        [1, 47, "Gaza", 12],
	        [0, 42, "Cairo"],
	        [0, 42, "Tripoli"],
	        [0, 42, "Amman", 12],
	        [0, 42, "Beirut", 12],
	        [0, 42, "Damascus", 12],
	        [0, 42, "Gaza", 12],
	        [0, 42, "Istanbul", 12],
	        [0, 42, "Nicosia", 12],
	        [0, 42, "EET"],
	        [0, 42, "Egypt"],
	        [0, 42, "Athens", 18],
	        [0, 42, "Bucharest", 18],
	        [0, 42, "Chisinau", 18],
	        [0, 42, "Istanbul", 18],
	        [0, 42, "Kaliningrad", 18],
	        [0, 42, "Kiev", 18],
	        [0, 42, "Mariehamn", 18],
	        [0, 42, "Minsk", 18],
	        [0, 42, "Moscow", 18],
	        [0, 42, "Nicosia", 18],
	        [0, 42, "Riga", 18],
	        [0, 42, "Simferopol", 18],
	        [0, 42, "Sofia", 18],
	        [0, 42, "Tallinn", 18],
	        [0, 42, "Tiraspol", 18],
	        [0, 42, "Uzhgorod", 18],
	        [0, 42, "Vilnius", 18],
	        [0, 42, "Warsaw", 18],
	        [0, 42, "Zaporozhye", 18],
	        [0, 42, "Libya"],
	        [0, 42, "Poland"],
	        [0, 42, "Turkey"],
	        [0, 42, "W-SU"]
	      ],
	      [
	        [1, 31, "Scoresbysund", 9]
	      ],
	      [
	        [0, 28, "Scoresbysund", 9]
	      ],
	      [
	        [1, 13, "Santo_Domingo", 9]
	      ],
	      [
	        [0, 69, "Jayapura", 12]
	      ],
	      [
	        [1, 14, "New_York", 9],
	        [1, 14, "Detroit", 9],
	        [1, 14, "Iqaluit", 9],
	        [1, 14, "Montreal", 9],
	        [1, 14, "Nipigon", 9],
	        [1, 14, "Thunder_Bay", 9],
	        [1, 14, "Toronto", 9],
	        [1, 14, "Eastern", 16],
	        [1, 14, "EST"],
	        [1, 14, "EST5EDT"],
	        [1, 14, "Eastern"],
	        [1, 14, "Michigan"]
	      ],
	      [
	        [0, 11, "New_York", 9],
	        [0, 11, "Antigua", 9],
	        [0, 11, "Atikokan", 9],
	        [0, 11, "Cambridge_Bay", 9],
	        [0, 11, "Cancun", 9],
	        [0, 11, "Cayman", 9],
	        [0, 11, "Chicago", 9],
	        [0, 11, "Coral_Harbour", 9],
	        [0, 11, "Detroit", 9],
	        [0, 11, "Fort_Wayne", 9],
	        [0, 11, "Grand_Turk", 9],
	        [0, 11, "Indianapolis", 4],
	        [0, 11, "Knox", 4],
	        [0, 11, "Marengo", 4],
	        [0, 11, "Petersburg", 4],
	        [0, 11, "Vevay", 4],
	        [0, 11, "Vincennes", 4],
	        [0, 11, "Winamac", 4],
	        [0, 11, "Indianapolis", 9],
	        [0, 11, "Iqaluit", 9],
	        [0, 11, "Jamaica", 9],
	        [0, 11, "Louisville", 6],
	        [0, 11, "Monticello", 6],
	        [0, 11, "Knox_IN", 9],
	        [0, 11, "Louisville", 9],
	        [0, 11, "Managua", 9],
	        [0, 11, "Menominee", 9],
	        [0, 11, "Merida", 9],
	        [0, 11, "Montreal", 9],
	        [0, 11, "Nassau", 9],
	        [0, 11, "Nipigon", 9],
	        [0, 11, "Panama", 9],
	        [0, 11, "Pangnirtung", 9],
	        [0, 11, "Port-au-Prince", 9],
	        [0, 11, "Rankin_Inlet", 9],
	        [0, 11, "Santo_Domingo", 9],
	        [0, 11, "Thunder_Bay", 9],
	        [0, 11, "Toronto", 9],
	        [0, 11, "Eastern", 16],
	        [0, 11, "EST"],
	        [0, 11, "EST5EDT"],
	        [0, 11, "Jamaica"],
	        [0, 11, "Central"],
	        [0, 11, "East-Indiana"],
	        [0, 11, "Eastern"],
	        [0, 11, "Indiana-Starke"],
	        [0, 11, "Michigan"],
	        [0, 72, "ACT", 14],
	        [0, 72, "Brisbane", 14],
	        [0, 72, "Canberra", 14],
	        [0, 72, "Currie", 14],
	        [0, 72, "Hobart", 14],
	        [0, 72, "Lindeman", 14],
	        [0, 72, "Melbourne", 14],
	        [0, 72, "NSW", 14],
	        [0, 72, "Queensland", 14],
	        [0, 72, "Sydney", 14],
	        [0, 72, "Tasmania", 14],
	        [0, 72, "Victoria", 14],
	        [1, 74, "Melbourne", 14],
	        [1, 74, "ACT", 14],
	        [1, 74, "Brisbane", 14],
	        [1, 74, "Canberra", 14],
	        [1, 74, "Currie", 14],
	        [1, 74, "Hobart", 14],
	        [1, 74, "Lindeman", 14],
	        [1, 74, "NSW", 14],
	        [1, 74, "Queensland", 14],
	        [1, 74, "Sydney", 14],
	        [1, 74, "Tasmania", 14],
	        [1, 74, "Victoria", 14]
	      ],
	      [
	        [1, 14, "New_York", 9],
	        [1, 14, "Detroit", 9],
	        [1, 14, "Iqaluit", 9],
	        [1, 14, "Montreal", 9],
	        [1, 14, "Nipigon", 9],
	        [1, 14, "Thunder_Bay", 9],
	        [1, 14, "Toronto", 9],
	        [1, 14, "Eastern", 16],
	        [1, 14, "EST"],
	        [1, 14, "EST5EDT"],
	        [1, 14, "Eastern"],
	        [1, 14, "Michigan"]
	      ],
	      [
	        [1, 79, "Fiji", 21]
	      ],
	      [
	        [0, 76, "Fiji", 21]
	      ],
	      [
	        [1, 22, "Stanley", 13],
	        [1, 25, "Stanley", 13]
	      ],
	      [
	        [0, 22, "Stanley", 13],
	        [0, 14, "Stanley", 13]
	      ],
	      [
	        [1, 28, "Noronha", 9],
	        [1, 28, "DeNoronha", 15]
	      ],
	      [
	        [0, 25, "Noronha", 9],
	        [0, 25, "DeNoronha", 15]
	      ],
	      [
	        [0, 51, "Aqtau", 12],
	        [0, 54, "Aqtau", 12]
	      ],
	      [
	        [1, 57, "Bishkek", 12],
	        [1, 59, "Bishkek", 12]
	      ],
	      [
	        [0, 54, "Bishkek", 12],
	        [0, 57, "Bishkek", 12]
	      ],
	      [
	        [0, 9, "Galapagos", 21]
	      ],
	      [
	        [0, 6, "Gambier", 21]
	      ],
	      [
	        [0, 16, "Guyana", 9]
	      ],
	      [
	        [1, 51, "Tbilisi", 12],
	        [1, 54, "Tbilisi", 12]
	      ],
	      [
	        [0, 47, "Tbilisi", 12],
	        [0, 51, "Tbilisi", 12]
	      ],
	      [
	        [0, 22, "Cayenne", 9],
	        [0, 14, "Cayenne", 9]
	      ],
	      [
	        [1, 33, "Accra"]
	      ],
	      [
	        [0, 31, "Abidjan"],
	        [0, 31, "Accra"],
	        [0, 31, "Bamako"],
	        [0, 31, "Banjul"],
	        [0, 31, "Bissau"],
	        [0, 31, "Conakry"],
	        [0, 31, "Dakar"],
	        [0, 31, "Freetown"],
	        [0, 31, "Malabo"],
	        [0, 31, "Monrovia"],
	        [0, 31, "Niamey"],
	        [0, 31, "Nouakchott"],
	        [0, 31, "Ouagadougou"],
	        [0, 31, "Porto-Novo"],
	        [0, 31, "Sao_Tome"],
	        [0, 31, "Timbuktu"],
	        [0, 31, "Danmarkshavn", 9],
	        [0, 31, "Reykjavik", 13],
	        [0, 31, "St_Helena", 13],
	        [0, 31, "Eire"],
	        [0, 31, "Belfast", 18],
	        [0, 31, "Dublin", 18],
	        [0, 31, "Gibraltar", 18],
	        [0, 31, "Guernsey", 18],
	        [0, 31, "Isle_of_Man", 18],
	        [0, 31, "Jersey", 18],
	        [0, 31, "London", 18],
	        [0, 31, "GB"],
	        [0, 31, "GB-Eire"],
	        [0, 31, "Iceland"]
	      ],
	      [
	        [0, 51, "Dubai", 12],
	        [0, 51, "Bahrain", 12],
	        [0, 51, "Muscat", 12],
	        [0, 51, "Qatar", 12]
	      ],
	      [
	        [0, 22, "Guyana", 9],
	        [0, 16, "Guyana", 9],
	        [0, 14, "Guyana", 9]
	      ],
	      [
	        [1, 6, "Adak", 9],
	        [1, 6, "Atka", 9],
	        [1, 6, "Aleutian"]
	      ],
	      [
	        [0, 4, "Adak", 9],
	        [0, 4, "Atka", 9],
	        [0, 4, "Aleutian"]
	      ],
	      [
	        [1, 5, "Honolulu", 21],
	        [1, 5, "HST"],
	        [1, 5, "Hawaii"]
	      ],
	      [
	        [1, 69, "Hong_Kong", 12],
	        [1, 69, "Hongkong"]
	      ],
	      [
	        [0, 65, "Hong_Kong", 12],
	        [0, 65, "Hongkong"]
	      ],
	      [
	        [1, 65, "Hovd", 12]
	      ],
	      [
	        [0, 57, "Hovd", 12],
	        [0, 59, "Hovd", 12]
	      ],
	      [
	        [1, 5, "Honolulu", 21],
	        [1, 5, "HST"],
	        [1, 5, "Hawaii"]
	      ],
	      [
	        [0, 4, "Honolulu", 21],
	        [0, 3, "Honolulu", 21],
	        [0, 4, "HST"],
	        [0, 4, "Hawaii"],
	        [0, 3, "HST"],
	        [0, 3, "Hawaii"]
	      ],
	      [
	        [1, 5, "Honolulu", 21],
	        [1, 5, "HST"],
	        [1, 5, "Hawaii"]
	      ],
	      [
	        [0, 59, "Bangkok", 12],
	        [0, 59, "Phnom_Penh", 12],
	        [0, 59, "Saigon", 12],
	        [0, 59, "Vientiane", 12],
	        [0, 65, "Phnom_Penh", 12],
	        [0, 65, "Saigon", 12],
	        [0, 65, "Vientiane", 12]
	      ],
	      [
	        [1, 51, "Jerusalem", 12],
	        [1, 51, "Tel_Aviv", 12],
	        [1, 51, "Israel"]
	      ],
	      [
	        [1, 47, "Jerusalem", 12],
	        [1, 47, "Gaza", 12],
	        [1, 47, "Tel_Aviv", 12],
	        [1, 47, "Israel"]
	      ],
	      [
	        [1, 57, "Colombo", 12]
	      ],
	      [
	        [0, 54, "Chagos", 19],
	        [0, 57, "Chagos", 19]
	      ],
	      [
	        [1, 52, "Tehran", 12],
	        [1, 54, "Tehran", 12],
	        [1, 52, "Iran"],
	        [1, 54, "Iran"]
	      ],
	      [
	        [1, 65, "Irkutsk", 12],
	        [1, 69, "Irkutsk", 12]
	      ],
	      [
	        [0, 59, "Irkutsk", 12],
	        [0, 65, "Irkutsk", 12]
	      ],
	      [
	        [0, 49, "Tehran", 12],
	        [0, 51, "Tehran", 12],
	        [0, 49, "Iran"],
	        [0, 51, "Iran"]
	      ],
	      [
	        [1, 31, "Reykjavik", 13],
	        [1, 31, "Iceland"]
	      ],
	      [
	        [0, 42, "Jerusalem", 12],
	        [0, 28, "Reykjavik", 13],
	        [0, 28, "Iceland"],
	        [0, 55, "Calcutta", 12],
	        [0, 55, "Colombo", 12],
	        [0, 55, "Dacca", 12],
	        [0, 55, "Dhaka", 12],
	        [0, 55, "Karachi", 12],
	        [0, 55, "Katmandu", 12],
	        [0, 55, "Thimbu", 12],
	        [0, 55, "Thimphu", 12],
	        [1, 34, "Eire"],
	        [1, 34, "Dublin", 18],
	        [1, 58, "Calcutta", 12],
	        [1, 58, "Colombo", 12],
	        [1, 58, "Karachi", 12],
	        [0, 35, "Eire"],
	        [0, 35, "Dublin", 18],
	        [1, 35, "Eire"],
	        [1, 35, "Dublin", 18],
	        [0, 42, "Gaza", 12],
	        [0, 42, "Tel_Aviv", 12],
	        [0, 42, "Israel"]
	      ],
	      [
	        [0, 62, "Jakarta", 12]
	      ],
	      [
	        [1, 72, "Tokyo", 12],
	        [1, 72, "Japan"]
	      ],
	      [
	        [0, 69, "Tokyo", 12],
	        [0, 69, "Dili", 12],
	        [0, 69, "Jakarta", 12],
	        [0, 69, "Kuala_Lumpur", 12],
	        [0, 69, "Kuching", 12],
	        [0, 69, "Makassar", 12],
	        [0, 69, "Manila", 12],
	        [0, 69, "Pontianak", 12],
	        [0, 69, "Rangoon", 12],
	        [0, 69, "Sakhalin", 12],
	        [0, 69, "Singapore", 12],
	        [0, 69, "Ujung_Pandang", 12],
	        [0, 69, "Japan"],
	        [0, 69, "Nauru", 21],
	        [0, 69, "Singapore"]
	      ],
	      [
	        [0, 54, "Karachi", 12]
	      ],
	      [
	        [0, 54, "Kashgar", 12],
	        [0, 55, "Kashgar", 12]
	      ],
	      [
	        [1, 69, "Seoul", 12],
	        [1, 72, "Seoul", 12],
	        [1, 69, "ROK"],
	        [1, 72, "ROK"]
	      ],
	      [
	        [1, 57, "Bishkek", 12]
	      ],
	      [
	        [0, 54, "Bishkek", 12],
	        [0, 57, "Bishkek", 12]
	      ],
	      [
	        [1, 57, "Qyzylorda", 12]
	      ],
	      [
	        [0, 51, "Qyzylorda", 12],
	        [0, 54, "Qyzylorda", 12],
	        [0, 57, "Qyzylorda", 12]
	      ],
	      [
	        [0, 38, "Vilnius", 18]
	      ],
	      [
	        [0, 74, "Kosrae", 21],
	        [0, 76, "Kosrae", 21]
	      ],
	      [
	        [1, 59, "Krasnoyarsk", 12],
	        [1, 65, "Krasnoyarsk", 12]
	      ],
	      [
	        [0, 57, "Krasnoyarsk", 12],
	        [0, 59, "Krasnoyarsk", 12]
	      ],
	      [
	        [0, 65, "Seoul", 12],
	        [0, 67, "Seoul", 12],
	        [0, 69, "Seoul", 12],
	        [0, 65, "Pyongyang", 12],
	        [0, 65, "ROK"],
	        [0, 67, "Pyongyang", 12],
	        [0, 67, "ROK"],
	        [0, 69, "Pyongyang", 12],
	        [0, 69, "ROK"]
	      ],
	      [
	        [1, 47, "Samara", 18],
	        [1, 51, "Samara", 18],
	        [1, 54, "Samara", 18]
	      ],
	      [
	        [0, 47, "Samara", 18],
	        [0, 51, "Samara", 18]
	      ],
	      [
	        [0, 0, "Kwajalein", 21],
	        [0, 0, "Kwajalein"]
	      ],
	      [
	        [0, 73, "Lord_Howe", 14],
	        [1, 74, "Lord_Howe", 14],
	        [1, 75, "Lord_Howe", 14],
	        [0, 73, "LHI", 14],
	        [1, 74, "LHI", 14],
	        [1, 75, "LHI", 14]
	      ],
	      [
	        [0, 4, "Kiritimati", 21],
	        [0, 81, "Kiritimati", 21]
	      ],
	      [
	        [0, 57, "Colombo", 12],
	        [0, 58, "Colombo", 12]
	      ],
	      [
	        [0, 59, "Chongqing", 12],
	        [0, 59, "Chungking", 12]
	      ],
	      [
	        [0, 29, "Monrovia"]
	      ],
	      [
	        [1, 45, "Riga", 18]
	      ],
	      [
	        [1, 35, "Madeira", 13]
	      ],
	      [
	        [1, 31, "Madeira", 13]
	      ],
	      [
	        [0, 28, "Madeira", 13]
	      ],
	      [
	        [1, 74, "Magadan", 12],
	        [1, 76, "Magadan", 12]
	      ],
	      [
	        [0, 72, "Magadan", 12],
	        [0, 74, "Magadan", 12]
	      ],
	      [
	        [1, 62, "Singapore", 12],
	        [1, 62, "Kuala_Lumpur", 12],
	        [1, 62, "Singapore"]
	      ],
	      [
	        [0, 59, "Singapore", 12],
	        [0, 62, "Singapore", 12],
	        [0, 63, "Singapore", 12],
	        [0, 59, "Kuala_Lumpur", 12],
	        [0, 59, "Singapore"],
	        [0, 62, "Kuala_Lumpur", 12],
	        [0, 62, "Singapore"],
	        [0, 63, "Kuala_Lumpur", 12],
	        [0, 63, "Singapore"]
	      ],
	      [
	        [0, 5, "Marquesas", 21]
	      ],
	      [
	        [0, 57, "Mawson", 10]
	      ],
	      [
	        [1, 11, "Cambridge_Bay", 9],
	        [1, 11, "Yellowknife", 9]
	      ],
	      [
	        [1, 53, "Moscow", 18],
	        [1, 53, "W-SU"]
	      ],
	      [
	        [1, 9, "Denver", 9],
	        [1, 9, "Boise", 9],
	        [1, 9, "Cambridge_Bay", 9],
	        [1, 9, "Chihuahua", 9],
	        [1, 9, "Edmonton", 9],
	        [1, 9, "Hermosillo", 9],
	        [1, 9, "Inuvik", 9],
	        [1, 9, "Mazatlan", 9],
	        [1, 9, "Center", 8],
	        [1, 9, "New_Salem", 8],
	        [1, 9, "Phoenix", 9],
	        [1, 9, "Regina", 9],
	        [1, 9, "Shiprock", 9],
	        [1, 9, "Swift_Current", 9],
	        [1, 9, "Yellowknife", 9],
	        [1, 9, "East-Saskatchewan", 16],
	        [1, 9, "Mountain", 16],
	        [1, 9, "Saskatchewan", 16],
	        [1, 9, "BajaSur", 20],
	        [1, 9, "MST"],
	        [1, 9, "MST7MDT"],
	        [1, 9, "Navajo"],
	        [1, 9, "Arizona"],
	        [1, 9, "Mountain"]
	      ],
	      [
	        [1, 42, "MET"]
	      ],
	      [
	        [0, 35, "MET"]
	      ],
	      [
	        [0, 76, "Kwajalein", 21],
	        [0, 76, "Kwajalein"],
	        [0, 76, "Majuro", 21]
	      ],
	      [
	        [0, 44, "Moscow", 18],
	        [0, 58, "Rangoon", 12],
	        [0, 64, "Makassar", 12],
	        [0, 64, "Ujung_Pandang", 12],
	        [0, 44, "W-SU"]
	      ],
	      [
	        [1, 69, "Macao", 12],
	        [1, 69, "Macau", 12]
	      ],
	      [
	        [0, 65, "Macao", 12],
	        [0, 65, "Macau", 12]
	      ],
	      [
	        [1, 9, "Denver", 9],
	        [1, 9, "Boise", 9],
	        [1, 9, "Cambridge_Bay", 9],
	        [1, 9, "Edmonton", 9],
	        [1, 9, "Center", 8],
	        [1, 9, "New_Salem", 8],
	        [1, 9, "Regina", 9],
	        [1, 9, "Shiprock", 9],
	        [1, 9, "Swift_Current", 9],
	        [1, 9, "Yellowknife", 9],
	        [1, 9, "East-Saskatchewan", 16],
	        [1, 9, "Mountain", 16],
	        [1, 9, "Saskatchewan", 16],
	        [1, 9, "MST"],
	        [1, 9, "MST7MDT"],
	        [1, 9, "Navajo"],
	        [1, 9, "Mountain"],
	        [0, 72, "Saipan", 21]
	      ],
	      [
	        [1, 51, "Moscow", 18],
	        [1, 54, "Moscow", 18],
	        [1, 51, "Chisinau", 18],
	        [1, 51, "Kaliningrad", 18],
	        [1, 51, "Kiev", 18],
	        [1, 51, "Minsk", 18],
	        [1, 51, "Riga", 18],
	        [1, 51, "Simferopol", 18],
	        [1, 51, "Tallinn", 18],
	        [1, 51, "Tiraspol", 18],
	        [1, 51, "Uzhgorod", 18],
	        [1, 51, "Vilnius", 18],
	        [1, 51, "Zaporozhye", 18],
	        [1, 51, "W-SU"],
	        [1, 54, "W-SU"]
	      ],
	      [
	        [0, 47, "Moscow", 18],
	        [0, 47, "Chisinau", 18],
	        [0, 47, "Kaliningrad", 18],
	        [0, 47, "Kiev", 18],
	        [0, 47, "Minsk", 18],
	        [0, 47, "Riga", 18],
	        [0, 47, "Simferopol", 18],
	        [0, 47, "Tallinn", 18],
	        [0, 47, "Tiraspol", 18],
	        [0, 47, "Uzhgorod", 18],
	        [0, 47, "Vilnius", 18],
	        [0, 47, "Zaporozhye", 18],
	        [0, 47, "W-SU"]
	      ],
	      [
	        [0, 8, "Denver", 9],
	        [0, 8, "Boise", 9],
	        [0, 8, "Cambridge_Bay", 9],
	        [0, 8, "Chihuahua", 9],
	        [0, 8, "Dawson_Creek", 9],
	        [0, 8, "Edmonton", 9],
	        [0, 8, "Ensenada", 9],
	        [0, 8, "Hermosillo", 9],
	        [0, 8, "Inuvik", 9],
	        [0, 8, "Mazatlan", 9],
	        [0, 8, "Mexico_City", 9],
	        [0, 8, "Center", 8],
	        [0, 8, "New_Salem", 8],
	        [0, 8, "Phoenix", 9],
	        [0, 8, "Regina", 9],
	        [0, 8, "Shiprock", 9],
	        [0, 8, "Swift_Current", 9],
	        [0, 8, "Tijuana", 9],
	        [0, 8, "Yellowknife", 9],
	        [0, 8, "East-Saskatchewan", 16],
	        [0, 8, "Mountain", 16],
	        [0, 8, "Saskatchewan", 16],
	        [0, 8, "BajaNorte", 20],
	        [0, 8, "BajaSur", 20],
	        [0, 8, "General", 20],
	        [0, 8, "MST"],
	        [0, 8, "MST7MDT"],
	        [0, 8, "Navajo"],
	        [0, 8, "Arizona"],
	        [0, 8, "Mountain"],
	        [1, 50, "Moscow", 18],
	        [1, 50, "W-SU"]
	      ],
	      [
	        [0, 51, "Mauritius", 19]
	      ],
	      [
	        [0, 54, "Maldives", 19]
	      ],
	      [
	        [1, 9, "Denver", 9],
	        [1, 9, "Boise", 9],
	        [1, 9, "Cambridge_Bay", 9],
	        [1, 9, "Edmonton", 9],
	        [1, 9, "Center", 8],
	        [1, 9, "New_Salem", 8],
	        [1, 9, "Phoenix", 9],
	        [1, 9, "Regina", 9],
	        [1, 9, "Shiprock", 9],
	        [1, 9, "Swift_Current", 9],
	        [1, 9, "Yellowknife", 9],
	        [1, 9, "East-Saskatchewan", 16],
	        [1, 9, "Mountain", 16],
	        [1, 9, "Saskatchewan", 16],
	        [1, 9, "MST"],
	        [1, 9, "MST7MDT"],
	        [1, 9, "Navajo"],
	        [1, 9, "Arizona"],
	        [1, 9, "Mountain"]
	      ],
	      [
	        [0, 65, "Kuala_Lumpur", 12],
	        [0, 65, "Kuching", 12]
	      ],
	      [
	        [1, 76, "Noumea", 21]
	      ],
	      [
	        [0, 74, "Noumea", 21]
	      ],
	      [
	        [1, 26, "St_Johns", 9],
	        [1, 26, "Newfoundland", 16]
	      ],
	      [
	        [1, 24, "St_Johns", 9],
	        [1, 23, "St_Johns", 9],
	        [1, 4, "Midway", 21],
	        [1, 24, "Goose_Bay", 9],
	        [1, 24, "Newfoundland", 16],
	        [1, 23, "Goose_Bay", 9],
	        [1, 23, "Newfoundland", 16]
	      ],
	      [
	        [0, 21, "Paramaribo", 9]
	      ],
	      [
	        [1, 37, "Amsterdam", 18]
	      ],
	      [
	        [0, 33, "Amsterdam", 18]
	      ],
	      [
	        [0, 75, "Norfolk", 21]
	      ],
	      [
	        [1, 59, "Novosibirsk", 12],
	        [1, 65, "Novosibirsk", 12]
	      ],
	      [
	        [0, 57, "Novosibirsk", 12],
	        [0, 59, "Novosibirsk", 12]
	      ],
	      [
	        [1, 24, "St_Johns", 9],
	        [1, 4, "Adak", 9],
	        [1, 4, "Atka", 9],
	        [1, 4, "Nome", 9],
	        [1, 4, "Aleutian"],
	        [1, 24, "Goose_Bay", 9],
	        [1, 24, "Newfoundland", 16],
	        [0, 56, "Katmandu", 12]
	      ],
	      [
	        [0, 75, "Nauru", 21],
	        [0, 76, "Nauru", 21]
	      ],
	      [
	        [0, 21, "St_Johns", 9],
	        [0, 20, "St_Johns", 9],
	        [0, 21, "Goose_Bay", 9],
	        [0, 21, "Newfoundland", 16],
	        [0, 20, "Goose_Bay", 9],
	        [0, 20, "Newfoundland", 16],
	        [0, 2, "Adak", 9],
	        [0, 2, "Atka", 9],
	        [0, 2, "Nome", 9],
	        [0, 2, "Midway", 21],
	        [0, 2, "Pago_Pago", 21],
	        [0, 2, "Samoa", 21],
	        [0, 2, "Aleutian"],
	        [0, 2, "Samoa"],
	        [1, 36, "Amsterdam", 18]
	      ],
	      [
	        [0, 2, "Niue", 21],
	        [0, 1, "Niue", 21]
	      ],
	      [
	        [1, 24, "St_Johns", 9],
	        [1, 4, "Adak", 9],
	        [1, 4, "Atka", 9],
	        [1, 4, "Nome", 9],
	        [1, 4, "Aleutian"],
	        [1, 24, "Goose_Bay", 9],
	        [1, 24, "Newfoundland", 16]
	      ],
	      [
	        [1, 79, "Auckland", 21],
	        [1, 79, "McMurdo", 10],
	        [1, 79, "South_Pole", 10],
	        [1, 79, "NZ"]
	      ],
	      [
	        [0, 75, "Auckland", 21],
	        [0, 75, "NZ"]
	      ],
	      [
	        [0, 76, "Auckland", 21],
	        [1, 76, "Auckland", 21],
	        [1, 77, "Auckland", 21],
	        [0, 76, "McMurdo", 10],
	        [0, 76, "South_Pole", 10],
	        [0, 76, "NZ"],
	        [1, 76, "NZ"],
	        [1, 77, "NZ"]
	      ],
	      [
	        [1, 57, "Omsk", 12],
	        [1, 59, "Omsk", 12]
	      ],
	      [
	        [0, 54, "Omsk", 12],
	        [0, 57, "Omsk", 12]
	      ],
	      [
	        [1, 54, "Oral", 12]
	      ],
	      [
	        [0, 51, "Oral", 12],
	        [0, 54, "Oral", 12]
	      ],
	      [
	        [1, 9, "Inuvik", 9]
	      ],
	      [
	        [1, 8, "Los_Angeles", 9],
	        [1, 8, "Boise", 9],
	        [1, 8, "Dawson", 9],
	        [1, 8, "Dawson_Creek", 9],
	        [1, 8, "Ensenada", 9],
	        [1, 8, "Inuvik", 9],
	        [1, 8, "Juneau", 9],
	        [1, 8, "Tijuana", 9],
	        [1, 8, "Vancouver", 9],
	        [1, 8, "Whitehorse", 9],
	        [1, 8, "Pacific", 16],
	        [1, 8, "Yukon", 16],
	        [1, 8, "BajaNorte", 20],
	        [1, 8, "PST8PDT"],
	        [1, 8, "Pacific"],
	        [1, 8, "Pacific-New"]
	      ],
	      [
	        [1, 14, "Lima", 9]
	      ],
	      [
	        [1, 76, "Kamchatka", 12],
	        [1, 79, "Kamchatka", 12]
	      ],
	      [
	        [0, 74, "Kamchatka", 12],
	        [0, 76, "Kamchatka", 12]
	      ],
	      [
	        [0, 11, "Lima", 9]
	      ],
	      [
	        [0, 2, "Enderbury", 21],
	        [0, 79, "Enderbury", 21]
	      ],
	      [
	        [1, 69, "Manila", 12]
	      ],
	      [
	        [0, 65, "Manila", 12]
	      ],
	      [
	        [1, 57, "Karachi", 12]
	      ],
	      [
	        [0, 54, "Karachi", 12]
	      ],
	      [
	        [1, 25, "Miquelon", 9]
	      ],
	      [
	        [0, 22, "Miquelon", 9]
	      ],
	      [
	        [0, 18, "Paramaribo", 9],
	        [0, 17, "Paramaribo", 9],
	        [0, 61, "Pontianak", 12],
	        [0, 72, "DumontDUrville", 10]
	      ],
	      [
	        [1, 8, "Los_Angeles", 9],
	        [1, 8, "Dawson_Creek", 9],
	        [1, 8, "Ensenada", 9],
	        [1, 8, "Inuvik", 9],
	        [1, 8, "Juneau", 9],
	        [1, 8, "Tijuana", 9],
	        [1, 8, "Vancouver", 9],
	        [1, 8, "Pacific", 16],
	        [1, 8, "BajaNorte", 20],
	        [1, 8, "PST8PDT"],
	        [1, 8, "Pacific"],
	        [1, 8, "Pacific-New"]
	      ],
	      [
	        [0, 7, "Los_Angeles", 9],
	        [0, 7, "Boise", 9],
	        [0, 7, "Dawson", 9],
	        [0, 7, "Dawson_Creek", 9],
	        [0, 7, "Ensenada", 9],
	        [0, 7, "Hermosillo", 9],
	        [0, 7, "Inuvik", 9],
	        [0, 7, "Juneau", 9],
	        [0, 7, "Mazatlan", 9],
	        [0, 7, "Tijuana", 9],
	        [0, 7, "Vancouver", 9],
	        [0, 7, "Whitehorse", 9],
	        [0, 7, "Pacific", 16],
	        [0, 7, "Yukon", 16],
	        [0, 7, "BajaNorte", 20],
	        [0, 7, "BajaSur", 20],
	        [0, 7, "Pitcairn", 21],
	        [0, 7, "PST8PDT"],
	        [0, 7, "Pacific"],
	        [0, 7, "Pacific-New"]
	      ],
	      [
	        [1, 8, "Los_Angeles", 9],
	        [1, 8, "Dawson_Creek", 9],
	        [1, 8, "Ensenada", 9],
	        [1, 8, "Inuvik", 9],
	        [1, 8, "Juneau", 9],
	        [1, 8, "Tijuana", 9],
	        [1, 8, "Vancouver", 9],
	        [1, 8, "Pacific", 16],
	        [1, 8, "BajaNorte", 20],
	        [1, 8, "PST8PDT"],
	        [1, 8, "Pacific"],
	        [1, 8, "Pacific-New"]
	      ],
	      [
	        [1, 22, "Asuncion", 9]
	      ],
	      [
	        [0, 22, "Asuncion", 9],
	        [0, 14, "Asuncion", 9]
	      ],
	      [
	        [1, 59, "Qyzylorda", 12]
	      ],
	      [
	        [0, 54, "Qyzylorda", 12],
	        [0, 57, "Qyzylorda", 12]
	      ],
	      [
	        [0, 51, "Reunion", 19]
	      ],
	      [
	        [0, 39, "Riga", 18]
	      ],
	      [
	        [0, 22, "Rothera", 10]
	      ],
	      [
	        [1, 74, "Sakhalin", 12],
	        [1, 76, "Sakhalin", 12]
	      ],
	      [
	        [0, 72, "Sakhalin", 12],
	        [0, 74, "Sakhalin", 12]
	      ],
	      [
	        [1, 57, "Samarkand", 12],
	        [1, 54, "Samara", 18]
	      ],
	      [
	        [0, 51, "Samarkand", 12],
	        [0, 54, "Samarkand", 12],
	        [0, 1, "Apia", 21],
	        [0, 1, "Pago_Pago", 21],
	        [0, 1, "Samoa", 21],
	        [0, 1, "Samoa"],
	        [0, 47, "Samara", 18],
	        [0, 51, "Samara", 18]
	      ],
	      [
	        [1, 47, "Johannesburg"],
	        [0, 42, "Johannesburg"],
	        [1, 47, "Maseru"],
	        [1, 47, "Windhoek"],
	        [0, 42, "Maseru"],
	        [0, 42, "Mbabane"],
	        [0, 42, "Windhoek"]
	      ],
	      [
	        [0, 74, "Guadalcanal", 21]
	      ],
	      [
	        [0, 51, "Mahe", 19]
	      ],
	      [
	        [0, 63, "Singapore", 12],
	        [0, 65, "Singapore", 12],
	        [0, 63, "Singapore"],
	        [0, 65, "Singapore"]
	      ],
	      [
	        [1, 57, "Aqtau", 12]
	      ],
	      [
	        [0, 54, "Aqtau", 12],
	        [0, 57, "Aqtau", 12]
	      ],
	      [
	        [1, 30, "Freetown"],
	        [1, 35, "Freetown"]
	      ],
	      [
	        [0, 60, "Saigon", 12],
	        [0, 12, "Santiago", 9],
	        [0, 12, "Continental", 17],
	        [0, 60, "Phnom_Penh", 12],
	        [0, 60, "Vientiane", 12]
	      ],
	      [
	        [0, 22, "Paramaribo", 9],
	        [0, 21, "Paramaribo", 9]
	      ],
	      [
	        [0, 2, "Samoa", 21],
	        [0, 2, "Midway", 21],
	        [0, 2, "Pago_Pago", 21],
	        [0, 2, "Samoa"]
	      ],
	      [
	        [0, 47, "Volgograd", 18],
	        [0, 51, "Volgograd", 18]
	      ],
	      [
	        [1, 54, "Yekaterinburg", 12],
	        [1, 57, "Yekaterinburg", 12]
	      ],
	      [
	        [0, 51, "Yekaterinburg", 12],
	        [0, 54, "Yekaterinburg", 12]
	      ],
	      [
	        [0, 47, "Syowa", 10]
	      ],
	      [
	        [0, 4, "Tahiti", 21]
	      ],
	      [
	        [1, 59, "Samarkand", 12],
	        [1, 57, "Tashkent", 12],
	        [1, 59, "Tashkent", 12]
	      ],
	      [
	        [0, 57, "Samarkand", 12],
	        [0, 54, "Tashkent", 12],
	        [0, 57, "Tashkent", 12]
	      ],
	      [
	        [1, 51, "Tbilisi", 12],
	        [1, 54, "Tbilisi", 12]
	      ],
	      [
	        [0, 47, "Tbilisi", 12],
	        [0, 51, "Tbilisi", 12]
	      ],
	      [
	        [0, 54, "Kerguelen", 19]
	      ],
	      [
	        [0, 54, "Dushanbe", 12]
	      ],
	      [
	        [0, 65, "Dili", 12],
	        [0, 69, "Dili", 12]
	      ],
	      [
	        [0, 48, "Tehran", 12],
	        [0, 48, "Iran"],
	        [0, 51, "Ashgabat", 12],
	        [0, 51, "Ashkhabad", 12],
	        [0, 54, "Ashgabat", 12],
	        [0, 54, "Ashkhabad", 12],
	        [0, 40, "Tallinn", 18]
	      ],
	      [
	        [1, 81, "Tongatapu", 21]
	      ],
	      [
	        [0, 79, "Tongatapu", 21]
	      ],
	      [
	        [1, 51, "Istanbul", 18],
	        [1, 51, "Istanbul", 12],
	        [1, 51, "Turkey"]
	      ],
	      [
	        [0, 47, "Istanbul", 18],
	        [0, 47, "Istanbul", 12],
	        [0, 47, "Turkey"]
	      ],
	      [
	        [0, 47, "Volgograd", 18]
	      ],
	      [
	        [1, 69, "Ulaanbaatar", 12],
	        [1, 69, "Ulan_Bator", 12]
	      ],
	      [
	        [0, 59, "Ulaanbaatar", 12],
	        [0, 65, "Ulaanbaatar", 12],
	        [0, 59, "Choibalsan", 12],
	        [0, 59, "Ulan_Bator", 12],
	        [0, 65, "Choibalsan", 12],
	        [0, 65, "Ulan_Bator", 12]
	      ],
	      [
	        [1, 54, "Oral", 12],
	        [1, 57, "Oral", 12]
	      ],
	      [
	        [0, 51, "Oral", 12],
	        [0, 54, "Oral", 12],
	        [0, 57, "Oral", 12]
	      ],
	      [
	        [0, 57, "Urumqi", 12]
	      ],
	      [
	        [1, 22, "Montevideo", 9],
	        [1, 24, "Montevideo", 9]
	      ],
	      [
	        [1, 25, "Montevideo", 9]
	      ],
	      [
	        [0, 22, "Montevideo", 9],
	        [0, 21, "Montevideo", 9]
	      ],
	      [
	        [1, 57, "Samarkand", 12],
	        [1, 57, "Tashkent", 12]
	      ],
	      [
	        [0, 54, "Samarkand", 12],
	        [0, 54, "Tashkent", 12]
	      ],
	      [
	        [0, 14, "Caracas", 9],
	        [0, 13, "Caracas", 9]
	      ],
	      [
	        [1, 72, "Vladivostok", 12]
	      ],
	      [
	        [0, 69, "Vladivostok", 12],
	        [1, 74, "Vladivostok", 12]
	      ],
	      [
	        [0, 69, "Vladivostok", 12],
	        [0, 72, "Vladivostok", 12]
	      ],
	      [
	        [1, 51, "Volgograd", 18],
	        [1, 54, "Volgograd", 18]
	      ],
	      [
	        [0, 47, "Volgograd", 18],
	        [0, 51, "Volgograd", 18]
	      ],
	      [
	        [0, 57, "Vostok", 10]
	      ],
	      [
	        [1, 76, "Efate", 21]
	      ],
	      [
	        [0, 74, "Efate", 21]
	      ],
	      [
	        [1, 22, "Mendoza", 9],
	        [1, 22, "Jujuy", 2],
	        [1, 22, "Mendoza", 2],
	        [1, 22, "Jujuy", 9]
	      ],
	      [
	        [0, 14, "Mendoza", 9],
	        [0, 14, "Catamarca", 2],
	        [0, 14, "ComodRivadavia", 2],
	        [0, 14, "Cordoba", 2],
	        [0, 14, "Jujuy", 2],
	        [0, 14, "La_Rioja", 2],
	        [0, 14, "Mendoza", 2],
	        [0, 14, "Rio_Gallegos", 2],
	        [0, 14, "San_Juan", 2],
	        [0, 14, "Tucuman", 2],
	        [0, 14, "Ushuaia", 2],
	        [0, 14, "Catamarca", 9],
	        [0, 14, "Cordoba", 9],
	        [0, 14, "Jujuy", 9],
	        [0, 14, "Rosario", 9]
	      ],
	      [
	        [1, 42, "Windhoek"],
	        [1, 42, "Ndjamena"]
	      ],
	      [
	        [0, 28, "Dakar"],
	        [0, 28, "Bamako"],
	        [0, 28, "Banjul"],
	        [0, 28, "Bissau"],
	        [0, 28, "Conakry"],
	        [0, 28, "El_Aaiun"],
	        [0, 28, "Freetown"],
	        [0, 28, "Niamey"],
	        [0, 28, "Nouakchott"],
	        [0, 28, "Timbuktu"],
	        [0, 31, "Freetown"],
	        [0, 35, "Brazzaville"],
	        [0, 35, "Bangui"],
	        [0, 35, "Douala"],
	        [0, 35, "Lagos"],
	        [0, 35, "Libreville"],
	        [0, 35, "Luanda"],
	        [0, 35, "Malabo"],
	        [0, 35, "Ndjamena"],
	        [0, 35, "Niamey"],
	        [0, 35, "Porto-Novo"],
	        [0, 35, "Windhoek"]
	      ],
	      [
	        [1, 42, "Lisbon", 18],
	        [1, 42, "Madrid", 18],
	        [1, 42, "Monaco", 18],
	        [1, 42, "Paris", 18],
	        [1, 42, "Portugal"],
	        [1, 42, "WET"]
	      ],
	      [
	        [1, 35, "Paris", 18],
	        [1, 35, "Algiers"],
	        [1, 35, "Casablanca"],
	        [1, 35, "Ceuta"],
	        [1, 35, "Canary", 13],
	        [1, 35, "Faeroe", 13],
	        [1, 35, "Faroe", 13],
	        [1, 35, "Madeira", 13],
	        [1, 35, "Brussels", 18],
	        [1, 35, "Lisbon", 18],
	        [1, 35, "Luxembourg", 18],
	        [1, 35, "Madrid", 18],
	        [1, 35, "Monaco", 18],
	        [1, 35, "Portugal"],
	        [1, 35, "WET"],
	        [1, 42, "Luxembourg", 18]
	      ],
	      [
	        [0, 31, "Paris", 18],
	        [0, 31, "Algiers"],
	        [0, 31, "Casablanca"],
	        [0, 31, "Ceuta"],
	        [0, 31, "El_Aaiun"],
	        [0, 31, "Azores", 13],
	        [0, 31, "Canary", 13],
	        [0, 31, "Faeroe", 13],
	        [0, 31, "Faroe", 13],
	        [0, 31, "Madeira", 13],
	        [0, 31, "Brussels", 18],
	        [0, 31, "Lisbon", 18],
	        [0, 31, "Luxembourg", 18],
	        [0, 31, "Madrid", 18],
	        [0, 31, "Monaco", 18],
	        [0, 31, "Portugal"],
	        [0, 31, "WET"],
	        [0, 35, "Luxembourg", 18]
	      ],
	      [
	        [1, 25, "Godthab", 9],
	        [1, 25, "Danmarkshavn", 9]
	      ],
	      [
	        [0, 22, "Godthab", 9],
	        [0, 22, "Danmarkshavn", 9]
	      ],
	      [
	        [0, 59, "Jakarta", 12],
	        [0, 63, "Jakarta", 12],
	        [0, 65, "Jakarta", 12],
	        [0, 59, "Pontianak", 12],
	        [0, 63, "Pontianak", 12],
	        [0, 65, "Pontianak", 12]
	      ],
	      [
	        [0, 65, "Perth", 14],
	        [1, 69, "Perth", 14],
	        [0, 2, "Apia", 21],
	        [0, 65, "Casey", 10],
	        [0, 65, "West", 14],
	        [1, 69, "West", 14]
	      ],
	      [
	        [1, 69, "Yakutsk", 12],
	        [1, 72, "Yakutsk", 12]
	      ],
	      [
	        [0, 65, "Yakutsk", 12],
	        [0, 69, "Yakutsk", 12]
	      ],
	      [
	        [1, 8, "Dawson", 9],
	        [1, 8, "Whitehorse", 9],
	        [1, 8, "Yukon", 16]
	      ],
	      [
	        [1, 7, "Dawson", 9],
	        [1, 7, "Whitehorse", 9],
	        [1, 7, "Yakutat", 9],
	        [1, 7, "Yukon", 16]
	      ],
	      [
	        [1, 57, "Yekaterinburg", 12]
	      ],
	      [
	        [0, 54, "Yekaterinburg", 12]
	      ],
	      [
	        [1, 51, "Yerevan", 12],
	        [1, 54, "Yerevan", 12]
	      ],
	      [
	        [0, 47, "Yerevan", 12],
	        [0, 51, "Yerevan", 12]
	      ],
	      [
	        [1, 7, "Dawson", 9],
	        [1, 7, "Whitehorse", 9],
	        [1, 7, "Yakutat", 9],
	        [1, 7, "Yukon", 16]
	      ],
	      [
	        [0, 6, "Anchorage", 9],
	        [0, 6, "Dawson", 9],
	        [0, 6, "Juneau", 9],
	        [0, 6, "Nome", 9],
	        [0, 6, "Whitehorse", 9],
	        [0, 6, "Yakutat", 9],
	        [0, 6, "Yukon", 16],
	        [0, 6, "Alaska"]
	      ],
	      [
	        [1, 7, "Dawson", 9],
	        [1, 7, "Whitehorse", 9],
	        [1, 7, "Yakutat", 9],
	        [1, 7, "Yukon", 16]
	      ],
	      [
	        [0, 35]
	      ],
	      [
	        [0, 42]
	      ],
	      [
	        [0, 47]
	      ],
	      [
	        [0, 51]
	      ],
	      [
	        [0, 54]
	      ],
	      [
	        [0, 57]
	      ],
	      [
	        [0, 59]
	      ],
	      [
	        [0, 65]
	      ],
	      [
	        [0, 69]
	      ],
	      [
	        [0, 72]
	      ],
	      [
	        [0, 74]
	      ],
	      [
	        [0, 76]
	      ],
	      [
	        [0, 28]
	      ],
	      [
	        [0, 25]
	      ],
	      [
	        [0, 22]
	      ],
	      [
	        [0, 14]
	      ],
	      [
	        [0, 11]
	      ],
	      [
	        [0, 9]
	      ],
	      [
	        [0, 8]
	      ],
	      [
	        [0, 31, "UTC"]
	      ],
	      [
	        [0, 7]
	      ],
	      [
	        [0, 6]
	      ],
	      [
	        [0, 4]
	      ],
	      [
	        [0, 2]
	      ],
	      [
	        [0, 0]
	      ],
	      [
	        [0, 31, "Davis", 10],
	        [0, 31, "DumontDUrville", 10]
	      ],
	      [
	        [0, 31]
	      ]
	    ];
	  }

	  if (!php_js_shared.tz_abbreviations) {
	    php_js_shared.tz_abbreviations = ["acst", "act", "addt", "adt", "aft", "ahdt", "ahst", "akdt", "akst", "aktst", "aktt", "almst", "almt", "amst", "amt", "anast", "anat", "ant", "apt", "aqtst", "aqtt", "arst", "art", "ashst", "asht", "ast", "awt", "azomt", "azost", "azot", "azst", "azt", "bakst", "bakt", "bdst", "bdt", "beat", "beaut", "bmt", "bnt", "bortst", "bort", "bost", "bot", "brst", "brt", "bst", "btt", "burt", "cant", "capt", "cast", "cat", "cawt", "cddt", "cdt", "cemt", "cest", "cet", "cgst", "cgt", "chadt", "chast", "chat", "chdt", "chost", "chot", "cit", "cjt", "ckhst", "ckt", "clst", "clt", "cost", "cot", "cpt", "cst", "cvst", "cvt", "cwst", "cwt", "chst", "dact", "davt", "ddut", "dusst", "dust", "easst", "east", "eat", "ect", "eddt", "edt", "eest", "eet", "egst", "egt", "ehdt", "eit", "ept", "est", "ewt", "fjst", "fjt", "fkst", "fkt", "fnst", "fnt", "fort", "frust", "frut", "galt", "gamt", "gbgt", "gest", "get", "gft", "ghst", "gmt", "gst", "gyt", "hadt", "hast", "hdt", "hkst", "hkt", "hovst", "hovt", "hpt", "hst", "hwt", "ict", "iddt", "idt", "ihst", "iot", "irdt", "irkst", "irkt", "irst", "isst", "ist", "javt", "jdt", "jst", "kart", "kast", "kdt", "kgst", "kgt", "kizst", "kizt", "kmt", "kost", "krast", "krat", "kst", "kuyst", "kuyt", "kwat", "lhst", "lint", "lkt", "lont", "lrt", "lst", "madmt", "madst", "madt", "magst", "magt", "malst", "malt", "mart", "mawt", "mddt", "mdst", "mdt", "mest", "met", "mht", "mmt", "most", "mot", "mpt", "msd", "msk", "mst", "mut", "mvt", "mwt", "myt", "ncst", "nct", "nddt", "ndt", "negt", "nest", "net", "nft", "novst", "novt", "npt", "nrt", "nst", "nut", "nwt", "nzdt", "nzmt", "nzst", "omsst", "omst", "orast", "orat", "pddt", "pdt", "pest", "petst", "pett", "pet", "phot", "phst", "pht", "pkst", "pkt", "pmdt", "pmst", "pmt", "ppt", "pst", "pwt", "pyst", "pyt", "qyzst", "qyzt", "ret", "rmt", "rott", "sakst", "sakt", "samst", "samt", "sast", "sbt", "sct", "sgt", "shest", "shet", "slst", "smt", "srt", "sst", "stat", "svest", "svet", "syot", "taht", "tasst", "tast", "tbist", "tbit", "tft", "tjt", "tlt", "tmt", "tost", "tot", "trst", "trt", "tsat", "ulast", "ulat", "urast", "urat", "urut", "uyhst", "uyst", "uyt", "uzst", "uzt", "vet", "vlasst", "vlast", "vlat", "volst", "volt", "vost", "vust", "vut", "warst", "wart", "wast", "wat", "wemt", "west", "wet", "wgst", "wgt", "wit", "wst", "yakst", "yakt", "yddt", "ydt", "yekst", "yekt", "yerst", "yert", "ypt", "yst", "ywt", "a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "utc", "u", "v", "w", "x", "y", "zzz", "z"];
	  }

	  if (!php_js_shared.tz_offsets) {
	    php_js_shared.tz_offsets = [-43200, -41400, -39600, -37800, -36000, -34200, -32400, -28800, -25200, -21600, -19800, -18000, -16966, -16200, -14400, -14308, -13500, -13252, -13236, -12756, -12652, -12600, -10800, -9052, -9000, -7200, -5400, -3996, -3600, -2670, -1200, 0, 1172, 1200, 2079, 3600, 4772, 4800, 5736, 5784, 5940, 6264, 7200, 9000, 9048, 9384, 9885, 10800, 12344, 12600, 12648, 14400, 16200, 16248, 18000, 19800, 20700, 21600, 23400, 25200, 25580, 26240, 26400, 27000, 28656, 28800, 30000, 30600, 31500, 32400, 34200, 35100, 36000, 37800, 39600, 41400, 43200, 45000, 45900, 46800, 49500, 50400];
	  }

	  if (!php_js_shared.tz_prefixes) {
	    php_js_shared.tz_prefixes = ['Africa', 'America', 'America/Argentina', 'America', 'America/Indiana', 'America', 'America/Kentucky', 'America', 'America/North_Dakota', 'America', 'Antarctica', 'Arctic', 'Asia', 'Atlantic', 'Australia', 'Brazil', 'Canada', 'Chile', 'Europe', 'Indian', 'Mexico', 'Pacific'];
	  }
	  // END STATIC

	  //var dtz = this.date_default_timezone_get();
	  for (i = 0, len = php_js_shared.tz_abbrs.length; i < len; i++) {
	    indice = php_js_shared.tz_abbreviations[i];
	    curr = php_js_shared.tz_abbrs[i];
	    list[indice] = [];
	    for (j = 0, jlen = curr.length; j < jlen; j++) {
	      currSub = curr[j];
	      currSubPrefix = (currSub[3] ? php_js_shared.tz_prefixes[currSub[3]] + '/' : '');
	      timezone_id = currSub[2] ? (currSubPrefix + currSub[2]) : null;
	      tzo = php_js_shared.tz_offsets[currSub[1]];
	      dst = !! currSub[0];
	      list[indice].push({
	        'dst': dst,
	        'offset': tzo,
	        'timezone_id': timezone_id
	      });
	      // if (dtz === timezone_id) { // Apply this within date functions
	      //     this.php_js.currentTimezoneOffset = tzo;
	      //     this.php_js.currentTimezoneDST = dst;
	      // }
	    }
	  }

	  return list;
}

function date_default_timezone_get () {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Brett Zamir (http://brett-zamir.me)
	  // -    depends on: timezone_abbreviations_list
	  // %        note 1: Uses global: php_js to store the default timezone
	  // *     example 1: date_default_timezone_get();
	  // *     returns 1: 'unknown'
	  var tal = {},
	    abbr = '',
	    i = 0,
	    curr_offset = -(new Date()).getTimezoneOffset() * 60;

	  if (this.php_js) {
	    if (this.php_js.default_timezone) { // set by date_default_timezone_set
	      return this.php_js.default_timezone;
	    }
	    if (this.php_js.ENV && this.php_js.ENV.TZ) { // getenv
	      return this.php_js.ENV.TZ;
	    }
	    if (this.php_js.ini && this.php_js.ini['date.timezone']) { // e.g., if set by ini_set()
	      return this.php_js.ini['date.timezone'].local_value ? this.php_js.ini['date.timezone'].local_value : this.php_js.ini['date.timezone'].global_value;
	    }
	  }
	  // Get from system
	  tal = this.timezone_abbreviations_list();
	  for (abbr in tal) {
	    for (i = 0; i < tal[abbr].length; i++) {
	      if (tal[abbr][i].offset === curr_offset) {
	        return tal[abbr][i].timezone_id;
	      }
	    }
	  }
	  return 'UTC';
}

function date_default_timezone_set (tz) {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Brett Zamir (http://brett-zamir.me)
	  // -    depends on: timezone_abbreviations_list
	  // %        note 1: Uses global: php_js to store the default timezone
	  // *     example 1: date_default_timezone_set('unknown');
	  // *     returns 1: 'unknown'
	  var tal = {},
	    abbr = '',
	    i = 0;

	  // BEGIN REDUNDANT
	  this.php_js = this.php_js || {};
	  // END REDUNDANT
	  // PHP verifies that the timezone is valid and also sets this.php_js.currentTimezoneOffset and this.php_js.currentTimezoneDST if so
	  tal = this.timezone_abbreviations_list();
	  for (abbr in tal) {
	    for (i = 0; i < tal[abbr].length; i++) {
	      if (tal[abbr][i].timezone_id === tz) {
	        this.php_js.default_timezone = tz;
	        return true;
	      }
	    }
	  }
	  return false;
}

function strtoupper(str) {
	  //  discuss at: http://phpjs.org/functions/strtoupper/
	  // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // improved by: Onno Marsman
	  //   example 1: strtoupper('Kevin van Zonneveld');
	  //   returns 1: 'KEVIN VAN ZONNEVELD'

	  return (str + '')
	    .toUpperCase();
}