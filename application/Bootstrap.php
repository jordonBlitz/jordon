<?php
/**
 * Jordon
 * Bootstrap
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License
 *
 * @since       Thursday, April 21, 2011 / 01:04 AM GMT+1
 * @edited      $Date: 2014-08-07 04:36:13 +0200 (Thu, 07 Aug 2014) $
 * @version     $Id: Bootstrap.php 52 2014-08-07 02:36:13Z bizlogic $
 *
 * @category    Bootstrap
 * @package     Jordon
*/

set_time_limit( 0 );
date_default_timezone_set('UTC');

// common functions
require_once('functions.php');

// global constants
require_once('constants.php');

// set after getting constants
ini_set('error_log', LOG_DIR.'/php-errors-'.date('m-d-Y').'.log');

require_once('Zend/Loader/Autoloader.php');
$Zend_Loader_Autoloader = Zend_Loader_Autoloader::getInstance();
$Zend_Loader_Autoloader->setFallbackAutoloader( true );

// randlib
require_once('randlib.class.php');

// PHPMailer
require_once('PHPMailer/PHPMailerAutoload.php');

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    private $_CloneUI_Cache;

    /*
     * Bootstrap constructor
     *
     * @param   string  $env    application environment
     */
    public function __construct( $env )
    {   	    	
    	$this->_setupSession();
    	$this->_setupFirePHP();
    	$this->_checkInstall();
    	$this->_setRunEnv();   
    	$this->_setupRunEnv(); 	
    	$this->_checkFolderPerms();
    	$this->_setupDB();
    	$this->_setupDoctrineDBAL();
        $this->_CloneUI_Cache = new CloneUI_Cache;
        $this->_setupLocale();
        $this->_setupCache();
        $this->_setupSiteConfig();
        $this->_setupLanguage();
        $this->_setupThemes();
        // cleanup
        $this->_cleanup();
        $this->_updateUserSession();
        $this->_checkUpgrade();
    }
    
    private function _checkInstall()
    {
    	if( file_exists( BASEDIR.'/install' ) ) {
    		if( !file_exists( BASEDIR.'/install/install.lock' ) ) {
    			header('Location: '.BASEURL.'/install');    			
    		}	
    	}	
    }
    
    private function _checkUpgrade()
    {
    	$allowedPaths = array(
    		'ajax',
    		'login',
			'upgrade',
    		'users'
    	);
    	
    	$allowed = false;
    	if( file_exists( BASEDIR.'/data/temp/.upgrade' ) ) {
    		foreach( $allowedPaths AS $key => $value ) {
    			if( preg_match('/'.$value.'/', $_SERVER['REQUEST_URI'] ) ) {
    				$allowed = true;
    			}    			
    		}
    		
    		if( !$allowed ) {
    			header('Location: '.BASEURL.'/upgrade');
    		}
    	}    	
    }
    
    private function _checkFolderPerms()
    {
    	$errors		= array();    	
    	$required	= array();
    	$required[]	= BASEDIR.'/data';
    	$required[]	= BASEDIR.'/data/cache';
    	$required[]	= BASEDIR.'/data/logs';
    	$required[]	= BASEDIR.'/data/sessions';
    	$required[]	= BASEDIR.'/data/temp';
    	$required[]	= BASEDIR.'/data/uploads';
    	$required[]	= BASEDIR.'/data/uploads/users';    	
    	$errors		= array();
    	
    	foreach( $required AS $key => $value ) {
    		if( !is_writeable( $value ) ) {
				$errors[] = $value;    			
    		}	
    	}
    	
    	if( !empty( $errors ) ) {
    		$errorMessage = 'The following file permission errors are preventing the application from functioning properly:<ol type="">';    		
    		foreach( $errors AS $key => $value ) {
    			$errorMessage .= '<li>'.$value.' is not writeable. chmod it to 0777</li>'; 
    		}    		
    		
    		$errorMessage .= '</ol>';
    		
    		exit( $errorMessage );
    	}
    }

    private function _setupThemes()
    {
    	global $SITE_THEMES;
    	global $BOOTSTRAP_THEMES;
    	
    	$CloneUI_Site_Theme	= new CloneUI_Site_Theme;
    	$SITE_THEMES			= $CloneUI_Site_Theme->fetchThemesForDisplay();
    	$BOOTSTRAP_THEMES		= $CloneUI_Site_Theme->fetchBootstrapThemesForDisplay();
    }
    
    private function _setupSessionParams()
    {
        // until the end of time...
        // @link	http://en.wikipedia.org/wiki/Year_2038_problem
        if( !defined( 'COOKIE_TIMEOUT' ) ) {
            define( 'COOKIE_TIMEOUT', 2147483647 );
        }

        if( !defined( 'GARBAGE_TIMEOUT' ) ) {
            define( 'GARBAGE_TIMEOUT', COOKIE_TIMEOUT );
        }

        ini_set( 'session.gc_maxlifetime', GARBAGE_TIMEOUT );
        session_set_cookie_params( COOKIE_TIMEOUT, '/' );

        // setting session dir
        if( isset( $_SERVER['HTTP_HOST'] ) ) {
            $sessdir = '/tmp/'.$_SERVER['HTTP_HOST'];
        } else {
            $sessdir = '/tmp/jordon';
        }

        // if session dir not exists, create directory
        if( !is_dir( $sessdir ) ) {
            @mkdir( $sessdir, 0777 );
        }

        //if directory exists, then set session.savepath otherwise let it go as is
        if( is_dir( $sessdir ) ) {
            ini_set( 'session.save_path', $sessdir );
        }
    }

    private function _setupSiteConfig()
    {
        $CloneUI_Site_Config = new CloneUI_Site_Config;
        $CloneUI_Site_Config->defineSiteConfig();
    }

    private function _setupSession()
    {
        $this->_setupSessionParams();

        if( !isset( $_SESSION ) ) {
            session_start();
        }

        setInitialSessionValues();        
    }

    /**
     * setup Zend_Cache
     *
     * @link    http://framework.zend.com/manual/en/zend.cache.introduction.html
     * @todo    move cache lifetime to ini file
     */
    private function _setupCache()
    {
        $this->_CloneUI_Cache->setupCache( 86400, 'cache' );
        $this->_CloneUI_Cache->setupCache( 3600, 'cacheOneHour' );
        $this->_CloneUI_Cache->setupCache( 900, 'cacheFifteenMin' );
    }

    /**
     * Setup a DB connection
    */
    protected function _setupDB()
    {
    	// DB
    	require_once('MysqliDb.php');
    	
    	$config	= new Zend_Config_Ini( APP_DIR.'/configs/db.ini', strtolower( RUN_ENV ) );
    	$db		= $config->params->toArray();
    	
    	// save
    	Zend_Registry::set( 'dbConfig', $db );
    	
    	// define DB table prefix
    	define( 'DB_TABLE_PREFIX', $db['table_prefix'] );
    	
    	$mysql		= mysql_connect( $db['host'], $db['username'], $db['password'] ) OR die( mysql_error() );
    	$mysqldb	= mysql_select_db( $db['dbname'], $mysql ) OR die( mysql_error() );
    	
    	// set charset
    	mysql_set_charset( $db['charset'], $mysql );

    	// START:	testing...
    	try {
    		$mysql = new Mysqlidb( $db['host'], $db['username'], $db['password'], $db['dbname'] );
    		$mysql->setPrefix( DB_TABLE_PREFIX );
    		Zend_Registry::set( 'dbAdapter', $mysql );
    	} catch ( Exception $e ) {
    		echo '<pre>';
 			echo $e->getMessage().'<br>'.$e->getTraceAsString().'<br>';
 			while( $e = $e->getPrevious() ) {
 				echo 'Caused by: '.$e->getMessage().'<br>'.$e->getTraceAsString().'<br>'; 				
 			}

    		debug_print_backtrace();
    		
    		exit;
    	}
    	// END:		testing...    	
    } 

    protected function _setupDoctrineDBAL()
    {
    	$dbConfig = Zend_Registry::get( 'dbConfig' );
    	
    	$doctrineConfig = new \Doctrine\DBAL\Configuration();
    	$connectionParams = array(
    		'dbname'		=> $dbConfig['dbname'],
    		'user' 			=> $dbConfig['username'],
    		'password' 		=> $dbConfig['password'],
    		'host' 			=> $dbConfig['host'],
    		'driver' 		=> $dbConfig['driver'],
			'charset'		=> $dbConfig['charset'],
    		'driverOptions' => $dbConfig['driver_options'] 			
    	);
    	
    	$dbConnection = \Doctrine\DBAL\DriverManager::getConnection( $connectionParams, $doctrineConfig );
    	
    	// save
    	Zend_Registry::set( 'db', $dbConnection );
    }

    protected function _setupLocale()
    {
        $_SESSION['user']['locale'] = determineUserLocale();
    }

    protected function _setupLanguage()
    {        
    	global $SITE_LANGUAGES; 
	   	
        $CloneUI_Language	= new CloneUI_Language();
        $SITE_LANGUAGES		= $CloneUI_Language->fetchActiveLanguages();
        
        if( isset( $_SESSION['user']['lang_override'] ) ) {
        	if( $_SESSION['user']['lang_override'] ) {
        		$_SESSION['user']['language_id'] = $_SESSION['user']['selected_lang_id'];
        	}	
        }
        
        // we merge the default language w/ the detected language, in case 
        // phrases do not exist in the detected language
        // @TODO:	there should be no merge if the selected language matches the site default
        $siteDefaultLanguageId = $CloneUI_Language->fetchLanguageIdByIso31661( SITE_DEFAULT_LANGUAGE );
        
        if( !@$_SESSION['user']['lang_override'] ) {
        	$_SESSION['user']['language_id'] = (int)$CloneUI_Language->fetchLanguageIdByLocale( $_SESSION['user']['locale'] );
        	$_SESSION['user']['language_id'] = ( $_SESSION['user']['language_id'] == 0 ) ? $siteDefaultLanguageId : $_SESSION['user']['language_id'];
        	$_SESSION['user']['site_language'] = $_SESSION['user']['language_id']; 
        } else {
        	$_SESSION['user']['language_id']	= ( (int)$_SESSION['user']['language_id'] == 0 ) ? $siteDefaultLanguageId : $_SESSION['user']['language_id'];
        	$_SESSION['user']['site_language']	= $_SESSION['user']['language_id'];
        }
        
        $siteDefaultPhrases				= $CloneUI_Language->fetchPhrasesByLanguageId( $siteDefaultLanguageId );
        $_SESSION['site']['phrases']	= $CloneUI_Language->fetchPhrasesByLanguageId( $_SESSION['user']['language_id'] );
        
        if( $_SESSION['user']['language_id'] != $siteDefaultLanguageId ) {
        	$_SESSION['site']['phrases'] = array_merge( $siteDefaultPhrases, $_SESSION['site']['phrases'] );
        }
    }

    protected function _setRunEnv()
    {
        $env = determineRunEnvironment();
        setRunEnvironment( $env );

        Zend_Registry::set( 'RUN_ENV', $env );
    }
    
    protected function _setupRunEnv()
    {    	
    	$config		= new Zend_Config_Ini( APP_DIR.'/configs/php.ini', strtolower( RUN_ENV ) );
    	$phpConfig	= $config->toArray();
    	
		if( !empty( $phpConfig ) ) {
			foreach( $phpConfig AS $key => $value ) {
				switch( $key ) {
					case 'error_reporting':
						error_reporting( $value );
						break;
						
					default:
						ini_set( $key, $value );	
				}	
			}	
		}
    }
    
    protected function _updateUserSession()
    {    	 	
    	// we want to update the user session on every page hit
    	
    	$skip = array(
    		'ajax',
    		'login',
    		'logout'
    	);
    	 
    	$shouldSkip = array();
		foreach( $skip AS $key => $value ) {
    		if( !preg_match('/'.$value.'/', $_SERVER['REQUEST_URI'] ) ) {
    			$shouldSkip[] = 0;
    		} else {
    			$shouldSkip[] = 1;	
    		}
    	}
    	
    	if( array_sum( $shouldSkip ) == 0 ) {
    		$_SESSION['last_url'] = '//'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
    	}
    	
    	$CloneUI_User = new CloneUI_User();		
    	$CloneUI_User->updateUserSession();
    	if( !isset( $_COOKIE['theme'] ) ) {
    		setcookie( 'theme', SITE_DEFAULT_TEMPLATE, SITE_COOKIE_EXPIRATION_DATE, SITE_COOKIE_PATH );    		
    	}

    	if( @$_SESSION['user']['logged_in'] ) {
    		if( empty( $_SESSION['site']['permissions'] ) ) {
    			$this->noPerms();
    		}    		
    	}

		$siteStatus = @$_SESSION['user']['site_status'];
		switch( $siteStatus ) {
			case 'banned':
				$html = file_get_contents( VIEWS_DIR.'/error/static/error.phtml' );
				$html = str_replace( '__SITE_NAME__', SITE_NAME, $html );
				$html = str_replace( '__ERROR_MESSAGE__', 'Your user account is banned', $html );
				$html = str_replace( '__THEME_PATH__', PROTOCOL_RELATIVE_URL.'/'.SITE_LOCAL_THEME_URL_ROOT.'/'.SITE_DEFAULT_TEMPLATE, $html );
				$html = str_replace( '__JS_PATH__', PROTOCOL_RELATIVE_URL.'/js', $html );
				
				exit( $html );
				
				break;
				
			case 'pending':				
				$html = file_get_contents( VIEWS_DIR.'/error/static/error.phtml' );
				$html = str_replace( '__SITE_NAME__', SITE_NAME, $html );
				$html = str_replace( '__ERROR_MESSAGE__', 'Please check your e-mail for information on how to activate your account', $html );
				$html = str_replace( '__THEME_PATH__', PROTOCOL_RELATIVE_URL.'/'.SITE_LOCAL_THEME_URL_ROOT.'/'.SITE_DEFAULT_TEMPLATE, $html );
				$html = str_replace( '__JS_PATH__', PROTOCOL_RELATIVE_URL.'/js', $html );
								
				exit( $html );				

				break;
		}
		
		if( !has_permission('can_view_site') ) {
			$allowedPaths = array(
				'ajax',
				'login',
				'upgrade',
				'users'
			);
			 
			$allowed = false;
			
			foreach( $allowedPaths AS $key => $value ) {
				if( preg_match('/'.$value.'/', $_SERVER['REQUEST_URI'] ) ) {
					$allowed = true;
				}
			}
			
			if( !$allowed ) {
				if( (int)$_SESSION['user']['logged_in'] != 1 ) {
					header('Location: '.BASEURL.'/login');
				} else {
					exit('Your account does not have permission to access this site');
				}
			}	
		}
    }
    
    protected function _setupFirePHP()
    {    	
    	if( (int)ENABLE_FIREPHP == 1 ) {
    		if( has_permission('can_use_firephp') ) {    			
    			require_once('FirePHP/FirePHP.class.php');
    			$firephp = FirePHP::getInstance( true );
    			require_once('FirePHP/fb.php');
    			 
    			$firephp->setEnabled( true );    			
    			$firephp->registerErrorHandler( $throwErrorExceptions = false );
    			$firephp->registerExceptionHandler();
    			$firephp->registerAssertionHandler(
    				$convertAssertionErrorsToExceptions = true,
    				$throwAssertionExceptions = false
				);
    			 
    			// START:	FirePHP
    			$firebugWriter = new Zend_Log_Writer_Firebug();
    			$firebugLogger = new Zend_Log( $firebugWriter );
    			Zend_Registry::set( 'firebugLogger', $firebugLogger );
    			// END:		FirePHP    	
    		} 		
    	}    	
    }
    
    protected function noPerms()
    {
		define( 'NO_SITE_PERMS', true );		
		$_SESSION['user']['logged_in'] = false;	

		$html = file_get_contents( VIEWS_DIR.'/error/static/error.phtml' );
		$html = str_replace( '__SITE_NAME__', SITE_NAME, $html );
		$html = str_replace( '__ERROR_MESSAGE__', 'Your account has not been granted permissions for this site', $html );
		$html = str_replace( '__THEME_PATH__', PROTOCOL_RELATIVE_URL.'/'.SITE_LOCAL_THEME_URL_ROOT.'/'.SITE_DEFAULT_TEMPLATE, $html );
		$html = str_replace( '__JS_PATH__', PROTOCOL_RELATIVE_URL.'/js', $html );
		$html = str_replace( '__PROTOCOL_RELATIVE_URL__', PROTOCOL_RELATIVE_URL, $html );
		$html = str_replace( '__SITE_DEFAULT_PRELOADER_IMAGE_PATH__', SITE_DEFAULT_PRELOADER_IMAGE_PATH, $html );
		
		exit( $html );
    }
    
    protected function _cleanup()
    {
    	$minute = date('i');
    	$minute = (int)$minute;
    	if( $minute >= 58 ) {
    		remove_old_files( BASEDIR.'/data/temp', '-6 hours' );
    		remove_old_files( BASEDIR.'/data/logs', '-5 days' );
    	}    	
    }
   
    public function run()
    {      		    	
        $front = Zend_Controller_Front::getInstance();
        $front->throwExceptions( false );
        try {       
	        $front->setControllerDirectory(
	        	array('default' => PATH.'/application/modules/public/controllers')
	        );
	        
	        $front->setParam( 'useDefaultControllerAlways', false );
	        $front->setParam( 'displayExceptions', true );
            $front->dispatch();
        } catch( Exception $e ) {
            $request = $front->getRequest();            
            $request->setModuleName('default');
            $request->setControllerName('error');
            $request->setActionName('error');

            $error              = new Zend_Controller_Plugin_ErrorHandler();
            $error->type        = Zend_Controller_Plugin_ErrorHandler::EXCEPTION_OTHER;
            $error->request     = clone($request);
            $error->exception   = $e;
            
            $request->setParam('error_handler', $error);
        }
    }
}