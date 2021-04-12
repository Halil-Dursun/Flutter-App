<?php
     $username = $_POST["username"];
     $email = $_POST["email"];

     $VeritabaniBaglantisi = mysqli_connect("localhost","root","","bitamircideneme");
     mysqli_set_charset($VeritabaniBaglantisi,"UTF8");
     if(mysqli_connect_errno()){
         echo "Veritabanına bağlantı sağlnamadı";
         echo "Hata açıklaması : " . mysqli_connect_error();
         die();
     }

     $Sorgu = mysqli_query($VeritabaniBaglantisi,"SELECT * FROM login WHERE username='".$username."' AND email='".$email."'");

     if($Sorgu){
        $KayitSayisi = mysqli_num_rows($Sorgu);
        $Kayit = mysqli_fetch_assoc($Sorgu);
        $id = $Kayit["id"];
        $yeniSifre = rand(11111,99999);
        if($KayitSayisi==1){
            $update = mysqli_query($VeritabaniBaglantisi,"UPDATE login SET password='".$yeniSifre."' WHERE id=" . $id);
            if($update){
                echo json_encode($yeniSifre);
            }
        }else{
            echo json_encode("Error");
        }
     }else{
         echo "Sorgu Hatası";
     }


?>