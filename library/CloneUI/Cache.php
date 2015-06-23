<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Class to Extend Zend_Cache
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since       Tuesday, November 27, 2012, 08:00 AM GMT+1 mknox
 * @edited      $Date: 2014-06-13 12:39:33 -0700 (Fri, 13 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Cache.php 55 2014-06-13 19:39:33Z hire@bizlogicdev.com $
 *
 * @package     CloneUI.com Base Framework
*/

class CloneUI_Cache extends Zend_Cache
{
    /**
     * setup Zend_Cache
     *
     * @link    http://framework.zend.com/manual/en/zend.cache.introduction.html
     * @param   int     $lifetime
     * @param   string  $cacheObj
     */
    public function setupCache( $lifetime, $cacheObj )
    {
        $frontendOptions = array(
            'lifetime' => $lifetime,
            'automatic_serialization' => true
        );

        $backendOptions = array('cache_dir' => ROOT_DIR.'/data/cache/');

        $cache = Zend_Cache::factory(   'Core', 'File',
                                        $frontendOptions,
                                        $backendOptions
        );

        Zend_Registry::set( $cacheObj, $cache );
    }
}