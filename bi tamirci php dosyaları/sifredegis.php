<?php
     $id = $_POST["id"];
     $password1 = $_POST["password1"];
     $newpass = $_POST["newpass"];

     $VeritabaniBaglantisi = mysqli_connect("localhost","root","","bitamircideneme");
     mysqli_set_charset($VeritabaniBaglantisi,"UTF8");
     if(mysqli_connect_errno()){
         echo "Veritabanı Bağlantı Hatası<br />";
         echo "Hata Açıklaması : ". mysqli_connect_error();
         die();
     }
     $Sorgu = mysqli_query($VeritabaniBaglantisi,"SELECT * FROM login WHERE id='".$id."' AND password='".$password1."'");
     $Kayit = mysqli_num_rows($Sorgu);

     if($Kayit == 1){
        $update = mysqli_query($VeritabaniBaglantisi,"UPDATE login SET password='".$newpass."' WHERE id=" . $id);
        if($update){
            echo json_encode("Succes");
        }
     }else{
        echo json_encode("Error");
     }

     mysqli_close($VeritabaniBaglantisi);
?>