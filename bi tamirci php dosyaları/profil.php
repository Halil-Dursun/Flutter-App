<?php
     $id = $_POST["id"];
     $VeritabaniBaglantisi = mysqli_connect("localhost","root","","bitamircideneme");
     mysqli_set_charset($VeritabaniBaglantisi,"UTF8");

     if(mysqli_connect_errno()){
         echo "Veritabanına Bağlanılamadı.<br />";
         echo "Hata Açıklaması : " . mysqli_connect_error();
         die();
     }
     $array = array();
     $Sorgu = mysqli_query($VeritabaniBaglantisi,"SELECT * FROM login WHERE id=" . $id);

     if($Sorgu){
         while($Kayit = mysqli_fetch_assoc($Sorgu)){
             $array[] = $Kayit;
         }

         echo json_encode($array);
     }else{
         echo "Sorgu Hatası";
     }


     mysqli_close($VeritabaniBaglantisi);
?>