const cds = require("@sap/cds");
require("dotenv").config(); // Load environment variables from .env file

module.exports = cds.service.impl(async function () {
  const { MaterialStock } = this.entities;

  // Connect to the external service
  const BPsrv = await cds.connect.to("API_MATERIAL_STOCK_SRV"); 

  this.on("READ", MaterialStock, async (req) => {
    // Use your .env API key here
    const apiKey = process.env.apikey;

    return await BPsrv.transaction(req).send({
      query: req.query,
      headers: {
        apikey: apiKey, // Use the API key from .env
      },
    });
  });
});
