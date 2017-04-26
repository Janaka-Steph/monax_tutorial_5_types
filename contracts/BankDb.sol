pragma solidity ^0.4.6;

import './DougEnabled.sol';
import './ContractProvider.sol';

// The bank database
contract BankDb is DougEnabled {

    mapping (address => uint) public balances;

    function deposit(address addr) payable returns (bool res) {
        if(DOUG != 0x0){
            address bank = ContractProvider(DOUG).contracts("bank");
            if (msg.sender == bank ){
                balances[addr] += msg.value;
                return true;
            }
        }
        // Return if deposit cannot be made.
        if (!msg.sender.send(msg.value))
          throw;
        return false;
    }

    function withdraw(address addr, uint amount) returns (bool res) {
        if(DOUG != 0x0){
            address bank = ContractProvider(DOUG).contracts("bank");
            if (msg.sender == bank ){
                uint oldBalance = balances[addr];
                if(oldBalance >= amount){
                    if (!msg.sender.send(amount))
                      throw;
                    balances[addr] = oldBalance - amount;
                    return true;
                }
            }
        }
        return false;
    }

}
