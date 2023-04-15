// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string private _baseTokenURI;
    mapping(uint256 => string) private _tokenURIs;


    constructor(string memory name, string memory symbol, string memory baseTokenURI) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
    }

    function mint(address recipient, string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _mint(recipient, newTokenId);
        setTokenURI(newTokenId, tokenURI);
        return newTokenId;
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) public {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        setTokenURI(tokenId, tokenURI);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, _tokenURIs[tokenId])) : "";
    }
}
