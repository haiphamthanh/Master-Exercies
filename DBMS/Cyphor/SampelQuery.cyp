// Create table
create(chuate: Phim {ten: 'Chua te chiec nhan', thoigian: 2020, theloai: 'Than thoai'})
create (nam: Khach {ten: 'nam', nam: 1991, tuoi: 30})

// Insert data to table based on mask
create(nam)-[:hanhdong{xem: '2d'}]->(chuate)

// Insert new relationships
match 
    (p:Phim), 
    (k: Khach)
where id(p) = 171 AND id(k) = 252
create (k)-[r:hanhdong{xem: '3d'}]->(p)
return type(r)

// Insert new relationships


Lưu ý:
Biểu đồ không show cùng tên

create(bachtiet: Phim {ten: 'Bạch tiết', thoigian: 2020, theloai: 'Than thoai'})
create(congchua: Phim {ten: 'Cong chua ngu trong rung', thoigian: 2020, theloai: 'Than thoai'})
create(thachsung: Phim {ten: 'Thach sung', thoigian: 2020, theloai: 'Than thoai'})
create(harry: Phim {ten: 'Harry potter', thoigian: 2020, theloai: 'Than thoai'})

// Cau vang - 171 - Tinh cam
// Happy house - 295 - Than thoai
// Con nha giau - 296 - Than thoai
// Giau ngheo - 297 - Than thoai
// 100 ngay - 298 - Than thoai
create(happyhouse: Phim {ten: 'Happy house', thoigian: 2020, theloai: 'tinhcam'})
create(connnhagiau: Phim {ten: 'Con nha giau', thoigian: 2020, theloai: 'tinhcam'})
create(giayngeo: Phim {ten: 'Giau ngheo', thoigian: 2020, theloai: 'tinhcam'})
create(tramngay: Phim {ten: '100 ngay', thoigian: 2020, theloai: 'tinhcam'})


// 2 loại phim: Than thoai - Tinh cam 

// Nam - 252 - 10
// Minh - 212 - 32
// Hai - 211 - 31
// Hau - 271 - 10

// Chua te nhung chiec nhan - 251 - Than thoai
// Bạch tiết - 291 - Than thoai
// Cong chua ngu trong rung - 292 - Than thoai
// Thach sung - 293 - Than thoai
// Harry potter - 294 - Than thoai

// Cau vang - 171 - Tinh cam
// Happy house - 295 - Tinh cam
// Con nha giau - 296 - Tinh cam
// Giau ngheo - 297 - Tinh cam
// 100 ngay - 298 - Tinh cam

// Suggest thể loại mới coi cho một khách dựa trên cùng thể loại hay xem

// 1. Tạo 1 khách id = 212 chuyên xem phim tình cảm
match
    (k: Khach), 
    (p:Phim {theloai: 'tinhcam'})
where id(k) = 212
create (k)-[r:hanhdong{xem: '2d'}]->(p)
return k, p

// 2. Tạo 1 khách id = 271 chuyên xem phim tình cảm
match
    (k: Khach), 
    (p:Phim {theloai: 'tinhcam'})
where id(k) = 271
create (k)-[r:hanhdong{xem: '2d'}]->(p)
return k, p

// 3. Tìm khách A chuyên coi phim tình cảm và sắp thứ tự
match
    (k: Khach)-[:hanhdong]->(phim)
return phim

// 4. Tìm những phim mà khách A đang xem mà khách B chưa xem (cùng thể loại)
// 4. Tìm những phim mà khách A đang xem mà khách B chưa xem (cùng thể loại)

match (:Khach{ten:'minh'})-[:hanhdong]->(m:Phim{theloai:'tinhcam'})<-[:hanhdong]-(coActor:Khach)-[]->(p:Phim)
return p.theloai

match (k:Khach{ten:'minh'})-[:hanhdong]->(m:Phim{theloai:'tinhcam'})<-[:hanhdong]-(coActor:Khach)-[]->(p:Phim)
where m.theloai <> p.theloai
return p.theloai




// Demo

