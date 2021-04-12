<?php
    $db = mysqli_connect('localhost','root','','bitamircideneme');

    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM login WHERE username = '".$username."'AND password ='".$password."'";


    $result = mysqli_query($db,$sql);
    $count = mysqli_num_rows($result);
    $kayit = mysqli_fetch_assoc($result);

    if($count == 1){
        echo json_encode($kayit["id"]);
    }else{
        echo json_encode("Error");
    }



?>