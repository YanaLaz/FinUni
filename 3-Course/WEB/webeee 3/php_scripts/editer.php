<?php
    $data = $_POST['data'];
    $address = $_POST['address'];
    file_put_contents($address, $data );
    $num ++;
?>