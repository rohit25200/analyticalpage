sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'my/material/test/integration/FirstJourney',
		'my/material/test/integration/pages/MaterialList',
		'my/material/test/integration/pages/MaterialObjectPage'
    ],
    function(JourneyRunner, opaJourney, MaterialList, MaterialObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('my/material') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheMaterialList: MaterialList,
					onTheMaterialObjectPage: MaterialObjectPage
                }
            },
            opaJourney.run
        );
    }
);