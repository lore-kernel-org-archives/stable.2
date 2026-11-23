Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428419;
	b=oLxlTgFmWWBYvqA4SDPRfNoXqVX/bbzTh4TKdRrvqB4iiG8xPTQW07xT5bRjNuZPkL+H
	 5IuofFtv1y6bsJNqvQrH1Ao0Fcxr/Rgeg6XhRha1rw5pb9VrKDhFJlAGd6Gr+pOBqtu/x
	 CGWR6+F08jrDLCpJrirCK2jxo/bbfDiSt0VK2X0ixaDIwfa44+fvGCcQSYqxIQNYviFHf
	 29QquMNqX8bU507HnRiDtTtAD9D+mLVfmrnZOWMIDt5Wg0IbE7ZfNr+jfbaoxVkcAjuB+
	 4CT7vsp2/Lxqav+xrvaqt2kfiCMupz4aTKpE90oIrFy8UUtk2Rb305RS9ioA7Rj1l+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428419;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vctwdCkQx24yaGhbYfazmBWlj/Lh+OTA9NgY45mgVYs=;
	b=EQXFDbpdoQrodbzH5eREDHV0YDRyr87E5qSVdmLp9dfKRoCd1RwyRNdS9AluDhEaryZT
	 AGIDxjY9xH/NJOpY0HJjE/Gy6hCRKD686sHeJOz4ko7phWJjnq3dmPcg4+vmJVSyO37Ui
	 lLll9hgDCr7zvLo9Zc9YCX/cnf8Av6PF662luR/DK9P9RN4VeyZ4MhzqfLBoTx6WBGxgs
	 qCP9WESaIaTxE3mPdAMogQltjzUQBdWwlUs1N49BXd+HZbcwTxn8Td2ZMiUI2OvIjd7O+
	 kD8eiJAweYsrjk8CAwfwVvFuEerY7+kV3whUUo9uLWfcNDzR1cZEcGkDBg8U/qo1DIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h902wYg3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070C606A336;
	Mon, 23 Nov 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h902wYg3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37931F000D1;
	Mon, 23 Nov 2026 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428418;
	bh=vctwdCkQx24yaGhbYfazmBWlj/Lh+OTA9NgY45mgVYs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h902wYg3EeR42ee+cZNAQXroQOZoRhDWCGwKrGL2jCbtvet7e8IUKMCkvZoegC+SG
	 E9eILrT9B4c/wW+F1I1e8hDjwsZxM9mVkkpbKcWmsSZxK4HQ0KU5vPEL3CTwGSKXla
	 sMjyzRdxGbxGAxnPZ5pIotKBbzsO91C2+gZY6L6hizd+BJhVhVaxkVTM5UJgR1WvCp
	 BCN0oL6ZzggsBqe4O2v472KmNEyJ1mleq/LCsd6PyG5qlV/UvifoUtBOb2bskwWJUZ
	 fn7XmiUPD8Ce4fDf5GUxRsn9OaBjwBCwoXWbgSSiH0fuQbjAjKP0n9ouWCoiPfxIDe
	 xhxcMZwN2MZ8Q==
Subject: Re: [PATCH net v2 1/2] net: stmmac: Limit the MTU of normal
 descriptors to one buffer
From: netdev-bot+sashiko@kernel.org
To: aiyengar1990@gmail.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, clabbe.montjoie@gmail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, nb@tipi-net.de, stable@vger.kernel.org
Date: Mon, 23 Nov 2026 10:06:57 +0000
Message-ID: <179542841718.3135.3290374626862889297@kernel.org>
In-Reply-To: <20261122-sun8i-emac-mtu-limit-v2-1-c4081e5b83cf@gmail.com>
References: <20261122-sun8i-emac-mtu-limit-v2-1-c4081e5b83cf@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ring mode, normal RX descriptors still give the DMA a
  1-byte buffer2 that has no address.
- [Medium] The commit says stmmac does not split TX frames for normal
  descriptors, so a frame must fit one 2047-byte buffer.
- [Medium] The new normal-descriptor limit, max_mtu = 2047 - ETH_HLEN -
  2*VLAN_HLEN - ETH_FCS_LEN = 2021, leaves zero slack.
- [Medium] net: stmmac: unaligned 2047-byte RX buffer limit in
  __stmmac_dvr_probe()

--

net: stmmac: Limit the MTU of normal descriptors to one buffer

This patch sets max_mtu for normal descriptors to BUF_SIZE_2KiB - 1 -
ETH_HLEN - 2 * VLAN_HLEN - ETH_FCS_LEN. The old limit was SKB_MAX_HEAD().
The goal is to fit a double-tagged frame plus FCS into one 2047-byte
buffer.

