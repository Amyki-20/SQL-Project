CREATE TABLE Client (
    clientID INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(255) NOT NULL, 
    subcity VARCHAR(255) NOT NULL, 
    city VARCHAR(255) NOT NULL
);

CREATE TABLE ProjectManager (
    pmID INTEGER PRIMARY KEY AUTOINCREMENT, 
    fname VARCHAR(255) NOT NULL, 
    lname VARCHAR(255) NOT NULL, 
    gender CHAR NOT NULL, 
    subcity VARCHAR(255) NOT NULL, 
    city VARCHAR(255) NOT NULL, 
    email VARCHAR(255) NOT NULL, 
    phoneNo CHAR(13) NOT NULL
);

CREATE TABLE Project (
    projID INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(255) NOT NULL, 
    subcity VARCHAR(255) NOT NULL, 
    city VARCHAR(255) NOT NULL, 
    type VARCHAR(255) NOT NULL, 
    clientID INTEGER NOT NULL, 
    pmID INTEGER, 
    FOREIGN KEY (clientID) REFERENCES Client (clientID) 
        ON DELETE RESTRICT,
    FOREIGN KEY (pmID) REFERENCES ProjectManager (pmID) 
        ON DELETE SET NULL
);

CREATE TABLE Task (
    taskID INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT NOT NULL,
    status INTEGER DEFAULT 0 CHECK (status >= 0 and status <= 100),
    deadline DATE,
    projID INTEGER NOT NULL,
    FOREIGN KEY (projID) REFERENCES Project (projID) ON DELETE RESTRICT
);

CREATE TABLE Employee (
    empID INTEGER PRIMARY KEY AUTOINCREMENT,
    fname VARCHAR(255),
    lname VARCHAR(255),
    gender CHAR,
    subcity VARCHAR(255),
    city VARCHAR(255),
    role VARCHAR(255),
    phoneNo CHAR(13)
);

CREATE TABLE SafetyRecord (
    description TEXT,
    date DATETIME,
    severity INTEGER DEFAULT 1 CHECK (severity >= 1 and severity <= 3),
    empID INTEGER NOT NULL,
    FOREIGN KEY (empID) REFERENCES Employee (empID) ON DELETE CASCADE
);

CREATE TABLE assigned_to (
    empID INTEGER NOT NULL,
    taskID INTEGER NOT NULL,
    start_date DATETIME DEFAULT(datetime()),
    FOREIGN KEY (empID) REFERENCES Employee (empID) ON DELETE CASCADE,
    FOREIGN KEY (taskID) REFERENCES Task (taskID) ON DELETE CASCADE
); 

CREATE TABLE Supplier (
    suppID INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    subcity VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
);

CREATE TABLE Store (
    storeID INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    subcity VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    empID INTEGER NOT NULL,
    FOREIGN KEY (empID) REFERENCES Employee (empID) ON DELETE RESTRICT
);

CREATE TABLE Resource (
    reID INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    projID INTEGER,
    storeID INTEGER,
    allocation_date DATETIME,
    release_date DATETIME,
    suppID INTEGER,
    quantity INTEGER DEFAULT 1 CHECK (quantity >= 1),
    start_date DATETIME,
    end_date DATETIME,
    FOREIGN KEY (projID) REFERENCES Project (projID) 
        ON DELETE SET NULL,
    FOREIGN KEY (storeID) REFERENCES Store (storeID) 
        ON DELETE SET NULL,
    FOREIGN KEY (suppID) REFERENCES Supplier (suppID) 
        ON DELETE SET NULL
);




INSERT INTO Client (name, subcity, city) 
VALUES 
  ("Z Construction", "kolfe", "Addis Ababa"), 
  ("Ethio Contractors", "Bole", "Addis Ababa"), 
  ("Addis Builders", "tana", "bahir dar"), 
  ("KB Developers", "hayk dar", "hawassa"), 
  ("Fast Construction", "fasil", "gonder"), 
  ("Quality Builders", "lugo", "adama"), 
  ("Alpha Developers", "Bole-Bulbulla", "Addis Ababa"), 
  ("Zoblan Construction", "CMC", "Addis Ababa"), 
  ("KB Developers", "gish abay", "bahir dar"), 
  ("NS Contractors", "tana", "hawassa");
  
