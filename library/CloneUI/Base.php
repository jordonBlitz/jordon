<?php
/**
 * CloneUI.com - CloneUI.com Base Framework
 * Core Library
 *
 * @author      CloneUI <hire@bizlogicdev.com>
 * @copyright   2012 CloneUI
 * @link        http://bizlogicdev.com
 * @license     Commercial
 *
 * @since  	    Tuesday, November 27, 2012, 04:39 PM GMT+1
 * @modified    $Date: 2014-04-29 16:28:16 -0700 (Tue, 29 Apr 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Base.php 38 2014-04-29 23:28:16Z hire@bizlogicdev.com $
 *
 * @category    Core Library
 * @package     CloneUI.com Base Framework
 */

class CloneUI_Base
{
    /**
     * fetch site configuration from the DB
     *
     * @return  array
     */
    public function fetchSiteConfig()
    {
        $data   = array();

        $sql    = "SELECT * FROM `".DB_TABLE_PREFIX."site_config` ";
        $res    = mysql_query( $sql ) OR die( mysql_error() );

        if( mysql_num_rows( $res ) > 0 ) {
            while( $row = mysql_fetch_assoc( $res ) ) {
                $data[] = $row;
            }
        }

        return $data;
    }

    /**
     * define site configuration
     */
    public function defineSiteConfig()
    {
        $config = $this->fetchSiteConfig();

        if( !empty( $config ) ) {
            foreach( $config AS $key => $value ) {
                define( strtoupper( $value['name'] ), $value['value'] );
            }
        }
    }
}