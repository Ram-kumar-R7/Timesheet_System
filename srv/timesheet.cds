// using { project.timesheet as db } from '../db/schema';

// service TimesheetService {
 
//   entity Employees as projection on db.Employees;
    

//   entity Projects as projection on db.Projects{
//   *,
//   case
//     when Status = 'PLANNED' then 0
//     when Status = 'IN_PROGRESS' then 2
//     when Status = 'COMPLETED' then 3
//     else 0
//   end as StatusCriticality : Integer
// };

//   entity WorkPackages as projection on db.WorkPackages;

//   // APP 1  Employee Timesheet App

//   @odata.draft.enabled
//   @cds.redirection.target
//    @restrict: [
//         {
//             grant: [
//                 'READ',
//                 'UPDATE',
//                 'DELETE',
//                 'CREATE'
//             ],
//             to   : 'Employee'
//         },
//         {
//             grant: ['*'],
//             to   : 'manager'
//         }
//     ]

//   entity Timesheets as projection on db.Timesheets {
//     *,
//       case
//     when Status = 'DRAFT' then 5
//     when Status = 'SUBMITTED' then 2
//     when Status = 'APPROVED' then 3
//     when Status = 'REJECTED' then 1
//     else 0
//     end as StatusCriticality : Integer,
//     Entries
//   }
//   actions {
//     action submitTimesheet() returns Timesheets;
//   };

//   // APP 2  Project Manager Dashboard
//    @restrict: [
//         {
//             grant: [
//                 'READ',
//                 'UPDATE',
//                 'DELETE',
//                 'CREATE'

//             ],
//             to   : 'Employee'
//         },
//         {
//             grant: ['*'],
//             to   : 'manager'
//         }
//     ]

//   entity PendingTimesheets as projection on db.Timesheets {
//     *,
//        case
//     when Status = 'DRAFT' then 5
//     when Status = 'SUBMITTED' then 2
//     when Status = 'APPROVED' then 3
//     when Status = 'REJECTED' then 1
//     else 0
//     end as StatusCriticality : Integer,
//     Entries
//   }
//   actions {
//     action approveTimesheet(comments : String) returns PendingTimesheets;
//     action rejectTimesheet(comments : String) returns PendingTimesheets;
//   };

//   entity TimesheetEntries as projection on db.TimesheetEntries;
// }

















using { project.timesheet as db } from '../db/schema';

service TimesheetService {

  entity Employees as projection on db.Employees;

  entity Projects as projection on db.Projects {
    *,
    case
      when Status = 'PLANNED' then 0
      when Status = 'IN_PROGRESS' then 2
      when Status = 'COMPLETED' then 3
      else 0
    end as StatusCriticality : Integer
  };

  entity WorkPackages as projection on db.WorkPackages;

  @odata.draft.enabled
  @cds.redirection.target
  @restrict: [
    {
      grant: ['READ', 'UPDATE', 'DELETE', 'CREATE'],
      to: 'Employee'
    },
    {
      grant: ['*'],
      to: 'manager'
    }
  ]
  entity Timesheets as projection on db.Timesheets actions {
    action submitTimesheet() returns Timesheets;
  };


 // APP 2  Project Manager Dashboard
  @restrict: [
    {
      grant: ['READ', 'UPDATE', 'DELETE', 'CREATE'],
      to: 'Employee'
    },
    {
      grant: ['*'],
      to: 'manager'
    }
  ]
  entity PendingTimesheets as projection on db.Timesheets {
    *,
    case
      when Status = 'DRAFT' then 5
      when Status = 'SUBMITTED' then 2
      when Status = 'APPROVED' then 3
      when Status = 'REJECTED' then 1
      else 0
    end as StatusCriticality : Integer
  }
  actions {
    action approveTimesheet(comments : String) returns PendingTimesheets;
    action rejectTimesheet(comments : String) returns PendingTimesheets;
  };

  @cds.redirection.target
  entity TimesheetEntries as projection on db.TimesheetEntries;
}