Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096164;
	b=rvhF+pkP3YiKqhTAoJ7xrLhzYquD+uu4C+Nftwg3q5206xJIV99oYNqDDdrdrCBfdN88
	 WiWNkcHZjQMwhcmLyGXnZIHo527e1O0YdacdeZO4GSYFv8seX1TE5+qT07IfKfGBhUjun
	 oE08nN6viq41OxDlytvBl/QzopZWYhbP5EGEokS3WexpRq8zR72XNiL6csorqfLLfxtGa
	 ZwNtFRFFqqpTrZAGeZM2BaNE0mJZVV1RXgPgSoDg+yUXZXTvPvFYdjlqEZEMp9LpZVjBG
	 MLAQYfiipUIOfyGB73j4uZwdM5hQTBbkPNOxTyGT+zP8ORkeZTv0W4t5RjNh3FTWXGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096164;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BA/tPw/dZNvXJEztZ2BwkPYu53BGcCL258NB85M1ivg=;
	b=C826pTwXLqaISzgqdZj6UDf32GuK95LBrB4dm2JkfTfsK3V7iQBCbpis/oPup1WfCyg9
	 B+jB2DrAOOae/3e4SYRFw7QjCKwodIq7optoIS1BzCN2Fe/HLVnI8+7Aks1ESSK/XGcSF
	 tU9I61aoJGYWaBY4E5bsmZNx/8uSIAY+68ePNlG4fefuol/IXz+DVorHlo3XTizHazp39
	 xFNnK7whr7roLY1tttj4G1TOTeyXBO0C+G/YjOjkbGugf/jDKqdM8ny1cVxMM6wtGNTwX
	 oAfnv+7IACjgqXbLjK6ZqDnHqkwGt/qFfczDF7VKjJiuXcoHkiY7bjOoWFBgPtFJSuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hb8aXiTD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8E606A31A;
	Tue, 27 Oct 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hb8aXiTD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A6A1F01825;
	Tue, 27 Oct 2026 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793096164;
	bh=BA/tPw/dZNvXJEztZ2BwkPYu53BGcCL258NB85M1ivg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hb8aXiTDbUaY8eeaZmjnrA645MATKKHCPCwApyWD6E8g1fZO8wgw4Ns3p4RL5Z+df
	 zuyjwIeaT5MTS/PxjsWUFU2Oex9n2Q41+RMa05C+f3a+rYtTZJt76ELz8FmHmObArd
	 Yp6e+uAnulsAm/69NrjsOI1JJetVOhmnDuOMMa6MioGTVT40p6tuzS0kAjOgiwGSHV
	 mx2xzmyhSPn4qoAhWNivkxSd6NV1QRh/YC1p6WTcgFPaIDx/doq/wwN+CqJ2lCag00
	 6UoJNM2VWo2Sp2xFHTXmHhAkcu+RBvg5x0lWvFUM5bYR7o24P/EJ8DH5luZLCLL+U+
	 mdN2FVQIhp2Mw==
Subject:
 Re: [PATCH net] net: atl1c: drop oversized RX frames instead of panicking
From: netdev-bot+sashiko@kernel.org
To: federico@rimpianto.com
Cc: chris.snook@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 27 Oct 2026 10:16:03 +0000
Message-ID: <179309616319.3134.17215984373035106773@kernel.org>
In-Reply-To: <20261023093000.73535-1-federico@rimpianto.com>
References: <20261023093000.73535-1-federico@rimpianto.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check in atl1c_clean_rx() compares the reported length
  against skb_tailroom(skb), but the device only gets…
- [High] In atl1c_clean_rx(), atl1c_clean_rfd() runs before the new
  check: it marks the RFD slot ATL1C_BUFFER_FREE and advances…
- [Medium] The new drop path does `netdev->stats.rx_length_errors++` and
  `netdev->stats.rx_dropped++`.
- [Low] The patch also adds a lower-bound check, `length < ETH_HLEN +
  ETH_FCS_LEN`, in atl1c_clean_rx().
