var Bank = artifacts.require("./Bank.sol")
var BankDb = artifacts.require("./BankDb.sol")
var ContractProvider = artifacts.require("./ContractProvider.sol")
var Doug = artifacts.require("./Doug.sol")
var DougEnabled = artifacts.require("./DougEnabled.sol")
var FundManager = artifacts.require("./FundManager.sol")
var FundManagerEnabled = artifacts.require("./FundManagerEnabled.sol")
var Permissions = artifacts.require("./Permissions.sol")
var PermissionsDb = artifacts.require("./PermissionsDb.sol")

module.exports = function (deployer) {
  deployer.deploy(Doug)
    .then(() => {
      deployer.deploy(ContractProvider)
      deployer.deploy(DougEnabled)
      deployer.deploy(FundManagerEnabled)

      deployer.deploy(Bank)
        .then(() => Doug.at(Doug.address).addContract('bank', Bank.address))
      deployer.deploy(BankDb)
        .then(() => Doug.at(Doug.address).addContract('bankdb', BankDb.address))
      deployer.deploy(FundManager)
        .then(() => Doug.at(Doug.address).addContract('fm', FundManager.address))
      deployer.deploy(Permissions)
        .then(() => Doug.at(Doug.address).addContract('perms', Permissions.address))
      deployer.deploy(PermissionsDb)
        .then(() => Doug.at(Doug.address).addContract('permsdb', PermissionsDb.address))
    })
}
