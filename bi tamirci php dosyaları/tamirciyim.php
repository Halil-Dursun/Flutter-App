<?php
     $id = $_POST["id"];
     $job = $_POST["job"];


     $VeritabaniBaglantisi = mysqli_connect("localhost","root","","bitamircideneme");
     mysqli_set_charset($VeritabaniBaglantisi,"UTF8");

     if(mysqli_connect_errno()){
         echo "Veritabanına Bağlanılamadı.<br />";
         echo "Hata Açıklaması : " . mysqli_connect_error();
         die();
     }
     $Sorgu = mysqli_query($VeritabaniBaglantisi,"UPDATE login SET job='$job' WHERE id=" . $id);

     if($Sorgu){
         echo "Güncelleme Başarılı";
     }else{
         echo "Sorgu Hatası";
     }


     mysqli_close($VeritabaniBaglantisi);
?>