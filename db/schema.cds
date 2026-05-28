namespace project.timesheet;

using {
  managed
} from '@sap/cds/common';

type ProjectStatus     : String enum {
  PLANNED;
  IN_PROGRESS;
  COMPLETED;
  ON_HOLD;
  CANCELLED;
}

type WorkPackageStatus : String enum {
  OPEN;
  IN_PROGRESS;
  COMPLETED;
  BLOCKED;
}

type TimesheetStatus   : String enum {
  DRAFT;
  SUBMITTED;
  APPROVED;
  REJECTED;
}

entity Employees {
  key ID         : UUID;
      EmpNo      : String;
      Name       : String;
      Email      : String;
      Department : String;
      HourlyRate : Decimal;
      Skills     : String;
}

entity Projects {
  key ID             : UUID;
      ProjectCode    : String;
      Name           : String;
      Client         : String;
      StartDate      : Date;
      EndDate        : Date;
      Budget         : Decimal(15, 2);
      BudgetConsumed : Decimal(15, 2) default 0;
      Status         : ProjectStatus default 'PLANNED';
      ProjectManager : Association to Employees;
      WorkPackages   : Composition of many WorkPackages
                         on WorkPackages.Project = $self;
}

entity WorkPackages {
  key ID           : UUID;
      Project      : Association to Projects;
      WPCode       : String;
      Title        : String;
      PlannedHours : Decimal(10, 2);
      ActualHours  : Decimal(10, 2) default 0;
      AssignedTo   : Association to Employees;
      Status       : WorkPackageStatus default 'OPEN';
}

entity Timesheets : managed {
  key ID               : UUID;
      TimesheetNo      : String(20);
      Employee         : Association to Employees;
      WeekStartDate    : Date;
      Status           : TimesheetStatus default 'DRAFT';
      TotalHours       : Decimal(10, 2) default 0;
      ApprovedBy       : Association to Employees;
      ApprovalComments : String;
      Entries          : Composition of many TimesheetEntries
                           on Entries.Timesheet = $self;
}


entity TimesheetEntries {
  key ID          : UUID;
      Timesheet   : Association to Timesheets;
      WorkPackage : Association to WorkPackages;
      EntryDate   : Date;
      Hours       : Decimal(5, 2);
      Description : String;
}



