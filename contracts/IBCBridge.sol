//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

import "./base/UniversalChanIbcApp.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract IBCBridge is UniversalChanIbcApp, ERC20 {
    constructor(
        address _middleware
    ) UniversalChanIbcApp(_middleware) ERC20("IBC Polymer Token", "IPT") {
        _mint(msg.sender, 10000000000 * 10 ** decimals());
    }

    /**
     * @dev Sends a packet with the caller's address over the universal channel.
     * @param destPortAddr The address of the destination application.
     * @param channelId The ID of the channel to send the packet to.
     * @param amount The amount that user wants to bridge to the destination chain.
     */
    function ibcBridgeSend(
        address destPortAddr,
        bytes32 channelId,
        uint256 amount
    ) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        bytes memory data = abi.encode(msg.sender, amount);
        uint64 timeoutTimestamp = uint64(
            (block.timestamp + 36000) * 1000000000
        );

        IbcUniversalPacketSender(mw).sendUniversalPacket(
            channelId,
            IbcUtils.toBytes32(destPortAddr),
            data,
            timeoutTimestamp
        );
    }

    /**
     * @dev Packet lifecycle callback that implements packet receipt logic and returns and acknowledgement packet.
     *      MUST be overriden by the inheriting contract.
     *
     * @param channelId the ID of the channel (locally) the packet was received on.
     * @param packet the Universal packet encoded by the source and relayed by the relayer.
     */
    function onRecvUniversalPacket(
        bytes32 channelId,
        UniversalPacket calldata packet
    ) external override onlyIbcMw returns (AckPacket memory ackPacket) {
        recvedPackets.push(UcPacketWithChannel(channelId, packet));
        (address account, uint256 amount) = abi.decode(
            packet.appData,
            (address, uint256)
        );
        _mint(account, amount);
        return AckPacket(true, abi.encode(packet.appData));
    }

    /**
     * @dev Packet lifecycle callback that implements packet acknowledgment logic.
     *      MUST be overriden by the inheriting contract.
     *
     * @param channelId the ID of the channel (locally) the ack was received on.
     * @param packet the Universal packet encoded by the source and relayed by the relayer.
     * @param ack the acknowledgment packet encoded by the destination and relayed by the relayer.
     */
    function onUniversalAcknowledgement(
        bytes32 channelId,
        UniversalPacket memory packet,
        AckPacket calldata ack
    ) external override onlyIbcMw {
        ackPackets.push(UcAckWithChannel(channelId, packet, ack));
        (address account, uint256 amount) = abi.decode(
            packet.appData,
            (address, uint256)
        );
        _burn(account, amount);
    }

}
