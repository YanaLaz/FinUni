<?php
    $dir = opendir('../docs');
    $count = 1;
    while($file = readdir($dir)){
        if($file == '.' || $file == '..' || is_dir('path/to/dir' . $file)){
            continue;
        }
        $count++;
    }
    $num = 0;
    $data = $_POST['data'];
    $fl = "../docs/data".$count.".json";
    file_put_contents($fl, $data );
    $num ++;
?>