INSERT INTO Employee (fname, lname, gender, subcity, city, role, phoneNo)
VALUES 
  ("abebe", "gebru", "m", "bole ", "addis ababa", "supervisor", 0911345243), 
  ("helen", "brhanu", "f", "kolfe", "addis ababa", "supervisor", 0911564536), 
  ("yafet", "bereket", "m", "tana", "bahir dara", "supervisor", 0923145643), 
  ("hayat", "muhamed", "f", "addis ketema", "hawassa", "supervisor", 0911245367), 
  ("afomia", "seifu", "f", "fasil", "gonder", "supervisor", 0911234234), 
  ("dina", "dino", "f", " lugo", "adamma", "supervisor", 0911234325),("tiyobista", "mesfine", "f", "kgish abay", "bahir dar", "supervisor", 0988765764),
  ("yosef", "mulugeta", "m", "nifas silklafto ", "addis ababa", "carpenter", 0988763542), 
  ("yonathan", "ermias", "m", " yeka", "addis ababa", "civil engineer", 0911546736), 
  ("fahmi", "nesru", "m", "lemi kura", "addis ababa", "architect", 0922345267), 
  ("bizualem", "getahun", "m", " bole", "addis ababa", "opertor", 0911453625), 
  ("yafet", "bereket", "m", "mehal ketema", "hawassa", "opertor", 0978262456), 
  ("elshalom", "daniel", "m", " boku", "adamma", "electrican", 0911435625), 
  ("muluken", "desalgn", "m", " facilo", "bahir dar", "ironworker", 0911345263), 
  ("hailegebrail", "getachew", "m", " jantekel", "gonder", "carpenter", 0944256143), 
  ("gezachew", "yetbarek", "m", " arada", "gonder", "civil engineer", 0911546536), 
  ("kebede", "gezahegn", "m", "tabor ", "hawassa", "arichitect", 0923451673), 
  ("adenw", "tsgaye", "m", " dabe", "adamma", "ironworker", 0911456372), 
  ("telahun", "getache", "m", " aba gada", "adamma", "electrican", 0911536253);

INSERT INTO SafetyRecord (description, date, severity, empID) 
VALUES
  (
    "got electricuted while trying to lay wires on the walls for light", "2022-03-23 10:25;00", 1, 19
  ), 
  (
    "fell from the stairs while walking on site", "2022-09-30 09:30;00", 3, 10
  ), 
  (
    "accidentally hit his hand while trying to bend the iron with a hammer", "2023-06-23 03:56:00", 2, 15
  ), 
  (
    "fell off the stairs while going down in a rush", "2024-03-23 05:15:00", 2, 16
  ), 
  (
    "stepped on a nail while visiting the site", "2020-07-26 06:45:00", 2, 11
  ), 
  (
    "Slipped on wet floor near the entrance", "2023-01-15 09:20:00", 2, 5
  ), 
  (
    "Injured while lifting heavy equipment", "2024-09-10 09:55:00", 3, 19
  ), 
  (
    "Suffered minor burns during welding operation", 
    "2022-11-30 11:10:00", 1, 14
  ), 
  (
    "Caught hand in machinery while performing maintenance", "2023-06-05 14:30:00", 3, 12
  ), 
  (
    "Tripped over equipment left in walkway", "2021-08-20 10:45:00", 2, 7
  );
  
INSERT INTO Store (name, subcity, city, empid) 
VALUES 
  (NULL, "bole", "addis ababa", 1), 
  (NULL, "kolfe", "addis ababa", 2), 
  (NULL, "tana", "bahir dar", 3), 
  (NULL, "addis ketema", "hawassa", 4), 
  (NULL, "fasil", "gonder", 5), 
  (NULL, "lugo", "adama", 6), 
  (NULL, "gish abay", "bahir dar", 7);

