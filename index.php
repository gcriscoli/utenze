<?php

require_once 'autoloader.class.php';
$autoloader = new \autoloader ();

$bolletta = new \bolletta (1, null, '123456789', '25/03/2022', '31/03/2022', '1B22', 156.89);

echo $bolletta;

echo serialize($bolletta);
?>
