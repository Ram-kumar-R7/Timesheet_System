const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const {Timesheets,TimesheetEntries,WorkPackages,Projects,Employees } = this.entities;

  this.before('submitTimesheet', async (req) => {

    const ID = req.params[0].ID;

    const timesheet = await SELECT.one.from(Timesheets).where({ ID });

    if (!timesheet) {
      return req.error(404, 'Timesheet not found');
    }

    const entries = await SELECT.from(TimesheetEntries).where({ Timesheet_ID: ID });

    if (!entries.length) {
      return req.error(400, 'Timesheet must have at least one entry');
    }

    let totalHours = 0;

    for (const entry of entries) {
      totalHours += Number(entry.Hours || 0);

      const wp = await SELECT.one.from(WorkPackages).where({ ID: entry.WorkPackage_ID });

      if (!wp) {
        return req.error(400, 'Invalid WorkPackage');
      }
    }

    if (totalHours > 40) {
      return req.error(400, 'Total weekly hours cannot exceed 40');
    }

    await UPDATE(Timesheets).set({ TotalHours: totalHours }).where({ ID });
  });

  this.on('submitTimesheet', async (req) => {

    const ID = req.params[0].ID;

    await UPDATE(Timesheets).set({ Status: 'SUBMITTED' }).where({ ID });

    return await SELECT.one.from(Timesheets).where({ ID });
  });


  this.on('approveTimesheet', async (req) => {

    const ID = req.params[0].ID;
    const { comments } = req.data;

    const timesheet = await SELECT.one.from(Timesheets).where({ ID });

    if (!timesheet) {
      return req.error(404, 'Timesheet not found');
    }

    if (timesheet.Status !== 'SUBMITTED') {
      return req.error(400, 'Only submitted timesheets can be approved');
    }

    const employee = await SELECT.one.from(Employees).where({ ID: timesheet.Employee_ID });

    if (!employee) {
      return req.error(400, 'Employee not found');
    }

    const entries = await SELECT.from(TimesheetEntries).where({ Timesheet_ID: ID });

    if (!entries.length) {
      return req.error(400, 'Timesheet has no entries');
    }

    if (!comments) {
      return req.error(400, 'Approval comments are required');
    }
    await UPDATE(Timesheets).set({Status: 'APPROVED',ApprovalComments: comments}).where({ ID });

    const projectCostMap = {};

    for (const entry of entries) {

      const wp = await SELECT.one.from(WorkPackages).where({ ID: entry.WorkPackage_ID });

      if (!wp) {
        return req.error(400, 'WorkPackage not found');
      }

      const updatedActualHours = Number(wp.ActualHours || 0) + Number(entry.Hours || 0);

      await UPDATE(WorkPackages).set({ ActualHours: updatedActualHours }).where({ ID: entry.WorkPackage_ID });

      const cost = Number(entry.Hours || 0) * Number(employee.HourlyRate || 0);

      const projectID = wp.Project_ID;

      if (!projectCostMap[projectID]) {
        projectCostMap[projectID] = 0;
      }

      projectCostMap[projectID] += cost;
    }

    for (const projectID of Object.keys(projectCostMap)) {

      const project = await SELECT.one
        .from(Projects)
        .where({ ID: projectID });

      if (!project) {
        return req.error(400, 'Project not found');
      }

      const updatedBudgetConsumed =
        Number(project.BudgetConsumed || 0) + projectCostMap[projectID];

      await UPDATE(Projects).set({ BudgetConsumed: updatedBudgetConsumed }).where({ ID: projectID });
    }

    await UPDATE(Timesheets).set({ Status: 'APPROVED' }).where({ ID });

    return await SELECT.one.from(Timesheets).where({ ID });

  });

  this.on('rejectTimesheet', async (req) => {

    const ID = req.params[0].ID;
    const { comments } = req.data;

    const timesheet = await SELECT.one.from(Timesheets).where({ ID });

    if (!timesheet) {
      return req.error(404, 'Timesheet not found');
    }

    if (timesheet.Status !== 'SUBMITTED') {
      return req.error(400, 'Only submitted timesheets can be rejected');
    }

    if (!comments) {
      return req.error(400, 'Rejection comments are required');
    }

    await UPDATE(Timesheets).set({Status: 'REJECTED', ApprovalComments: comments}).where({ ID });

    return await SELECT.one.from(Timesheets).where({ ID });
  });

});




