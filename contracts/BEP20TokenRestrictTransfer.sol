// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "./BEP20Token.sol";

contract BEP20TokenRestrictTransfer is BEP20Token {
    using SafeMath for uint256;

    bool private _enable = false;

    function _beforeTokenTransfer(address sender, address recipient, uint256 amount) internal override {
        if(_enable) {
            return;
        }

        if(isOwner(sender)) {
            return;
        }
    }

    function _beforeTokenTransferFrom(address caller, address sender, address recipient, uint256 amount) internal override {
        if(_allowances[sender][caller] >= amount) {
            return;
        }

        revert("Cannot transfer");
    }


    function enableTransfer() public onlyOwner {
        _enable = true;
    }

    function disableTransfer() public onlyOwner {
        _enable = false;
    }
}