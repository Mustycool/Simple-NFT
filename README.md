# simple-NFT Smart Contract

This repository contains a smart contract for minting a basic non-fungible token (NFT) that complies with the [SIP-009](https://github.com/stacksgov/sips/blob/main/sips/sip-009/sip-009-nft-standard.md) NFT standard on the Stacks blockchain. The contract includes functionality for minting, transferring, and retrieving token metadata and ownership details.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Smart Contract Details](#smart-contract-details)
  - [Constants](#constants)
  - [Variables](#variables)
  - [Data Maps](#data-maps)
  - [Public Functions](#public-functions)
- [Error Codes](#error-codes)
- [Usage](#usage)
  - [Minting an NFT](#minting-an-nft)
  - [Transferring an NFT](#transferring-an-nft)
  - [Retrieving Metadata](#retrieving-metadata)
- [License](#license)

## Overview

The `simple-NFT` contract allows users to mint NFTs at a fixed price and transfer ownership to others. Each token URI is dynamically generated based on an IPFS root URL and the token's unique ID, ensuring that metadata for each token can be retrieved consistently. The contract enforces a maximum minting limit of 100 NFTs to control the collection's size.

## Features

- **NFT Minting**: Users can mint new NFTs, with each NFT assigned a unique ID and associated with metadata hosted on IPFS.
- **Token Transfer**: Ownership of NFTs can be transferred between principals.
- **Metadata Retrieval**: Each NFT has a token URI for retrieving metadata based on the IPFS URL and token ID.
- **SIP-009 Compliance**: Implements functions required by the SIP-009 standard for interoperability and consistency.

## Smart Contract Details

### Constants

- **`nft-creator`**: Sets the creator of the NFT as the transaction sender.
- **`simple-nft-price`**: Defines the price to mint an NFT, set to 10 STX.
- **`collection-limit`**: Limits the number of NFTs in the collection to 100.
- **`collection-root-url`**: Base URL for metadata files hosted on IPFS, forming the root of each token's URI.

### Variables

- **`collection-index`**: Tracks the current number of NFTs minted, starting from zero.

### Data Maps

- **`simple-nft`**: Defines the non-fungible token type using unique `uint` identifiers.

### Public Functions

- **`mint-simple-nft`**: Allows users to mint a new NFT if they pay the required fee and the collection is not fully minted.
- **`get-last-token-id`**: Returns the ID of the last minted token in the collection.
- **`get-token-uri`**: Generates and returns the token URI for a given token ID by appending `.json` to the `collection-root-url` and the token ID.
- **`get-owner`**: Returns the owner of a specified token ID.
- **`transfer`**: Transfers ownership of a specified token ID from the sender to a recipient.

## Error Codes

- **`u0`**: Indicates that the caller is not the owner of the NFT they are attempting to transfer.
- **`u1`**: Indicates that the collection has reached its minting limit.
- **`u2`**: Indicates an error in transferring the minting fee.
- **`u3`**: Indicates an error in minting the NFT.

## Usage

### Minting an NFT

To mint a new NFT, a user can call the `mint-simple-nft` function, which:
1. Verifies that the collection limit has not been reached.
2. Transfers the minting fee from the user to the contract.
3. Mints a new NFT for the user and increments the collection index.

### Transferring an NFT

To transfer ownership of an NFT, use the `transfer` function:
- **Parameters**:
  - `id` - The unique identifier of the NFT to be transferred.
  - `sender` - The current owner of the NFT.
  - `recipient` - The principal receiving the NFT.

The function checks if the caller is the current owner and, if successful, transfers the NFT to the specified recipient.

### Retrieving Metadata

To retrieve the metadata URI for a specific token, use the `get-token-uri` function:
- **Parameter**: `id` - The unique identifier of the NFT.
- Returns the metadata URI, constructed from the root URL and token ID.

## License

This contract is open source and available for use under the MIT License.
