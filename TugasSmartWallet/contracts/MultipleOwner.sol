pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Authorizable is Ownable {

    event Authorized(address indexed authorized);
    event Unauthorized(address indexed unauthorized);

    mapping(address => bool) public authorizedAddresses;

    function authorize(address addressToAuthorize) public onlyOwner {
        authorizedAddresses[addressToAuthorize] = true;
        emit Authorized(addressToAuthorize);
    }

    function unauthorize(address addressToUnauthorize) public onlyOwner {
        authorizedAddresses[addressToUnauthorize] = false;
        emit Unauthorized(addressToUnauthorize);
    }

    function isAuthorized(address addressToCheck) public view returns (bool) {
        return authorizedAddresses[addressToCheck];
    }
}
