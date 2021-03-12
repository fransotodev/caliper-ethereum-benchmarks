//Not using this script, it probably overlap

const fs = require("fs");
const { execSync } = require("child_process");

const listConfigs = fs.readdirSync(
  `${__dirname}/../caliperWorkspace/benchmarks/config_POA_benchmarks`
);

listConfigs.map(async (configFile, index) => {
  console.log(index);
  execSync(
    `npx caliper launch manager --caliper-workspace ${__dirname}/../caliperWorkspace/ --caliper-benchconfig benchmarks/config_POA_benchmarks/${configFile} --caliper-networkconfig networks/networkConfigGeth.json`,
    { stdio: "inherit" }
  );
  fs.copyFileSync(
    `${__dirname}/../caliperWorkspace/report.html`,
    `${__dirname}/../caliperWorkspace/benchmarks/results_POA_benchmarks/report${
      index + 1
    }.html`
  );
  return null;
});
