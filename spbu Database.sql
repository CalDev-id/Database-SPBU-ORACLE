--BUAT TABLE BUS
CREATE TABLE bus (
	IDBus NUMBER(4) NOT NULL PRIMARY KEY,
	NomorPolisi VARCHAR(15),
	Merek VARCHAR(50),
	Kapasitas NUMBER(2)
);

--BUAT TABLE SUPIR
CREATE TABLE supir (
	IDSupir NUMBER(4) NOT NULL PRIMARY KEY,
	NIKUNIQUE VARCHAR(16) UNIQUE,
	Nama VARCHAR(100),
	TglLahir DATE,
	TglMulaiBekerja DATE,
	TglKadaluarsaSIM DATE,
	NoHP VARCHAR(50)
);

--BUAT TABLE JADWAL
CREATE TABLE jadwal (
	IDJadwal NUMBER(5) NOT NULL PRIMARY KEY,
	IDBus NUMBER(4),
	IDSupir NUMBER(4),
	TglWkt_Berangkat TIMESTAMP,
	TglWkt_Tiba TIMESTAMP,
	Dari VARCHAR(100),
	Tujuan VARCHAR(100),
	CONSTRAINT bus_fk FOREIGN KEY(IDBus) REFERENCES bus(IDBus),
	CONSTRAINT supir_fk FOREIGN KEY(IDSupir) REFERENCES supir(IDSupir)
);

--BUAT TABLE KARYAWAN
CREATE TABLE karyawan (
	IDKaryawan NUMBER(4) NOT NULL PRIMARY KEY,
	NIKUNIQUE VARCHAR(16) UNIQUE,
	Nama VARCHAR(100),
	TglLahir DATE,
	TglMulaiBekerja DATE,
	NoHP VARCHAR(50)
);

--BUAT TABLE PELANGGAN
CREATE TABLE pelanggan (
	IDPelanggan NUMBER(5) NOT NULL PRIMARY KEY,
	NIKUNIQUE VARCHAR(16) UNIQUE,
	Nama VARCHAR(100),
	NoHP VARCHAR(50)
);

--BUAT TABLE TIKET
CREATE TABLE tiket (
	IDTiket NUMBER(5) NOT NULL PRIMARY KEY,
	IDJadwal NUMBER(5),
	IDKaryawan NUMBER(4),
	IDPelanggan NUMBER(5),
	TglWkt_Beli TIMESTAMP,
	CONSTRAINT jadwal_fk FOREIGN KEY(IDJadwal) REFERENCES jadwal(IDJadwal),
	CONSTRAINT karyawan_fk FOREIGN KEY(IDKaryawan) REFERENCES karyawan(IDKaryawan),
	CONSTRAINT pelanggan_fk FOREIGN KEY(IDPelanggan) REFERENCES pelanggan(IDPelanggan)
);


-- AUTO INCREMENT FOR INSERT 

CREATE SEQUENCE bus_seq START WITH 1;

CREATE OR REPLACE TRIGGER bus_on_insert
	BEFORE INSERT ON bus
	FOR EACH ROW 
BEGIN 
	SELECT bus_seq.nextval
	INTO :NEW.IDBus
	FROM dual;
END;

CREATE SEQUENCE supir_seq START WITH 1;

CREATE OR REPLACE TRIGGER supir_on_insert
	BEFORE INSERT ON supir
	FOR EACH ROW 
BEGIN 
	SELECT supir_seq.nextval
	INTO :NEW.IDSupir
	FROM dual;
END;

CREATE SEQUENCE jadwal_seq START WITH 1;

CREATE OR REPLACE TRIGGER jadwal_on_insert
	BEFORE INSERT ON jadwal
	FOR EACH ROW 
BEGIN 
	SELECT jadwal_seq.nextval
	INTO :NEW.IDJadwal
	FROM dual;
END;

CREATE SEQUENCE karyawan_seq START WITH 1;

CREATE OR REPLACE TRIGGER karyawan_on_insert
	BEFORE INSERT ON karyawan
	FOR EACH ROW 
BEGIN 
	SELECT karyawan_seq.nextval
	INTO :NEW.IDKaryawan
	FROM dual;
END;

CREATE SEQUENCE pelanggan_seq START WITH 1;

CREATE OR REPLACE TRIGGER pelanggan_on_insert
	BEFORE INSERT ON pelanggan
	FOR EACH ROW
BEGIN 
	SELECT pelanggan_seq.nextval
	INTO :NEW.IDPelanggan
	FROM dual;
END;

CREATE SEQUENCE tiket_seq START WITH 1;

CREATE OR REPLACE TRIGGER tiket_on_insert
	BEFORE INSERT ON tiket
	FOR EACH ROW 
BEGIN 
	SELECT tiket_seq.nextval
	INTO :NEW.IDTiket
	FROM dual;
END;

--INSERT DATA (INSERT ALL AGAR MUDAH xD)
INSERT ALL
	INTO BUS (NOMORPOLISI, MEREK, KAPASITAS) VALUES ('B 1234 D', 'Mercedes Benz', 50)
	INTO BUS (NOMORPOLISI, MEREK, KAPASITAS) VALUES ('B 1235 D', 'Hino', 50)
	INTO BUS (NOMORPOLISI, MEREK, KAPASITAS) VALUES ('B 1236 D', 'Mercedes Benz', 50)
	INTO BUS (NOMORPOLISI, MEREK, KAPASITAS) VALUES ('B 1237 D', 'Volvo', 50)