- [Low] The new error path in atl1c_clean_rx() frees the rejected frame
  with dev_kfree_skb(), which include/linux/skbuff.h line 1485 defines…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the existing
  hardware-error branch in atl1c_clean_rx() (`if (rrs->word3 &…

--

net: atl1c: drop oversized RX frames instead of panicking

This patch adds a length check to atl1c_clean_rx() before skb_put(). A
frame whose RX return descriptor reports a length that does not fit in
skb_tailroom(), or that is shorter than ETH_HLEN + ETH_FCS_LEN, is now
dropped and counted instead of triggering skb_over_panic. It targets
peers whose L2 MTU is larger than the host MTU.

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index e58f1d2c26bdf..11de6439ddd3c 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -1934,6 +1934,24 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>  			break;
>  		}
>  		atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
> +
> +		/* A peer with a larger L2 MTU than ours can hand us a frame
> +		 * that does not fit the buffer allocated for this MTU.  The
> +		 * driver used to skb_put() it anyway, which trips
> +		 * skb_over_panic and takes the host down; drop it instead.
> +		 */
> +		if (unlikely(length < ETH_HLEN + ETH_FCS_LEN) ||
> +		    unlikely(length - ETH_FCS_LEN > skb_tailroom(skb))) {

[Severity: High]
Is skb_tailroom() the right upper bound here? The device only gets
buffer_info->length bytes, which is adapter->rx_buffer_len:

atl1c_alloc_rx_buffer() {
    ...
    skb = napi_alloc_skb(&rrd_ring->napi, adapter->rx_buffer_len + 64);
    ...
    buffer_info->length = adapter->rx_buffer_len;
    mapping = dma_map_single(&pdev->dev, vir_addr,
                             buffer_info->length, DMA_FROM_DEVICE);
    ...
}

atl1c_configure_des_ring() writes the same value to the hardware:

    AT_WRITE_REG(hw, REG_RX_BUF_SIZE,
                 adapter->rx_buffer_len & RX_BUF_SIZE_MASK);

The skb gets 64 extra bytes for the 0x...fc0 erratum, plus
SKB_DATA_ALIGN rounding. At the default MTU, tailroom is therefore about
1600 bytes while the DMA buffer is 1522 bytes. When skb_reserve(skb, 64)
is applied, tailroom is still about 1536.

atl1c_configure_mac() sets REG_MTU to max_frame_size + ETH_HLEN +
VLAN_HLEN + ETH_FCS_LEN (1522 by default). atl1c.h describes rx_sz_ov as
packets "more than MTU size truncated by Selene". The panic in the commit
message suggests the RRD still reports the untruncated length.

If that is the case, wouldn't a frame from the same l2mtu 1600 peer with a
reported length of about 1527 to 1604 bytes pass this check?

skb_put() would then include up to about 78 bytes the device never wrote.
Those bytes are stale page-frag data from earlier packets or other kernel
memory, and they go to napi_gro_receive(). With swiotlb (the driver uses
a 32-bit DMA mask), dma_unmap_single() copies back only
buffer_info->length bytes, so the tail is stale either way.

The commit message says such frames cannot be delivered because "the
buffers were sized for it". Wouldn't the check need to bound length by
buffer_info->length (rx_buffer_len), not skb_tailroom(), to enforce that?

[Severity: Low]
This isn't a bug, but the condition also adds a lower bound:

    if (unlikely(length < ETH_HLEN + ETH_FCS_LEN) ||

Descriptors shorter than 18 bytes are now dropped and counted as length
errors. Before this patch, a reported length below 4 made
length - ETH_FCS_LEN underflow in skb_put(), which was a second panic
path.

The commit message only describes the tailroom check ("drop ... any frame
that does not fit"). Could it also mention the runt rejection, for stable
backporters?

> +			netdev->stats.rx_length_errors++;
> +			netdev->stats.rx_dropped++;

[Severity: Medium]
Will userspace ever see these increments? atl1c_get_stats() takes
net_stats = &netdev->stats and overwrites both fields from hardware
counters on every read:

atl1c_get_stats() {
    ...
    net_stats->rx_length_errors = hw_stats->rx_len_err;
    ...
    net_stats->rx_dropped       = hw_stats->rx_rrd_ov;
    ...
}

It also rebuilds rx_errors from hw_stats only. dev_get_stats() calls
ndo_get_stats before copying the values out. That means ip -s link,
/proc/net/dev and rtnetlink reads all discard the software counts.

This seems to contradict "counting it in rx_length_errors/rx_dropped" and
"dropped and counted" in the commit message.

These increments are also unlocked read-modify-writes. On athr_mt,
atl1c_probe() registers up to 4 atl1c_clean_rx() NAPI instances and
enables threaded NAPI, so concurrent pollers can lose updates.

Would driver-private software counters (or
dev_core_stats_rx_dropped_inc() for rx_dropped) work better here, with
atl1c_get_stats() adding them to the hardware totals?

> +			if (netif_msg_rx_err(adapter))
> +				dev_warn_ratelimited(&pdev->dev,
> +						     "bad rx frame: len %u tailroom %d\n",
> +						     length, skb_tailroom(skb));
> +			dev_kfree_skb(skb);

[Severity: Low]
This frame is dropped as an error, but dev_kfree_skb() is consume_skb():

    #define dev_kfree_skb(a)	consume_skb(a)

Should this be kfree_skb(), or kfree_skb_reason() with
SKB_DROP_REASON_PKT_TOO_BIG, so that drop_monitor and the skb:kfree_skb
tracepoint report it as a drop?

> +			continue;

[Severity: High]
Can this path drain the RFD ring? atl1c_clean_rfd() has already marked
the slot ATL1C_BUFFER_FREE and advanced next_to_clean. This continue then
skips work_done++.

The only runtime refill, and the only rfd_prod mailbox write, is gated on
work_done at the end of atl1c_clean_rx():

    if (work_done)
        atl1c_alloc_rx_buffer(adapter, rrd_ring->num, true);

Suppose about rfd_ring->count (512) oversized frames arrive before any
poll delivers a good frame, which is the sustained l2mtu 1600 case this
patch targets. Every hardware RFD would then be used up without being
replaced.

After that no RRDs are posted, no RX interrupt fires, and NAPI does not
run again. atl1c_intr() only logs ISR_OVER, which includes ISR_RFD0_UR:

    if (status & ISR_OVER)
        if (netif_msg_intr(adapter))
            dev_warn(&pdev->dev,
                "TX/RX overflow (status = 0x%x)\n",
                status & ISR_OVER);

Would RX on the interface then stay dead until a down/up or reset?

The existing RRS_RX_ERR_SUM branch accounts the same way. This new path,
though, makes the stall reachable from oversized traffic.

Should dropped frames also trigger the refill? For example, the poll
could refill whenever any RFD was consumed, or count drops as work.

> +		}

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
hardware error branch earlier in atl1c_clean_rx() handles its buffer
differently from the new drop path:

    if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
        atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
        ...
        continue;
    }

All atl1c_clean_rfd() does is:

    buffer_info[rfd_index].skb = NULL;
    ATL1C_SET_BUFFER_STATE(&buffer_info[rfd_index], ATL1C_BUFFER_FREE);

Does this leak the RX skb and its DMA mapping for every errored frame
(CRC, alignment, truncation, runt)?

Nothing on that path calls dma_unmap_single() or frees the skb.
atl1c_alloc_rx_buffer() later maps a new skb into the slot.
atl1c_clean_buffer() returns early for FREE slots, so teardown does not
recover it either.

The driver uses a 32-bit DMA mask. On hosts without an IOMMU, each
leaked mapping could also pin a swiotlb slot.

Could the error branch unmap and free the skb the way the new path does?

> +
>  		skb_put(skb, length - ETH_FCS_LEN);
>  		skb->protocol = eth_type_trans(skb, netdev);
>  		atl1c_rx_checksum(adapter, skb, rrs);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023093000.73535-1-federico%40rimpianto.com
