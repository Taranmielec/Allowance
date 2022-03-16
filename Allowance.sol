//SPDX-License-Identifier: MIT

    pragma solidity 0.8.4;

    import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
    import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

    contract Allowance is Ownable {

    using SafeMath for uint;

    mapping (address => uint) public allowance;

    event AllowanceChange (address indexed _forWho, address indexed _fromWho, uint _oldAmount, uint _newAmount);

         function addAllowance(address _who, uint _amount) public onlyOwner {
             emit AllowanceChange (_who, msg.sender, allowance[_who], _amount);
            allowance[_who] = _amount;
        }

    modifier ownerOrAllowed(uint _amount) {
        require((owner() == msg.sender) || allowance[msg.sender] >= _amount, "you are not allowed");
        _;
    }
        function reduceAllowance(address _who, uint _amount) internal {
            emit AllowanceChange (_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
            allowance[_who] = allowance[_who].sub(_amount);
        }
    }
