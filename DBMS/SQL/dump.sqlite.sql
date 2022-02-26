-- TABLE
CREATE TABLE congviec (idcv integer primary key, tencv varchar(20));
CREATE TABLE nhanvien (idnv integer primary key, tennv varchar(20) );
CREATE TABLE thamgia (idnv integer, idcv varchar(20), other varchar(20),
                    CONSTRAINT fk_tg_id_nv FOREIGN KEY (idnv) REFERENCES nhanvien (idnv), 
                     CONSTRAINT fk_tg_id_cv FOREIGN KEY (idcv) REFERENCES congviec (idcv));
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
 
INSERT INTO nhanvien VALUES(1, "nv1"),(2, "nv2"),(3, "nv3"),(4, "nv4")
INSERT INTO thamgia VALUES(1, 1, "TG11")
,(1, 2, "TG12")
,(1, 3, "TG13")
,(1, 4, "TG14")
,(1, 5, "TG15")
,(2, 1, "TG21")
,(2, 5, "TG25")
,(3, 1, "TG31")
,(3, 2, "TG32")
,(3, 3, "TG33")
,(3, 4, "TG34")
,(3, 5, "TG35")
,(4, 1, "TG41")
,(4, 4, "TG44")

select nv.idnv
FROM nhanvien as nv
WHERE not EXISTS (
  SELECT cv.idcv
  FROM congviec as cv
  WHERE not EXISTS (
	select tg.idcv
	FROM thamgia as tg
  	WHERE nv.idnv = tg.idnv AND cv.idcv = tg.idcv
  )
)

SELECT cv.idcv
  FROM congviec as cv
  WHERE not EXISTS (
	select tg.idcv
	FROM thamgia as tg
  	WHERE cv.idcv = tg.idcv
  )

  SELECT nv.idnv
  FROM nhanvien as nv
  WHERE not EXISTS (
	select tg.idnv
	FROM thamgia as tg
  	WHERE cv.idnv = tg.idnv
  )