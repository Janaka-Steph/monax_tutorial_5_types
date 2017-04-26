pragma solidity ^0.4.6;

// Interface for getting contracts from Doug
contract ContractProvider {
    function contracts(bytes32 name) returns (address addr) {}
}