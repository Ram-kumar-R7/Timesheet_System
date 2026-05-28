sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"employeetimesheet/test/integration/pages/TimesheetsList",
	"employeetimesheet/test/integration/pages/TimesheetsObjectPage",
	"employeetimesheet/test/integration/pages/TimesheetEntriesObjectPage"
], function (JourneyRunner, TimesheetsList, TimesheetsObjectPage, TimesheetEntriesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('employeetimesheet') + '/test/flp.html#app-preview',
        pages: {
			onTheTimesheetsList: TimesheetsList,
			onTheTimesheetsObjectPage: TimesheetsObjectPage,
			onTheTimesheetEntriesObjectPage: TimesheetEntriesObjectPage
        },
        async: true
    });

    return runner;
});

