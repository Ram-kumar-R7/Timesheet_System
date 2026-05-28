using {project.timesheet as db} from '../db/schema';


service ProjectService {

  entity Employees    as projection on db.Employees;

  @restrict: [
        {
            grant: [
                'READ',
                'UPDATE',
                'DELETE',
                'CREATE'

            ],
            to   : 'Employee'
        },
        {
            grant: ['*'],
            to   : 'manager'
        }
    ]

  entity Projects  as projection on db.Projects {
      *,
      case
        when Status = 'PLANNED'
             then 0
        when Status = 'IN_PROGRESS'
             then 2
        when Status = 'COMPLETED'
             then 3
        else 0
      end as StatusCriticality : Integer,
      WorkPackages
    }
    actions {
      action startProject()    returns Projects;
      action completeProject() returns Projects;
    };

  entity WorkPackages as projection on db.WorkPackages;

  function getBudgetVariance(projectID: UUID) returns Decimal(15, 2);

}
