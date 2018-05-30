<?php
require __DIR__ . '/vendor/autoload.php';
use Mike42\Escpos\Printer;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
try {

  $servername = "localhost";
  $username = "root";
  $password = "";
  $dbname = "ut_pos";

  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  $conn2 = new mysqli($servername, $username, $password, $dbname);

  // Check connection
  if ($conn->connect_error) {
      die("Connection failed: " . $conn->connect_error);
  }
  if ($conn2->connect_error) {
        die("Connection failed: " . $conn2->connect_error);
  }

  $invoice = isset($_POST['invoice']) ? $_POST['invoice'] : null;
  var_dump($_REQUEST);
  print_r($invoice); exit;
  $toko = mysqli_query($conn,
        "CALL sp_gettoko()") or die("Query fail: " . mysqli_error());

  $transaksi = mysqli_query($conn2,
       "CALL sp_getprint($invoice)") or die("Query fail: " . mysqli_error());
  
  //$transaksi = mysqli_prepare($conn, 'call sp_getprint(?)');
   // mysqli_stmt_bind_param($transaksi, 's', $invoice);
   // mysqli_stmt_execute($transaksi);
   // mysqli_stmt_store_result($transaksi);
	//var_dump($transaksi)
    //$result = mysqli_get_result($transaksi);

	//$transaksi = $conn->prepare('CALL sp_getprint(?,@barang_name,@transaksi_jumlah,@transaksi_total)');
	//$transaksi->bind_param('s', $invoice);
	//$transaksi->execute();
  
    // Enter the share name for your USB printer here
    $connector = new FilePrintConnector("Receipt Printer");
    $printer = new Printer($connector);

    while ($row = mysqli_fetch_array($toko)){
        $printer -> setEmphasis(true);
        $printer -> text($row[1] . "\n");
        $printer -> setEmphasis(false);
        $printer -> feed();
        $printer -> text($row[2] . "\n");
        $printer -> feed(4);
        $printer -> text("==============================\n");
    }

    while ($row = mysqli_fetch_array($transaksi)){
        $printer -> setJustification(Printer::JUSTIFY_LEFT);
        $printer -> text($row[0]);
        $printer -> setJustification(Printer::JUSTIFY_CENTER);
        $printer -> text($row[1]);
        $printer -> setJustification(Printer::JUSTIFY_RIGHT);
        $printer -> text($row[2] . "\n");
    }

    $printer -> cut();
    $printer -> pulse(0);
    $printer -> close();
    $conn->close();
    $conn2->close();
	
} catch(Exception $e) {
    echo "Couldn't print to this printer: " . $e -> getMessage() . "\n";
}
