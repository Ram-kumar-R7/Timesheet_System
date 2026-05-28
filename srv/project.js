const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const {Projects,WorkPackages,TimesheetEntries} = this.entities;

  this.on('startProject', async (req) => {

    const { ID } = req.params[0];

    const project = await SELECT.one.from(Projects).where({ ID });

    if (!project) {
      return req.error(404, 'Project not found');
    }

    const today = new Date()

    if (project.StartDate < today) {
      return req.error(400, 'Project start date cannot be in the past');
    }

    const workPackages = await SELECT.from(WorkPackages).where({ Project_ID: ID });

    if (!workPackages.length) {
      return req.error(400,'Project must have at least one WorkPackage before starting' );
    }

    if (project.Status !== 'PLANNED') {
      return req.error(400,'Only PLANNED projects can be started');
    }

    await UPDATE(Projects).set({ Status: 'IN_PROGRESS' }).where({ ID });

    return await SELECT.one.from(Projects).where({ ID });
  });

  this.on('completeProject', async (req) => {

    const { ID } = req.params[0];

    const project = await SELECT.one.from(Projects).where({ ID });

    if (!project) {
      return req.error(404, 'Project not found');
    }

    if (project.Status !== 'IN_PROGRESS') {
      return req.error(400,'Only IN_PROGRESS projects can be completed');
    }

    await UPDATE(Projects).set({ Status: 'COMPLETED' }).where({ ID });

    return await SELECT.one.from(Projects).where({ ID });
  });

  this.on('getBudgetVariance', async (req) => {

    const { projectID } = req.data;

    const project = await SELECT.one.from(Projects).where({ ID: projectID });

    if (!project) {
      return req.error(404, 'Project not found');
    }

    const entries = await SELECT.from(TimesheetEntries).columns('Hours','Timesheet.Employee.HourlyRate as HourlyRate')
      .where({'WorkPackage.Project_ID': projectID,'Timesheet.Status': 'APPROVED'});

    const actualCost = entries.reduce((sum, entry) => {
      return sum + Number(entry.Hours || 0) * Number(entry.HourlyRate || 0);
    }, 0);

    const variance = Number(project.Budget || 0) - actualCost;

    return variance;
  });

});