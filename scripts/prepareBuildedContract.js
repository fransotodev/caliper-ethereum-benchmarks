const fs = require("fs");

const file = JSON.parse(
  fs.readFileSync(
    `${__dirname}/../caliperWorkspace/src/DatasetBidRegistry.json`
  )
);
file.gas = 3000000;
fs.writeFileSync(
  `${__dirname}/../caliperWorkspace/src/DatasetBidRegistry.json`,
  JSON.stringify(file, null, 2)
);
