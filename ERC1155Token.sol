// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.29;

import {ERC1155} from "@openzeppelin/contracts@5.3.0/token/ERC1155/ERC1155.sol";
import {Ownable} from "@openzeppelin/contracts@5.3.0/access/Ownable.sol";

contract ERC1155Token is ERC1155, Ownable {
    constructor()
        ERC1155(" ipfs://QmYsXqkGWEJMpacnyFjot8bY34CEASWmVjKLWyKMTnUNHK/")
        Ownable(msg.sender)
    {}

    function mint(address account, uint256 id, uint256 amount)
        public
        onlyOwner
    {
        _mint(account, id, amount, "");
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }
}