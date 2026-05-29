
using ProjectService as service from '../../srv/project';

annotate service.Projects with @(
    
    UI.FieldGroup #ProjectDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ProjectCode',
                Value: ProjectCode,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: Name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Client',
                Value: Client,
            },
            {
                $Type: 'UI.DataField',
                Label: 'StartDate',
                Value: StartDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'EndDate',
                Value: EndDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Budget',
                Value: Budget,
            },
            {
                $Type: 'UI.DataField',
                Label: 'BudgetConsumed',
                Value: BudgetConsumed,
            },
            {
                $Type      : 'UI.DataField',
                Label      : 'Status',
                Value      : Status,
                Criticality: StatusCriticality

            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'ProjectDetails',
            Label : 'Project Details',
            Target: '@UI.FieldGroup#ProjectDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'WorkPackages',
            Label : 'Work Packages',
            Target: 'WorkPackages/@UI.LineItem'
        },
    ],
    UI.HeaderInfo                : {
        TypeName      : 'Project',
        TypeNamePlural: 'Projects',
        Title         : {Value: ProjectCode},
        Description   : {Value: Name}
    },
    UI.SelectionFields           : [
        ProjectCode,
        Name,
        Client,
        Status
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'ProjectCode',
            Value: ProjectCode,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Name',
            Value: Name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Client',
            Value: Client,
        },
        {
            $Type      : 'UI.DataField',
            Label      : 'Status',
            Value      : Status,
            Criticality: StatusCriticality
        },
        {
            $Type: 'UI.DataField',
            Label: 'StartDate',
            Value: StartDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'EndDate',
            Value: EndDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Budget',
            Value: Budget
        },
        {
            $Type: 'UI.DataField',
            Label: 'Budget Consumed',
            Value: BudgetConsumed
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Start Project',
            Action: 'ProjectService.startProject',
            Inline: true,
           
        },

        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Complete Project',
            Action: 'ProjectService.completeProject',
            Inline: true,
            Criticality:#Positive   
        }
    ],
    UI.Identification            : [
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Start Project',
            Action: 'ProjectService.startProject', 
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Complete Project',
            Action: 'ProjectService.completeProject',
            Criticality:#Positive
        }
    ],
    Analytics.AggregatedProperty #Budget_max : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'Budget_max',
        AggregatableProperty : Budget,
        AggregationMethod : 'max',
        @Common.Label : 'Budget (Maximum)',
    },
    UI.Chart #alpChart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Dimensions : [
            ProjectCode,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#Budget_max',
            '@Analytics.AggregatedProperty#BudgetConsumed_max',
        ],
    },
    Analytics.AggregatedProperty #BudgetConsumed_max : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'BudgetConsumed_max',
        AggregatableProperty : BudgetConsumed,
        AggregationMethod : 'max',
        @Common.Label : 'BudgetConsumed (Maximum)',
    },
);

// annotate service.WorkPackages with @(UI.LineItem: [
//     {
//         $Type: 'UI.DataField',
//         Value: WPCode,
//         Label: 'WP Code'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: Title,
//         Label: 'Title'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: PlannedHours,
//         Label: 'Planned Hours'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: ActualHours,
//         Label: 'Actual Hours'
//     },
//     {
//         $Type: 'UI.DataField',
//         Value: AssignedTo.Name,
//         Label: 'Assigned To'
//     },
//     {
//         $Type      : 'UI.DataField',
//         Value      : Status,
//         Label      : 'Status',
//         Criticality: StatusCriticality
//     }
// ]);

annotate service.Projects actions {
    startProject @Common.SideEffects : {
        TargetProperties : [
            'in/Status'
        ]
    };
    completeProject @Common.SideEffects : {
        TargetProperties : [
            'in/Status'
        ]
    };
};


annotate service.Projects with {
    ProjectManager @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Employees',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ProjectManager_ID,
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




annotate service.WorkPackages with @(

    UI.LineItem : [
        {
            $Type: 'UI.DataField',
            Value: WPCode,
            Label: 'WP Code'
        },
        {
            $Type: 'UI.DataField',
            Value: Title,
            Label: 'Title'
        },
        {
            $Type: 'UI.DataField',
            Value: PlannedHours,
            Label: 'Planned Hours'
        },
        {
            $Type: 'UI.DataField',
            Value: ActualHours,
            Label: 'Actual Hours'
        },
        {
            $Type: 'UI.DataField',
            Value: AssignedTo.Name,
            Label: 'Assigned To'
        }
    ],

    UI.FieldGroup #EmployeeDetails : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : AssignedTo.EmpNo,
                Label : 'Employee No'
            },
            {
                $Type : 'UI.DataField',
                Value : AssignedTo.Name,
                Label : 'Employee Name'
            },
            {
                $Type : 'UI.DataField',
                Value : AssignedTo.Email,
                Label : 'Email'
            },
            {
                $Type : 'UI.DataField',
                Value : AssignedTo.Department,
                Label : 'Department'
            },
            {
                $Type : 'UI.DataField',
                Value : AssignedTo.Skills,
                Label : 'Skills'
            }
        ]
    },
     UI.HeaderInfo                : {
        TypeName      : 'Employee',
        TypeNamePlural: 'Employees',
        Title         : {Value :AssignedTo.Name},
        Description   : {Value :AssignedTo.EmpNo}
    },

    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'EmployeeDetails',
            Label  : 'Employee Details',
            Target : '@UI.FieldGroup#EmployeeDetails'
        }
    ]
);

// chart 

annotate service.Projects with @Aggregation.ApplySupported: {
    Transformations       : [
        'aggregate',
        'groupby'
    ],
 
    GroupableProperties   : [
        ProjectCode
    ],
 
    AggregatableProperties: [
        { Property: Budget },
        {Property: BudgetConsumed}
    ]
};



