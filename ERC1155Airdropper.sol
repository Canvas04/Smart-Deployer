// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.29;
import "@openzeppelin/contracts@5.3.0/token/ERC1155/ERC1155.sol";

import "./IUtilityContract.sol";

contract ERC1155Airdropper is IUtilityContract {
    IERC1155 public token;
    uint256 public number;
    ///ids [1,1]
    /// receivers ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
    /// [10,20]
    bool private initialized;
    error AlreadyInitialzed();
    modifier notInitialized() {
        require(!initialized, AlreadyInitialzed());
        _;
    }

    function initialize(bytes memory initData)
        external
        notInitialized
        returns (bool)
    {
        uint256 _number = abi.decode(initData, (uint256));
        initialized = true;
        number = _number;
        return true;
    }

  function getInitData(uint256 _number, address _bigBoss)
        external
        pure
        returns (bytes memory)
    {
        return abi.encode(_number, _bigBoss);
    }

    constructor(address _tokenAddress) {
        token = IERC1155(_tokenAddress);
    }

    function airdrop(
        uint256[] calldata ids,
        address[] calldata receivers,
        uint256[] calldata amounts
    ) external {
        require(
            token.isApprovedForAll(msg.sender, address(this)),
            "operator doesn`t approve to transfer tokens"
        );

        require(
            ids.length == receivers.length &&
                receivers.length == amounts.length,
            "arrays length mismatch"
        );

        for (uint256 i = 0; i < ids.length; i++) {
            token.safeTransferFrom(
                msg.sender,
                receivers[i],
                ids[i],
                amounts[i],
                ""
            );
        }
    }
}