Link: https://lore.kernel.org/r/E1vLJcL-0000000ExBL-0GFe@rmk-PC.armlinux.org.uk [1]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a685ce4638f61..2a27e1e7f9b9f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8247,6 +8247,9 @@ static int __stmmac_dvr_probe(struct device *device,
>  		ndev->max_mtu = XGMAC_JUMBO_LEN;
>  	else if (priv->plat->enh_desc || priv->synopsys_id >= DWMAC_CORE_4_00)
>  		ndev->max_mtu = JUMBO_LEN;
> +	else if (priv->hw->desc == &ndesc_ops)
> +		ndev->max_mtu = BUF_SIZE_2KiB - 1 - ETH_HLEN - 2 * VLAN_HLEN -
> +				ETH_FCS_LEN;

[Severity: Medium]
The new limit assumes the RX DMA can fill all 2047 bytes of buffer1.
Does it on these cores?

common.h has:

	/* RX Buffer size must be multiple of 4/8/16 bytes */

That rule is why BUF_SIZE_8KiB and BUF_SIZE_16KiB are 8188 and 16368
rather than 2^N - 1. BUF_SIZE_2KiB - 1 does not follow it.

For any MTU above 1510, stmmac_setup_dma_desc() picks
dma_buf_sz == BUF_SIZE_2KiB. ndesc_init_rx_desc() then programs RBS1
as min(bfsize, BUF_SIZE_2KiB - 1), which is 2047. If the DMA only
writes whole bus-width words, buffer1 really holds 2044 bytes on a
32-bit bus, 2040 on a 64-bit bus and 2032 on a 128-bit bus.

With max_mtu = 2047 - 14 - 8 - 4 = 2021, a double-tagged frame with
FCS can be up to 2047 bytes. Anything past the usable part of buffer1
leaves the first descriptor without LS:

- In chain mode, ndesc_get_rx_status() takes the
  !RDES0_LAST_DESCRIPTOR path and returns discard_frame.
- In ring mode, ndesc_rx_set_on_ring() has set RBS2 to 1 while des3
  is still 0. The tail goes to address 0 or to the next descriptor.

The follow-up "net: stmmac: dwmac-sun8i: Limit the MTU to 2018" looks
like exactly this case. H616 fills only 2044 bytes, and
2044 - 26 = 2018. Other ndesc_ops users would hit the same problem.
On wider buses it starts at MTU 2015 (64-bit) or 2007 (128-bit), and
the sun8i change does nothing for them.

There is also dwmac1000_core_init(), which sets GMAC_CONTROL_JE once
mtu > 2000. MTU 2001-2021 is now allowed, so the MAC is told to
accept jumbo frames that can never fit one normal descriptor buffer.

Should the generic limit be based on a bus-width aligned size, for
example ALIGN_DOWN(BUF_SIZE_2KiB - 1, 16), instead of
BUF_SIZE_2KiB - 1? That gives 2006, which is still above the JE
threshold. Should max_mtu for normal descriptors also be capped at
2000, or should JE not be set when ndesc_ops is in use? And is the
DMA bus width known at this point, so that 32-bit cores don't lose
more MTU than they need to?

[Severity: Medium]
Does the RX ring still give the DMA a buffer2 with these MTUs? Every MTU
from 1511 up to the new limit of 2021 ends up with dma_buf_sz ==
BUF_SIZE_2KiB:

stmmac_setup_dma_desc()
    len = mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
    stmmac_set_bfsize(len)

ndesc_init_rx_desc() caps buffer1 at 2047. It then passes the uncapped
2048 to ndesc_rx_set_on_ring():

drivers/net/ethernet/stmicro/stmmac/descs_com.h:ndesc_rx_set_on_ring() {
	if (bfsize >= BUF_SIZE_2KiB) {
		int bfsize2;

		bfsize2 = min(bfsize - BUF_SIZE_2KiB + 1, BUF_SIZE_2KiB - 1);
		p->des1 |= cpu_to_le32(FIELD_PREP(RDES1_BUFFER2_SIZE_MASK,
						  bfsize2));
	}
	...
}

So RBS2 is set to 1.

RDES3 is never programmed for normal descriptors at this buffer size:

- ndesc_ops has no set_sec_addr.
- stmmac_init_rx_buffers() and refill_desc3() only write des3 when
  dma_buf_sz == BUF_SIZE_16KiB.

RDES3 therefore stays 0, or holds the timestamp seconds the hardware
writes back.

The comment in stmmac_rx_check_buf2_cap() says buffer2 is never handed
to the hardware on legacy cores, but ndesc_rx_set_on_ring() appears to do
exactly that.

