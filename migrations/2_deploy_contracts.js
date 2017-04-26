var Bank = artifacts.require("./Bank.sol");
var BankDb = artifacts.require("./BankDb.sol");
var ContractProvider = artifacts.require("./ContractProvider.sol");
var Doug = artifacts.require("./Doug.sol");
var DougEnabled = artifacts.require("./DougEnabled.sol");
var FundManager = artifacts.require("./FundManager.sol");
var FundManagerEnabled = artifacts.require("./FundManagerEnabled.sol");
var Permissions = artifacts.require("./Permissions.sol");
var PermissionsDb = artifacts.require("./PermissionsDb.sol");

module.exports = function(deployer) {
  deployer.deploy(Doug)
    .then(() => {
        deployer.deploy(Bank);
        deployer.deploy(BankDb);
        deployer.deploy(ContractProvider);
        deployer.deploy(DougEnabled);
        deployer.deploy(FundManager);
        deployer.deploy(FundManagerEnabled);
        deployer.deploy(Permissions);
        deployer.deploy(PermissionsDb);
  })
};
