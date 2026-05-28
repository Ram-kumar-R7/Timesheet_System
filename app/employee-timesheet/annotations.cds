using TimesheetService as service from '../../srv/timesheet';

annotate service.Timesheets with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'TimesheetNo',
                Value: TimesheetNo,
            },
            {
                $Type: 'UI.DataField',
                Label: 'WeekStartDate',
                Value: WeekStartDate,
            },
            {
                $Type      : 'UI.DataField',
                Label      : 'Status',
                Value      : Status,
                Criticality: StatusCriticality

            },
            {
                $Type: 'UI.DataField',
                Label: 'TotalHours',
                Value: TotalHours,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ApprovalComments',
                Value: ApprovalComments,
            },
        ],
    },
    UI.FieldGroup #EmployeeDetails: {
        Data: [
        {
            $Type: 'UI.DataField',
            Value: Employee.EmpNo,
            Label: 'Employee No'
        },
        {
            $Type: 'UI.DataField',
            Value: Employee.Name,
            Label: 'Employee Name'
        },
        {
            $Type: 'UI.DataField',
            Value: Employee.Email,
            Label: 'Email'
        },
        {
            $Type: 'UI.DataField',
            Value: Employee.Department,
            Label: 'Department'
        },
        {
            $Type: 'UI.DataField',
            Value: Employee.Skills,
            Label: 'Skills'
        }
    ]},
    UI.HeaderInfo                 : {
        TypeName      : 'Timesheet',
        TypeNamePlural: 'Timesheets',
        Title         : {Value: TimesheetNo},
        Description   : {Value: Employee.Name},
    },
    UI.SelectionFields            : [
        TimesheetNo,
        Employee_ID,
        WeekStartDate,
        Status
    ],
    UI.Identification             : [{
        $Type : 'UI.DataFieldForAction',
        Label : 'Submit',
        Action: 'TimesheetService.submitTimesheet'
    }],
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'TimesheetEntries',
            Label : 'Timesheet Entries',
            Target: 'Entries/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'EmployeeDetails',
            Label : 'Employee Details',
            Target: '@UI.FieldGroup#EmployeeDetails'
        },
    ],
    UI.LineItem                   : [
        {
            $Type: 'UI.DataField',
            Label: 'TimesheetNo',
            Value: TimesheetNo,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Employee',
            Value: Employee_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'WeekStartDate',
            Value: WeekStartDate,
        },
        {
            $Type      : 'UI.DataField',
            Label      : 'Status',
            Value      : Status,
            Criticality: StatusCriticality

        },
        {
            $Type: 'UI.DataField',
            Label: 'TotalHours',
            Value: TotalHours,
        },
        {
            $Type: 'UI.DataField',
            Label: 'ApprovalComments',
            Value: ApprovalComments,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Submit',
            Action: 'TimesheetService.submitTimesheet',
            Inline: true
        },
    ],
);

annotate service.TimesheetEntries with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Label: 'Entry Date',
        Value: EntryDate
    },
    {
        $Type: 'UI.DataField',
        Label: 'Work Package',
        Value: WorkPackage_ID
    },
    {
        $Type: 'UI.DataField',
        Label: 'Hours',
        Value: Hours
    },
    {
        $Type: 'UI.DataField',
        Label: 'Description',
        Value: Description
    },

]);


annotate service.Timesheets with {
    Employee   @(
        Common.Label          : 'Employee Name',
        Common.Text           : Employee.Name,
        Common.TextArrangement: #TextOnly
    );

    ApprovedBy @(
        Common.Label          : 'Approved By',
        Common.Text           : ApprovedBy.Name,
        Common.TextArrangement: #TextOnly
    );
};

annotate service.TimesheetEntries with {
    WorkPackage @(
        Common.Text           : WorkPackage.Title,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            CollectionPath: 'WorkPackages',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: WorkPackage_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'WPCode'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Title'
                }
            ]
        }
    );
};

annotate service.WorkPackages with {
    WPCode @Common.Text: Title;
};

annotate service.Timesheets actions {

    submitTimesheet @Common.SideEffects: {TargetProperties: [
        'in/Status',
        'in/TotalHours'
    ]};

// approveTimesheet @Common.SideEffects: {
//     TargetProperties: ['in/Status'],
//     TargetEntities  : ['in/Entries']
// };

// rejectTimesheet  @Common.SideEffects: {TargetProperties: [
//     'in/Status',
//     'in/ApprovalComments'
// ]};
};

annotate service.Timesheets with {
    Entries @Common.SideEffects: {TargetProperties: ['TotalHours']};
};

annotate service.TimesheetEntries with {
    Hours @Common.SideEffects: {TargetEntities: ['Timesheet']};
};

annotate service.Timesheets with {
    Employee @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Employees',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Employee_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'EmpNo',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Email',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Department',
            },
        ],
    }
};

annotate service.Timesheets with {
    ApprovedBy @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Employees',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ApprovedBy_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'EmpNo',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Email',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Department',
            },
        ],
    }
};


