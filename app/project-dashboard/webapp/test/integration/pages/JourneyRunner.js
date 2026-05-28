sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"projectdashboard/test/integration/pages/ProjectsList",
	"projectdashboard/test/integration/pages/ProjectsObjectPage",
	"projectdashboard/test/integration/pages/WorkPackagesObjectPage"
], function (JourneyRunner, ProjectsList, ProjectsObjectPage, WorkPackagesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('projectdashboard') + '/test/flp.html#app-preview',
        pages: {
			onTheProjectsList: ProjectsList,
			onTheProjectsObjectPage: ProjectsObjectPage,
			onTheWorkPackagesObjectPage: WorkPackagesObjectPage
        },
        async: true
    });

    return runner;
});