dwmac1000_core_init() sets GMAC_CONTROL_JE when mtu > 2000. MTU
2001-2021 is now allowed, so the MAC accepts frames much larger than
2047 bytes.

If a peer sends a frame longer than 2047 bytes, can the DMA write one
byte to the unmapped RDES3 address? The rest of the frame would then go
to the next descriptor and be dropped through the !LS path in
ndesc_get_rx_status().

The databook says buffer sizes that are not a multiple of the bus width
give undefined results, so the exact hardware behaviour with RBS2 = 1 is
uncertain. The same RBS2 = 1 programming was also reachable before this
patch. Still, the commit relies on every frame fitting in buffer1.

Should ndesc_rx_set_on_ring() skip programming the buffer2 size for
normal descriptors unless RDES3 holds a valid mapped address?

The follow-up "net: stmmac: dwmac-sun8i: Limit the MTU to 2018" only
lowers maxmtu on sun8i and does not change this.

[Severity: Medium]
The commit message says:

  "stmmac neither splits TX frames nor joins RX descriptors for them, so
  a frame must fit one 2047-byte buffer."

Is max_mtu enough to enforce this on TX? In stmmac_xmit(), the jumbo
handling only runs for enhanced descriptors:

	if (enh_desc)
		is_jumbo = stmmac_is_jumbo_frm(priv, skb->len, enh_desc);

For normal descriptors, skb_headlen() and each frag size go straight to
stmmac_prepare_tx_desc(). Nothing checks them against 2047.

In ring mode, ndesc_prepare_tx_desc()->norm_set_tx_desc_len_on_ring()
then does:

	if (unlikely(len > buffer1_max_length)) {
		p->des1 |= cpu_to_le32(FIELD_PREP(TDES1_BUFFER2_SIZE_MASK,
						  len - buffer1_max_length) |
	...

ndesc_set_addr() only writes DES2. On this path DES3 stays 0 from the
coherent allocation, or is cleared to 0 by clean_desc3().

The stack does not guarantee skb length <= MTU at ndo_start_xmit:

- tcf_mirred_forward() in net/sched/act_mirred.c calls
  tcf_dev_queue_xmit() without an MTU check.
- BPF egress redirect can deliver oversized skbs.
- AF_PACKET with vnet_hdr GSO uses a user-chosen gso_size.
- A bridge with mixed port MTUs can pass GSO skbs through.

Can the NIC then DMA-read up to 2047 bytes from the unprogrammed DES3
address and put them on the wire?

Would stmmac_xmit() need a length check that drops oversized frames on
normal descriptors? Without it, the single-buffer assumption does not
hold on TX. The second patch in the series does not address this.

[Severity: Medium]
The new limit works out to 2047 - 14 - 8 - 4 = 2021, which leaves no
slack. Does it allow for Type-1 RX checksum offload engines?

ndesc_get_rx_frame_len() notes that those engines write two checksum
bytes after the frame, and those bytes are included in the frame length:

	/* The type-1 checksum offload engines append the checksum at
	 * the end of frame and the two bytes of checksum are added in
	 * the length.
	...
	if (rx_coe_type == STMMAC_RX_COE_TYPE1)
		csum = 2;

stmmac_hw_init() picks STMMAC_RX_COE_TYPE1 from dma_cap.rx_coe_type1,
independently of enh_desc. So a pre-4.00 GMAC without the alternate
descriptor feature can run ndesc_ops with Type-1 COE.
dwmac1000_rx_ipc_enable() then sets GMAC_CONTROL_IPC.

At MTU 2020 or 2021, a double-tagged frame with FCS is 2046-2047 bytes.
With the appended checksum it needs 2048-2049 bytes in the buffer.

ndesc_init_rx_desc() caps buffer1 at 2047. The leftover bytes would go
into the 1-byte buffer2 at RDES3, then into the next descriptor. The
first descriptor has no LS, so ndesc_get_rx_status() returns
discard_frame.

Wouldn't that drop QinQ frames at the advertised max MTU? That conflicts
with:

  "Limit max_mtu so that a frame with two VLAN tags and the FCS fits."

stmmac_setup_dma_desc() also sizes the RX buffers without counting the
Type-1 checksum bytes.

The follow-up "net: stmmac: dwmac-sun8i: Limit the MTU to 2018"
suggests the 2047 formula is already too tight on real hardware: H616
fills only 2044 bytes. That change only covers sun8i, which uses Type-2
COE.

Should the generic limit reserve 2 more bytes when rx_coe ==
STMMAC_RX_COE_TYPE1, or reserve them always?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf%40gmail.com