INSERT INTO Supplier (name, subcity, city) 
VALUES 
  ("Alemayehu Building Materials", "Bole", "Addis Ababa" ), 
  ("Yohannes Construction Supply", "kolfe", "Addis Ababa"), 
  ("Tewodros Construction Mart", "tana", "bahir dar"),
  ("Zewditu Hardware Store", "addis ketema", "hawassa"),
  ("Meseret Concrete Suppliers", "gish abay", "bahir dar"),
  ("Abiy Cement Distributors", "fasil", "gonder"),
  ("Berhanu Roofing Solutions", "jantekel", "gonder"), 
  ("Selam Scaffolding Services", "menahreya", "hawwassa"),
  ("Genet Steel Enterprises", "gullele", "Addis Ababa"),
  ("Mulugeta Crane Rental", "lugo", "Adamma");

INSERT INTO ProjectManager (fname, lname, gender, subcity, city, email, phoneNo) 
VALUES 
  (
    "Joni", "Samuel", "F", "bole", "addis ababa", 
    "joni.samuel@example.com", "9111111111"
  ), 
  (
    "Mike", "getachew", "M", "tana", "bahir dar", 
    "mike.johnson@example.com", "912345678"
  ), 
  (
    "jonathan", "michael", "M", "menahreya", 
    "hawassa", "jordan.mich@example.com", 
    "912121212"
  ), 
  (
    "Eman", "mohammed", "F", "arada", "gonder", 
    "emey.bor@example.com", "91010101010"
  ), 
  (
    "leya", "mika", "F", "boku", "adama", 
    "len.mika@example.com", "099-371-9773"
  ), 
  (
    "yakob", "hoonian", "M", "kolfe", "addis ababa", 
    "jac.hoon@example.com", "990-927-4423"
  ), 
  (
    "mezgebu", "robel", "M", "fasil", "gonder", 
    "mez.rob@example.com", "837-489-7382"
  );
  
INSERT INTO Project (name, subcity, city, type, clientID, pmID) 
VALUES
  ("gotera condominum project", "gotera", "addis ababa", "real estate", 1, 1 ), 
  ("new branch of CBE", "tana", "bahir dar", "residental", 3, 2),
  ("fasil bridge", "fasil", "gonder", "constraction", 5, 4), 
  ("menaherya tower", "manherya", "hawassa", "big bulding", 4, 3), 
  ("new road from kolfe to gullele", "kolfe", "addis ababa", "road construction", 7, 6 ),
  ("hawassa park", "mehal ketema", "hawassa", "designing", 10, 3), 
  ("4kilo road", "addis ketema", "addis ababa", "road", 5, 7), 
  ("Mazegaja wall", "kolfe", "bahir dar", "building", 6, 2), 
  ("Bole road", "lideta", "addis ababa", "building", 7, 4), 
  ("Kotebe Univeristy lounge", "kolfe", "gonder", "road" , 9, 7);

INSERT INTO Task (description, status, deadline, projID)
VALUES 
("Prepare architectural drawings for new residential project next to Gotera Condominum", 25, "2025 - 02 - 15", 1),
("Conduct soil testing for new branch of CBE ", 85, "2024 - 06 - 15", 2),
("Coordinate material procurement for a bridge infrastructure project", 90, "2024 - 05 - 20", 3),
("Manage construction schedule for high - rise building", 15, " 2024 - 09 - 05", 4),
("Inspect ongoing road construction for quality compliance", 59, " 2024 - 08 - 01", 5),
("Survey and prepare topographic maps for a new industrial park", 66, " 2024 - 09 - 25", 6),
("Manage environmental impact assessment for a large - scale infrastructure project", 40, "2025 - 01 - 10", 7),
("Coordinate subcontractors for plumbing installation in a commercial complex", 85, "2024 - 07 - 15", 8),
("Supervise concrete pouring and curing for a bridge construction project", 30, "2025 - 03 - 05", 9),
("Coordinate subcontractors for electrical installation in a commercial complex ", 70, "2024 - 08 - 06", 9);

