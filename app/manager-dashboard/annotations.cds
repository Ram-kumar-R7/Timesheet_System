// using TimesheetService as service from '../../srv/timesheet';
// annotate service.PendingTimesheets with @(
//     UI.FieldGroup #GeneratedGroup : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'TimesheetNo',
//                 Value : TimesheetNo,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'WeekStartDate',
//                 Value : WeekStartDate,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Status',
//                 Value : Status,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'TotalHours',
//                 Value : TotalHours,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'ApprovalComments',
//                 Value : ApprovalComments,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'StatusCriticality',
//                 Value : StatusCriticality,
//             },
//         ],
//     },
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneratedFacet1',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneratedGroup',
//         },
//     ],
//     UI.LineItem : [
//         {
//             $Type : 'UI.DataField',
//             Label : 'TimesheetNo',
//             Value : TimesheetNo,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'WeekStartDate',
//             Value : WeekStartDate,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Status',
//             Value : Status,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'TotalHours',
//             Value : TotalHours,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'ApprovalComments',
//             Value : ApprovalComments,
//         },
//     ],
// );

// annotate service.PendingTimesheets with {
//     Employee @Common.ValueList : {
//         $Type : 'Common.ValueListType',
//         CollectionPath : 'Employees',
//         Parameters : [
//             {
//                 $Type : 'Common.ValueListParameterInOut',
//                 LocalDataProperty : Employee_ID,
//                 ValueListProperty : 'ID',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'EmpNo',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'Name',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'Email',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'Department',
//             },
//         ],
//     }
// };

// annotate service.PendingTimesheets with {
//     ApprovedBy @Common.ValueList : {
//         $Type : 'Common.ValueListType',
//         CollectionPath : 'Employees',
//         Parameters : [
//             {
//                 $Type : 'Common.ValueListParameterInOut',
//                 LocalDataProperty : ApprovedBy_ID,
//                 ValueListProperty : 'ID',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'EmpNo',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'Name',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'Email',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'Department',
//             },
//         ],
//     }
// };


using TimesheetService as service from '../../srv/timesheet';

annotate service.PendingTimesheets with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'TimesheetNo',
                Value : TimesheetNo,
            },
            {
                $Type : 'UI.DataField',
                Label : 'WeekStartDate',
                Value : WeekStartDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : Status,
                Criticality: StatusCriticality
            },
            {
                $Type : 'UI.DataField',
                Label : 'TotalHours',
                Value : TotalHours,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ApprovalComments',
                Value : ApprovalComments,
            },
        ],
    },
     UI.FieldGroup #EmployeeDetails: {Data: [
        {
            Value: Employee.EmpNo,
            Label: 'Employee No'
        },
        {
            Value: Employee.Name,
            Label: 'Employee Name'
        },
        {
            Value: Employee.Email,
            Label: 'Email'
        },
        {
            Value: Employee.Department,
            Label: 'Department'
        },
        {
            Value: Employee.Skills,
            Label: 'Skills'
        }
    ]},

    UI.HeaderInfo                 : {
        TypeName      : 'Pending Timesheet',
        TypeNamePlural: 'Pending Timesheets',
        Title         : {Value: TimesheetNo},
        Description   : {Value: Employee.Name},
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'EmployeeDetails',
            Label : 'Employee Details',
            Target: '@UI.FieldGroup#EmployeeDetails'
        }
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'TimesheetNo',
            Value : TimesheetNo,
        },
         {
            $Type: 'UI.DataField',
            Label: 'Employee',
            Value: Employee.Name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'WeekStartDate',
            Value : WeekStartDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : Status,
            Criticality: StatusCriticality
        },
        {
            $Type : 'UI.DataField',
            Label : 'TotalHours',
            Value : TotalHours,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ApprovalComments',
            Value : ApprovalComments,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Approve',
            Action: 'TimesheetService.approveTimesheet',
            Inline: true
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Reject',
            Action: 'TimesheetService.rejectTimesheet',
            Inline: true
        }
    ],
     UI.Identification             : [
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Approve',
            Action: 'TimesheetService.approveTimesheet'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Reject',
            Action: 'TimesheetService.rejectTimesheet'
        }
    ],
);


annotate service.PendingTimesheets with {
    Employee   @(
        Common.Label          : 'Employee',
        Common.Text           : Employee.Name,
        Common.TextArrangement: #TextOnly
    );

    ApprovedBy @(
        Common.Label          : 'Approved By',
        Common.Text           : ApprovedBy.Name,
        Common.TextArrangement: #TextOnly
    );
};

annotate service.PendingTimesheets actions {
    approveTimesheet @Common.SideEffects: {
        TargetProperties: ['in/Status'],
        TargetEntities  : ['in/Entries']
    };

    rejectTimesheet  @Common.SideEffects: {TargetProperties: [
        'in/Status',
        'in/ApprovalComments'
    ]};
};

annotate service.PendingTimesheets with {
    Employee @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Employees',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : Employee_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'EmpNo',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Department',
            },
        ],
    }
};

annotate service.PendingTimesheets with {
    ApprovedBy @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Employees',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : ApprovedBy_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'EmpNo',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Department',
            },
        ],
    }
};








