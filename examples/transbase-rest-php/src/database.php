<?php
class Database{

    private $dbid = null;
 
    public function __construct($host,$port,$db_name,$username,$password){
        $this->dbid = trans_db_open ( "//" . $host . ":" . $port . "/" . $db_name, $username, $password );
        if ( $dbid < 0 )
        {
            echo trans_tbx_error ();
        }
    }

    public function close(){
        if(trans_db_close() < 0)
        {
            echo trans_tbx_error ();
        }
    }

    public function execute($query){
        $quid = trans_sql_open ($query);
        $result = null;
        if ( $quid >= 0 ) {
            $result = array();
            while ( trans_sql_fetch () > 0 ) 
            {
                $row = array();
                $index = 0;
                while( $index < trans_field_count () )
                {
                    $name = trans_field_name($index);
                    $value = trans_field_string($index);
                    $row[$name] = $value;
                    $index++;  
                }
                $result[count($result)] = $row;
            }
            trans_sql_close ();
        }
        else{
            echo trans_tbx_error();
        }
        return $result;
    }
}
?>