<?php

$file_to_delete = $_POST['addr'];
unlink($file_to_delete);

echo 'ok'
?>