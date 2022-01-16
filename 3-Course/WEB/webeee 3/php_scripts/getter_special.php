<?php

$file = $_POST['data']; 

foreach ($rii as $file) {
    if ($file->isDir()){ 
        continue;
    }
    $files[] = $file->getPathname(); 
}

$arr = $files;
echo json_encode($arr)

?>