INSERT INTO Resource (name, type, projid, storeid, allocation_date, release_date, suppid, quantity, start_date, end_date)
VALUES
    ("Excavator", "Heavy Equipment", 1, 1, "2024 - 05 - 11 08 : 00 : 00", "2024 - 05 - 12 17 : 00 : 00", null, 1, null, null),
    ("Concrete Mixer", "Heavy Equipment", 2, 2, " 2024 - 05 - 12 09 : 00 : 00 ", " 2024 - 05 - 13 18 : 00 : 00 ", null, 1, null, null),
    ("Cement Bags", "Material", 3, null, null, null, 3, 100, "2024 - 05 - 13 10 : 00 : 00", null),
    ("Steel Bars", "Material", 4, null, null, null, 4, 200, "2024 - 05 - 14 11 : 00 : 00", null),
    ("Crane", "Heavy Equipment", 5, 5, "2024 - 05 - 15 12 : 00 : 00", "2024 - 05 - 16 21 : 00 : 00", null, 1, null, null),
    ("Brick", "Material", 6, null, null, null, 6, 5000, "2024 - 05 - 16 13 : 00 : 00", null),
    ("Paint", "Material", 7, null, null, null, 7, 50, "2024 - 05 - 17 14 : 00 : 00", null),
    ("Scaffolding", "Material", 8, null, null, null, 8, 10, "2024 - 05 - 18 15 : 00 : 00", null),
    ("Roofing Sheets", "Material", 9, null, null, null, 9, 100, "2024 - 05 - 19 16 : 00 : 00 ", " 2024 - 05 - 21 01 : 00 : 00 "),
    ("Forklift", "Heavy Equipment", 10, null, null, null, 10, 1, "2024 - 05 - 20 17 : 00 : 00", "2024 - 05 - 22 02 : 00 : 00");

INSERT INTO assigned_to (empid,taskid,start_date)
VALUES (1,3," 2020 - 03 - 23 "),
  (10,1," 2023 - 04 - 24 "),
  (4,4," 2020 - 02 - 20 "),
  (12,9," 2023 - 01 - 12 "),
  (19,10," 2024 - 05 - 15 "),
  (1,5," 2021 - 09 - 15 "),
  (16,6," 2022 - 08 - 09 "),
  (3,3," 2021 - 07 - 26 "),
  (17,1," 2019 - 07 - 11 ");


SELECT Project.name, Project.subcity, Project.city, Project.type, ProjectManager.fname, ProjectManager.lname
FROM Project
LEFT JOIN ProjectManager ON Project.pmID = ProjectManager.pmID;

SELECT SafetyRecord.description, SafetyRecord.date, Employee.fname, Employee.lname, SafetyRecord.severity
FROM SafetyRecord
JOIN Employee ON SafetyRecord.empID = Employee.empID
WHERE SafetyRecord.severity = 3;

SELECT type, SUM(quantity) AS total_quantity
FROM Resource
GROUP BY type;

SELECT Employee.empID, Employee.fname, Employee.lname, Employee.city AS employee_city, Project.city AS project_city
FROM Employee
JOIN assigned_to ON Employee.empID = assigned_to.empID
JOIN Task ON assigned_to.taskID = Task.taskID
JOIN Project ON Task.projID = Project.projID
WHERE Employee.city != Project.city;

SELECT Project.name, COUNT(Task.taskID) AS ongoing_tasks
FROM Project
LEFT JOIN Task ON Project.projID = Task.projID
WHERE Task.status < 100 OR Task.status IS NULL
GROUP BY Project.projID, Project.name;


SELECT Employee.fname, Employee.lname, COUNT(CASE WHEN Task.status >= 90 THEN 1 END) AS to_be_completed_tasks
FROM Employee
JOIN assigned_to ON assigned_to.empID = Employee.empID
JOIN Task ON Task.taskID = assigned_to.taskID
GROUP BY Employee.empID;
