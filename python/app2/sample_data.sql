INSERT INTO `tbl_toko` (`toko_id`, `toko_nama`, `toko_alamat`) VALUES
('1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'Baso Apong', 'Jl Surabaya Giri Selatan');

INSERT INTO `tbl_kasir` (`kasir_id`, `kasir_toko_id`, `kasir_name`) VALUES
('c0e08aa2-1257-42ea-ae72-e4ed10ef07c5', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'Amelia Putri'),
('e6c4556c-3c1b-40a1-835d-d4db0f4a6c80', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'Suci Wibisono'),
('f20697fe-27bb-44e7-a769-d8113c1966e3', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'Damang');

INSERT INTO `tbl_barang` (`barang_id`, `barang_toko_id`, `barang_kategori`, `barang_name`, `barang_harga`, `barang_gambar`) VALUES
('7701fbc8-8dd2-48a6-bbc1-fc2d2070d4d6', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'makanan', 'Baso Paket 1', 20000, 'paket1.jpg'),
('d46a4a05-ec36-448a-b6f1-c7cf20872bc2', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'makanan', 'Baso Paket 2', 28000, 'paket2.jpg'),
('cc49ab06-f4a9-4bb3-8dc7-c483fcab7622', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'makanan', 'Baso Paket 3', 29500, 'paket3.jpg'),
('376c2e7e-d017-42e1-ac28-0b1a9aac87ef', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'minuman', 'Es/Panas Teh', 4000, 'teh.jpg'),
('eb6481fc-e28a-41f2-ab47-9f11f225029c', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'minuman', 'Jus', 15000, 'jus.jpg'),
('dfaa3f41-837d-40b7-8270-52255f93cd2f', '1bec741d-e50a-4edc-aee7-e4b611cd9ace', 'minuman', 'Kopi', 12000, 'kopi.jpg');
