<?php
$db = mysqli_connect('localhost','root','','bitamircideneme');
if(!$db){
    echo "Database connection faild";
}else{
    echo "Connection Succesful";
}
$username = $_POST['username'];
$password = $_POST['password'];
$email = $_POST['email'];

$query = "INSERT INTO login(id,username,password,email)VALUES (null,'$username','$password','$email')";

$result = mysqli_query($db,$query);

if($result){
    echo "done";
}else{
    echo "error";
}

?>