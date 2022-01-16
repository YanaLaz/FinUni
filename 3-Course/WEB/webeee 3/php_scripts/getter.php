<?php

$rii = new RecursiveIteratorIterator(new RecursiveDirectoryIterator('../docs'));

$files = array(); 

foreach ($rii as $file) {

    if ($file->isDir()){ 
        continue;
    }

    $files[] = $file->getPathname(); 

}

$arr = $files;
echo json_encode($arr)

?>