SELECT * FROM DUAL;

--INSERT SUPIR
INSERT ALL
    INTO supir(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, TglKadaluarsaSIM, NoHP) VALUES ('1234567712334131', 'Budi', '10-SEP-1990', '15-JUN-2015', '10-APR-2025', '081412345')
    INTO supir(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, TglKadaluarsaSIM, NoHP) VALUES ('1234567712123413', 'Amir', '13-JAN-1990', '13-APR-2015', '11-APR-2025', '0814123312')
    INTO supir(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, TglKadaluarsaSIM, NoHP) VALUES ('1234567753241213', 'Burhan', '17-JUN-1990', '15-JUN-2015', '10-APR-2025', '0814124132')
    INTO supir(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, TglKadaluarsaSIM, NoHP) VALUES ('1234567712541233', 'Yusuf', '15-AUG-1991', '13-APR-2015', '11-APR-2025', '0814123421')
SELECT * from dual;

--UPDATE KAPASITAS DARI BIS BERMEREK MERCEDEZ
UPDATE BUS 
	SET KAPASITAS = 55
WHERE MEREK = 'Mercedes Benz';

--MASUKKAN DATA KARYAWAN
INSERT ALL
    INTO karyawan(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, NoHP) VALUES ('123151341312', 'Mira', '12-MAR-2001', '11-APR-2015', '081321423')
    INTO karyawan(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, NoHP) VALUES ('123151341313', 'Ibnu', '03-FEB-2001', '11-APR-2015', '081325231')
SELECT * from dual;

--MENAMBAHKAN DATA KARYAWAN
INSERT ALL
    INTO karyawan(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, NoHP) VALUES ('321451312314', 'Nia', '04-MAY-2001', '11-APR-2015', '0813421312')
    INTO karyawan(NIKUNIQUE, Nama, TglLahir, TglMulaiBekerja, NoHP) VALUES ('321451312316', 'Irfan', '05-JUL-2001', '11-APR-2015', '0813422112')
SELECT * from dual;

-- INSERT JADWAL
INSERT ALL
    INTO jadwal(IDBus, IDSupir, TglWkt_Berangkat, TglWkt_Tiba, Dari, Tujuan) VALUES (2, 2, '13-MAY-2022', '14-MAY-2022', 'Jakarta', 'Surabaya')
    INTO jadwal(IDBus, IDSupir, TglWkt_Berangkat, TglWkt_Tiba, Dari, Tujuan) VALUES (1, 3, '13-MAY-2022', '14-MAY-2022', 'Jakarta', 'Bandung')
SELECT * from dual;

-- INSERT PELANGGAN
INSERT ALL
	INTO PELANGGAN (NIKUNIQUE, Nama, NoHP) VALUES ('12343213112331', 'Titik', 081413213)
	INTO PELANGGAN (NIKUNIQUE, Nama, NoHP) VALUES ('12344431323312', 'Umar', 08144211)
	INTO PELANGGAN (NIKUNIQUE, Nama, NoHP) VALUES ('12342321113511', 'Andi', 08144412)
SELECT * FROM dual;

--INSERT TIKET
INSERT ALL
	INTO tiket(IDJadwal, IDKARYAWAN, IDPELANGGAN, TGLWKT_BELI) VALUES (1, 1, 1, '10-MAY-2022')
	INTO tiket(IDJadwal, IDKARYAWAN, IDPELANGGAN, TGLWKT_BELI) VALUES (1, 2, 2, '10-MAY-2022')
	INTO tiket(IDJadwal, IDKARYAWAN, IDPELANGGAN, TGLWKT_BELI) VALUES (2, 3, 3, '10-MAY-2022')
SELECT * FROM dual;
	
--HAPUS KARYAWAN IRFAN
DELETE FROM KARYAWAN
	WHERE NAMA = 'Irfan' AND IDKARYAWAN =4;

-- LIHAT IRFAN TELAH HILANG
SELECT * FROM KARYAWAN;

-- JOIN Data Antara Table Jadwal, Supir, dan Bus
SELECT jadwal.IDJadwal, jadwal.IDSupir, jadwal.IDBus, supir.Nama, bus.NomorPolisi, jadwal.TglWkt_Berangkat, jadwal.TglWkt_Tiba, jadwal.Dari, Jadwal.Tujuan FROM jadwal
    JOIN supir ON jadwal.IDSupir = supir.IDSupir 
    JOIN bus ON jadwal.IDBus = bus.IDBus

-- JOIN Data Antara Table Tiket, Pelanggan, Jadwal, dan Karyawan
SELECT tiket.IDTiket, tiket.IDPelanggan, tiket.IDKaryawan, tiket.IDJadwal, pelanggan.Nama, jadwal.Dari, jadwal.Tujuan, karyawan.Nama, tiket.TglWkt_Beli FROM tiket
    JOIN pelanggan ON tiket.IDPelanggan = pelanggan.IDPelanggan
    JOIN jadwal ON tiket.IDJadwal = jadwal.IDJadwal 
    JOIN karyawan ON tiket.IDKaryawan = karyawan.IDKaryawan
