sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
function (Controller) {
    "use strict";

    return Controller.extend("my.bookshop.project1.controller.View1", {
        onInit: function () {
            var oVizFrame = this.getView().byId("yourChartId");

           // Set custom background colors based on stock values
            oVizFrame.setVizProperties({
                plotArea: {
                    dataPointStyle: {
                        "rules": [
                            {
                                "dataContext": {"closingstock": {"min": 0, "max": 60}},
                                "properties": {
                                    "color": "#FF5733" // Red
                                }
                            },
                            {
                                "dataContext": {"closingstock": {"min": 61, "max": 120}},
                                "properties": {
                                    "color": "#FFFF00" // Yellow 
                                }
                            },
                            {
                                "dataContext": {"closingstock": {"min": 121, "max": 180}},
                                "properties": {
                                    "color": "#006400" // Green
                                }
                            }
                        ]
                    }
                }
            });

            // Create and connect popover
            var vizPopover = new sap.viz.ui5.controls.Popover({});
            vizPopover.connect(oVizFrame.getVizUid());
        }
    });
});
