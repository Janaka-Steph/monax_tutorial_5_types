pragma solidity ^0.4.6;

import './DougEnabled.sol';
import './ContractProvider.sol';
import './Permissions.sol';
import './PermissionsDb.sol';
import './Bank.sol';


// The fund manager
contract FundManager is DougEnabled {

    // We still want an owner.
    address owner;

    // Constructor
    function FundManager(){
        owner = msg.sender;
    }

    // Attempt to withdraw the given 'amount' of Ether from the account.
    function deposit() payable returns (bool res) {
        if (msg.value == 0){
            return false;
        }
        address bank = ContractProvider(DOUG).contracts("bank");
        address permsdb = ContractProvider(DOUG).contracts("permsdb");
        if ( bank == 0x0 || permsdb == 0x0 || PermissionsDb(permsdb).perms(msg.sender) < 1) {
            // If the user sent money, we should return it if we can't deposit.
            msg.sender.send(msg.value);
            return false;
        }

        // Use the interface to call on the bank contract. We pass msg.value along as well.
        bool success = Bank(bank).deposit.value(msg.value)(msg.sender);

        // If the transaction failed, return the Ether to the caller.
        if (!success) {
            msg.sender.send(msg.value);
        }
        return success;
    }

    // Attempt to withdraw the given 'amount' of Ether from the account.
    function withdraw(uint amount) payable returns (bool res) {
        if (amount == 0){
            return false;
        }
        address bank = ContractProvider(DOUG).contracts("bank");
        address permsdb = ContractProvider(DOUG).contracts("permsdb");
        if ( bank == 0x0 || permsdb == 0x0 || PermissionsDb(permsdb).perms(msg.sender) < 1) {
            // If the user sent money, we should return it if we can't deposit.
            msg.sender.send(msg.value);
            return false;
        }

        // Use the interface to call on the bank contract.
        bool success = Bank(bank).withdraw(msg.sender, amount);

        // If the transaction succeeded, pass the Ether on to the caller.
        if (success) {
            msg.sender.send(amount);
        }
        return success;
    }

    // Set the permissions for a given address.
    function setPermission(address addr, uint8 permLvl) returns (bool res) {
        if (msg.sender != owner){
            return false;
        }
        address perms = ContractProvider(DOUG).contracts("perms");
        if ( perms == 0x0 ) {
            return false;
        }
        return Permissions(perms).setPermission(addr,permLvl);
    }
}