// Movie
create(bachtiet: Movie {title: 'Bạch tiết', time: 1, type: 'thanthoai'})
create(congchua: Movie {title: 'Cong chua ngu trong rung', time: 2, type: 'thanthoai'})
create(thachsung: Movie {title: 'Thach sung', time: 3, type: 'thanthoai'})
create(harry: Movie {title: 'Harry potter', time: 4, type: 'thanthoai'})

create(happyhouse: Movie {title: 'Happy house', time: 5, type: 'tinhcam'})
create(connnhagiau: Movie {title: 'Con nha giau', time: 6, type: 'tinhcam'})
create(giaungeo: Movie {title: 'Giau ngheo', time: 7, type: 'tinhcam'})
create(tramngay: Movie {title: '100 ngay', time: 8, type: 'tinhcam'})

create(conan: Movie {title: 'Conan', time: 7, type: 'trinhtham'})
create(sherlock: Movie {title: 'Sherlock homes', time: 8, type: 'trinhtham'})

create(viendanbac: Movie {title: 'Vien dan bac', time: 7, type: 'hanhdong'})
create(skyfall: Movie {title: 'Skyfall', time: 8, type: 'hanhdong'})
create(satthu: Movie {title: 'Sat thu an danh', time: 8, type: 'hanhdong'})

// Name
create (nam: Customer {name: 'Nam', born: 1991, age: 30, sex: 'male'})
create (hung: Customer {name: 'Hung', born: 1991, age: 30, sex: 'male'})
create (minh: Customer {name: 'Minh', born: 1991, age: 30, sex: 'male'})
create (ha: Customer {name: 'Ha', born: 1991, age: 30, sex: 'female'})
create (thao: Customer {name: 'Thao', born: 1991, age: 30, sex: 'female'})

// all thanthoai
create(hung)-[:ACTION_IN{watch: '2d'}]->(bachtiet)
create(hung)-[:ACTION_IN{watch: '2d'}]->(congchua)
create(hung)-[:ACTION_IN{watch: '2d'}]->(thachsung)
create(hung)-[:ACTION_IN{watch: '2d'}]->(harry)

//3 thanthoai + 1 tinhcam
create(minh)-[:ACTION_IN{watch: '2d'}]->(bachtiet)
create(minh)-[:ACTION_IN{watch: '2d'}]->(congchua)
create(minh)-[:ACTION_IN{watch: '2d'}]->(harry)
create(minh)-[:ACTION_IN{watch: '2d'}]->(happyhouse)

//1 thanthoai + 1 tinhcam + 1 trinhtham + 1 hanhdong
create(nam)-[:ACTION_IN{watch: '2d'}]->(bachtiet)
create(nam)-[:ACTION_IN{watch: '2d'}]->(happyhouse)
create(nam)-[:ACTION_IN{watch: '2d'}]->(conan)
create(nam)-[:ACTION_IN{watch: '2d'}]->(viendanbac)

// 1 trinhtham + 2 hanhdong
create(ha)-[:ACTION_IN{watch: '2d'}]->(conan)
create(ha)-[:ACTION_IN{watch: '2d'}]->(viendanbac)
create(ha)-[:ACTION_IN{watch: '2d'}]->(satthu)

// all hanhdong
create(thao)-[:ACTION_IN{watch: '2d'}]->(viendanbac)
create(thao)-[:ACTION_IN{watch: '2d'}]->(skyfall)
create(thao)-[:ACTION_IN{watch: '2d'}]->(satthu)

// Giả sử trên cùng thời điểm phát tất cả các bộ phim thì người mà xem phim cùng thể loại với mình có đi xem phim nào không
// Quan trọng: Lọc được người có yêu thích thể loại giống mình
// hung log vào hệ thống
match (k:Customer{name:'Thao'})-[:ACTION_IN]->(m:Movie {title:'Sat thu an danh'})<-[:ACTION_IN]-(coActor:Customer)-[]->(p:Movie), (:Customer{name:'Thao'})-[:ACTION_IN]->(anomys:Movie)
with p as movie, collect(anomys.title) as anomysTitles
where not movie.title in anomysTitles
return movie