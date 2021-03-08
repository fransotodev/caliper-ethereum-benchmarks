const DatasetBidRegistry = artifacts.require("DatasetBidRegistry");

module.exports = function (deployer) {
  deployer.deploy(DatasetBidRegistry);
};
