sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/viz/ui5/data/FlattenedDataset",
    "sap/viz/ui5/controls/common/feeds/FeedItem",
    "sap/viz/ui5/controls/Popover",
    "sap/viz/ui5/controls/VizFrame",
    "sap/viz/ui5/format/ChartFormatter",
    "sap/viz/ui5/api/env/Format"
], function (Controller) {
    "use strict";

    return Controller.extend("db.sapui5app.controller.View1", {
        onInit: function () {
            var oViewModel = new sap.ui.model.json.JSONModel();
            oViewModel.setProperty("/selectedChartType", "line");
            this.getView().setModel(oViewModel, "viewModel");
            var oVizFrame = this.getView().byId("idVizFrame");
            var vizPopover = new sap.viz.ui5.controls.Popover({});
            vizPopover.connect(oVizFrame.getVizUid());
        },
        onChartTypeChanged: function(oEvent) {
            var sSelectedChartType = oEvent.getParameter("selectedItem").getKey();
            var oViewModel = this.getView().getModel("viewModel");
            oViewModel.setProperty("/selectedChartType", sSelectedChartType);
        },
        onShowPopover: function(oEvent) {
            var oButton = oEvent.getSource();
            if (!this._oPopover) {
                this._oPopover = new Popover({
                    content: [
                        new Button({ text: "Popover Content" })
                    ]
                });
            }
            this._oPopover.openBy(oButton);
        },

        onDataLabelChanged: function (oEvent) {
            var oVizFrame = this.getView().byId("idVizFrame");
            oVizFrame.setVizProperties({
                plotArea: {
                    dataLabel: {
                        visible: oEvent.getParameter("state")
                    }
                }
            });
        },

        onSumLabelChanged: function (oEvent) {
            var oVizFrame = this.getView().byId("idVizFrame");
            var sumLabelSwitch = oEvent.getParameter("state");
            oVizFrame.setVizProperties({
                plotArea: {
                    dataLabel: {
                        showTotal: sumLabelSwitch
                    }
                }
            });
        },

        onAxisTitleChanged: function (oEvent) {
            var that = this;
            var oVizFrame = that.getView().byId("idVizFrame");
            var state = oEvent.getParameter("state");
            oVizFrame.setVizProperties({
                valueAxis: {
                    title: {
                        visible: state
                    }
                },
                categoryAxis: {
                    title: {
                        visible: state
                    }
                }
            });
        },

        onTypeSelected: function(oEvent) {
            var that = this;
            var typeRadio = oEvent.getSource().getSelectedButton().getProperty("text");
            var oVizFrame = that.getView().byId("idVizFrame");
            
            if (typeRadio === "regular") {
                if (oVizFrame.getVizType() !== "line") {
                    oVizFrame.setVizType("line");
                    oVizFrame.setVizProperties({}); // Clear any previous vizProperties
                }
            } else {
                if (oVizFrame.getVizType() !== "stacked_bar") {
                    oVizFrame.setVizType("stacked_bar");
                    oVizFrame.setVizProperties({
                        plotArea: {
                            mode: "percentage",
                            drawingEffect: "glossy",
                            dataLabel: {
                                type: "percentage",
                                visible: true
                            }
                        }
                    });
                }
            }
        }
    });
});
