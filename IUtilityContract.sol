// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IUtilityContract {
    function initialize(bytes memory initData) external returns(bool);
}