sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"managerdashboard/test/integration/pages/PendingTimesheetsList",
	"managerdashboard/test/integration/pages/PendingTimesheetsObjectPage",
	"managerdashboard/test/integration/pages/TimesheetEntriesObjectPage"
], function (JourneyRunner, PendingTimesheetsList, PendingTimesheetsObjectPage, TimesheetEntriesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('managerdashboard') + '/test/flp.html#app-preview',
        pages: {
			onThePendingTimesheetsList: PendingTimesheetsList,
			onThePendingTimesheetsObjectPage: PendingTimesheetsObjectPage,
			onTheTimesheetEntriesObjectPage: TimesheetEntriesObjectPage
        },
        async: true
    });

    return runner;
});

