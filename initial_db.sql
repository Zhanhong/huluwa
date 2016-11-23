create database healthcare;

use healthcare;

/*==============================================================*/
/* Table: UserAccount                                              */
/*==============================================================*/
create table UserAccount(
	UserID                 int                   not null auto_increment,
	FirstName              nvarchar(40)          not null,
	LastName               nvarchar(40)          not null,
	Street                 nvarchar(40)          not null,
	City                   nvarchar(40)          not null,
	State                  nvarchar(40)          not null,
    Country                nvarchar(40)          not null,
	Zipcode                nvarchar(20)          not null,   
	Phone                  nvarchar(20)          not null,
	AccountType            nvarchar(40)          not null,
    primary key (UserID),
    unique(UserID)
);

/*==============================================================*/
/* Table: Patient                                            */
/*==============================================================*/
create table Patient(
	PatientID              int                  not null,
    HealthRecordNumber     int                  not null,
    MedicalRecordNumber    int                  not null,
    primary key (PatientID),
    foreign key (PatientID) references UserAccount(UserID)
);

/*==============================================================*/
/* Table: Hospital                                           */
/*==============================================================*/
create table Hospital(
	HospitalID             int                   not null auto_increment,
	HospitalName           nvarchar(40)          not null,
	Street                 nvarchar(40)          not null,
	City                   nvarchar(40)          not null,
	State                  nvarchar(40)          not null,
    Country                nvarchar(40)          not null,
	Zipcode                nvarchar(20)          not null, 
    DateOfEstablishment    date                  null,
    primary key (HospitalID)
);

/*==============================================================*/
/* Table: Doctor                                           */
/*==============================================================*/
create table Doctor(
	DoctorID               int                   not null,
    HospitalID             int                   not null,
    Speciality             nvarchar(40)          not null,
    Title                  nvarchar(40)          not null,
    primary key (DoctorID),
    foreign key (DoctorID) references UserAccount(UserID),
    foreign key (HospitalID) references Hospital(HospitalID)
);

/*==============================================================*/
/* Table: Symphtom                                           */
/*==============================================================*/
create table Symphtom(
	SymphtomID              int                   not null auto_increment,
    SymphtomDescription     nvarchar(80)          not null,
    primary key (SymphtomID)
);

/*==============================================================*/
/* Table: HealthRecord                                           */
/*==============================================================*/
create table HealthRecord(
	HealthRecordNumber     int                   not null auto_increment,
    PatientID              int                   not null,
    Weight                 decimal(6,2)          null,
	HeartRate              int                   null,
    BloodPressure          int                   null,
    BodyTemperature        nvarchar(20)          null,
    primary key (HealthRecordNumber),
    foreign key (PatientID) references Patient(PatientID)
);

/*==============================================================*/
/* Table: Prescription                                          */
/*==============================================================*/
create table Prescription(
	PrescriptionID          int                   not null auto_increment,
    DoctorID                int                   not null,
    DrugID                  nvarchar(40)          null,
    PrescriptionDescription nvarchar(80)          not null,
    primary key (PrescriptionID),
    foreign key (DoctorID) references Doctor(DoctorID)
);

/*==============================================================*/
/* Table: MedicalRecord                                           */
/*==============================================================*/
create table MedicalRecord(
	MedicalRecordNumber     int                   not null auto_increment,
    PatientID               int                   not null,
    SymphtomID              int                   null,
    PrescriptionID          int                   null,
    DateOfDiagnosis         date                  null,
    Treatmentresult         nvarchar(20)          null, 
	primary key (MedicalRecordNumber),
    foreign key (PatientID) references Patient(PatientID),
    foreign key (SymphtomID) references Symphtom(SymphtomID),
    foreign key (PrescriptionID) references Prescription(PrescriptionID)
);

/*==============================================================*/
/* Table: Device                                          */
/*==============================================================*/
create table Device(
	DeviceType             nvarchar(40)          not null,
    DevicePrice            decimal(12,2)         null,
    DeviceInventory        int                   not null,
    primary key (DeviceType)
);


/*==============================================================*/
/* Table: Disease                                           */
/*==============================================================*/
create table Disease(
	DiseaseName            nvarchar(40)          not null,
    SymphtomID             int                   not null,
    PrescriptionID         int                   not null,
    DeviceType             nvarchar(40)          not null,
    primary key (DiseaseName),
    foreign key (SymphtomID) references Symphtom(SymphtomID),
    foreign key (PrescriptionID) references Prescription(PrescriptionID),
    foreign key (DeviceType) references Device(DeviceType)
);

/*==============================================================*/
/* Table: Drug                                           */
/*==============================================================*/
create table Drug(
	DrugID                 int                   not null auto_increment,
    DrugName               nvarchar(40)          not null,
    SymphtomID             int                   not null,
    primary key (DrugID),
    foreign key (SymphtomID) references Symphtom(SymphtomID)
);

/*==============================================================*/
/* Table: Test                                          */
/*==============================================================*/
create table Test(
	TestNumber             int                   not null auto_increment,
    DeviceType             nvarchar(40)          not null,
    TestResult             nvarchar(80)          not null,
    primary key (TestNumber),
    foreign key (DeviceType) references Device(DeviceType) 
);

/*==============================================================*/
/* Table: Diagnosis                                          */
/*==============================================================*/
create table Diagnosis(
	DiagnosisNumber        int                   not null auto_increment,
    PrescriptionID         int                   not null,
    TestNumber             int                   null,
    PatientID              int                   not null,
    DoctorID               int                   not null,
    primary key (DiagnosisNumber),
    foreign key (PrescriptionID) references Prescription(PrescriptionID),
    foreign key (TestNumber) references Test(TestNumber),
    foreign key (PatientID) references Patient(PatientID),
    foreign key (DoctorID) references Doctor(DoctorID) 
);

/*==============================================================*/
/* Table: Supplier                                       */
/*==============================================================*/
create table Supplier(
	SupplierName           nvarchar(40)          not null,
    Street                 nvarchar(40)          not null,
	City                   nvarchar(40)          not null,
	State                  nvarchar(40)          not null,
    Country                nvarchar(40)          not null,
	Zipcode                nvarchar(20)          not null, 
	primary key (SupplierName)
);

/*==============================================================*/
/* Table: Supply                                        */
/*==============================================================*/
create table Supply(
	SupplierName           nvarchar(40)          not null,
    DeviceType             nvarchar(40)          not null,
    Quantity               int                   not null,
    primary key (SupplierName, DeviceType),
    foreign key (SupplierName) references Supplier(SupplierName),
    foreign key (DeviceType) references Device(DeviceType)
);

/*==============================================================*/
/* Table: Warehouse                                        */
/*==============================================================*/
create table Warehouse(
	WarehouseName          nvarchar(40)          not null,
    Street                 nvarchar(40)          not null,
	City                   nvarchar(40)          not null,
	State                  nvarchar(40)          not null,
    Country                nvarchar(40)          not null,
	Zipcode                nvarchar(20)          not null, 
    WarehouseInventory     int                   not null,
    primary key (WarehouseName)
);

/*==============================================================*/
/* Table: Inventory                                        */
/*==============================================================*/
create table Inventory(
	WarehouseName          nvarchar(40)          not null,
    DeviceType             nvarchar(40)          not null,
    Quantity               int                   not null,
    primary key (WarehouseName, DeviceType),
    foreign key (DeviceType) references Device(DeviceType),
    foreign key (WarehouseName) references Warehouse(WarehouseName)
);



