Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339652;
	b=ZcSThKv53NXNhwGonUir2wnC0fto802ymzrXMTwjoYMGlH1HvnAPK8pXLbnCkBwrhuQk
	 FSsaLQYdp35u5T+GZHTvJY2UqpBvNwp1/PyBOFP7/yvt0CYyoeZkVRVPd5ia2H0y3KrRy
	 rv2fE9/AFKx3DDWvgAtttVvrIRXm2PPwojEIDF2NsKywuyQ53Q8A+t88JVa/JX3wlz1VG
	 XqUKcvE5g2xTP7nb89+rVNUQAA5CYWI0XMDdpHFi/IVWl5lo8fpCpbTk2mK+28lz+QFNK
	 conWufHo2OgljRSZdNUY2MHXSGxgoW9sfhpQJ3zwqnZf1Gbwnzx8RzVfOMvcHqZkLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339652;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aG6K/xyTn32KaJFGPbPslUy7+CQ2EaT3/oPs1NUoISg=;
	b=WCtmFoFDSLVsHzsQh9AH5WYYwVvJMwamQm+GL+nfn0YmbgSr+OW2VBSnajs51ici0TAw
	 2ZM1+MIBqgRcPAqNETX53/4QX5XOjY6VzJJN6V9MhQ42tqFHydRaBe3xix+ktGiVqf7vj
	 L8AvYJzadobMPKWMNfT7wiPn1okI7W71Ba+HMmfYCszBcv9RuRnIoq39I13UALXzSoOmE
	 HLW3/SL99MX2GE5LEUTBCMCcCFFSHiJn+Ay2q14Fmr3cqsxeF9tFF0GSeKn5VdhK97SeW
	 pvwDiKL2xwWT1TRqzXJ0jTwCawVyczUGnFf75acbVPaGeeJtl4Nvq6ZlesiSWMIMTMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyJZeJnZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D44606A31A;
	Fri, 30 Oct 2026 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyJZeJnZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F701F000C1;
	Fri, 30 Oct 2026 05:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339651;
	bh=aG6K/xyTn32KaJFGPbPslUy7+CQ2EaT3/oPs1NUoISg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RyJZeJnZDtexmwJa1HkC/pBGZ7s77jE35WASXScG2HpFJliUPzOvIudshioSIhRkG
	 lttp++yrB31e6gd9JmBAK0AX6+E9atBDwGDIYXpG+a4mybFI407IRYWOB97c0yl6Je
	 5ftBheI7u5zmFI6D/zCWbRk3qdyYt/RHLBOFKoDzGSLVOiaEJSaSIUrPEUvirRhQC3
	 kbfzsyJjRdzCI7aNKGEBv1EciKSi7MEfdBAebMJikMxJDs15XtgccCBb05QtXstOO8
	 WzY76uyY0ykNSzczCOx5i3AZp9lbS9F85jXmYXRUwCyyvbj2POg988YVtCJ0347AGu
	 cEJQ0ntyzUejA==
Subject:
 Re: [PATCH net v2] net: atl1c: drop oversized RX frames instead of panicking
From: netdev-bot+sashiko@kernel.org
To: federico@rimpianto.com
Cc: chris.snook@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 30 Oct 2026 05:54:11 +0000
Message-ID: <179333965104.3134.9466382803599715684@kernel.org>
In-Reply-To: <20261027115151.17092-1-federico@rimpianto.com>
References: <20261027115151.17092-1-federico@rimpianto.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In atl1c_clean_rx()
  (drivers/net/ethernet/atheros/atl1c/atl1c_main.c:1952-1953), the new…
- [Low] atl1c_clean_rx() sends runt frames (length < ETH_HLEN +
  ETH_FCS_LEN) down the same drop path as oversized frames and frees…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the
  RRS_RX_ERR_SUM / RRS_802_3_LEN_ERR branch of atl1c_clean_rx()…
- [High] This problem wasn't introduced by this patch (the author
  explicitly leaves it out of scope), but the RRS_RX_ERR_SUM /…
- [High] This problem wasn't introduced by this patch, but the link-
  change path of atl1c_common_task() (line 349-353) resets and refills…
- [Medium] This problem wasn't introduced by this patch, but when an RRD
  reports rfd_num != 1, atl1c_clean_rx() calls atl1c_clean_rrd(rrd_ring,…
- [Medium] This problem wasn't introduced by this patch, but struct
  atl1c_recv_ret_status declares word0 and word3 as __le32, and…

--

net: atl1c: drop oversized RX frames instead of panicking

This patch adds a length check to atl1c_clean_rx(). It drops RX frames
whose descriptor length is shorter than ETH_HLEN + ETH_FCS_LEN or longer
than buffer_info->length, so skb_put() can no longer panic. Each dropped
frame is freed with SKB_DROP_REASON_PKT_TOO_BIG, counted as rx_dropped,
and counted as NAPI work so the RFD ring still gets refilled.

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index e58f1d2c26bdf..eddd8406867f7 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -1934,6 +1934,39 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>  			break;
>  		}

[Severity: Medium]
This is a pre-existing issue, but the new check only runs when
rfd_num == 1. What happens to the RFDs behind a descriptor with
rfd_num != 1?

By the time this break is reached, atl1c_clean_rrd() has already consumed
the RRD. The branch then exits without dma_unmap_single(), without freeing
the skb and without atl1c_clean_rfd(). Those slots stay
ATL1C_BUFFER_BUSY.

Refill in atl1c_alloc_rx_buffer() stops at the first slot that is not
free:

    while (next_info->flags & ATL1C_BUFFER_FREE) {

Once next_to_use reaches one of these slots, does RX stall for good? The
skbs and DMA mappings would leak as well.

With REG_MTU larger than REG_RX_BUF_SIZE for MTUs 1501-1522 (see below),
any frame the hardware splits across RFDs would come through here. It is
not clear when this hardware reports rfd_num > 1, though. The 1600 byte
frames in the commit message arrived with rfd_num == 1.

>  		atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
> +
> +		/* A link partner whose l2mtu is larger than ours can hand us a

[ ... ]

> +		if (unlikely(length < ETH_HLEN + ETH_FCS_LEN ||
> +			     length > buffer_info->length)) {

[Severity: Medium]
With an MTU between 1501 and 1522, can this bound drop frames that fit
the MTU and that the MAC was set up to accept?

atl1c_set_rxbufsize() compares the L3 MTU with AT_RX_BUF_SIZE. That
constant is an L2 frame size, ETH_FRAME_LEN + VLAN_HLEN + ETH_FCS_LEN =
1522:

    adapter->rx_buffer_len = mtu > AT_RX_BUF_SIZE ?
        roundup(mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN, 8) : AT_RX_BUF_SIZE;

So for mtu <= 1522, rx_buffer_len, REG_RX_BUF_SIZE and buffer_info->length
all stay at 1522. atl1c_configure_mac() meanwhile programs:

    AT_WRITE_REG(hw, REG_MTU, hw->max_frame_size + ETH_HLEN +
            VLAN_HLEN + ETH_FCS_LEN);

In that MTU range this comes to as much as 1544.

Take MTU 1508 (RFC 4638 PPPoE). A full-size untagged frame is
1508 + 14 + 4 = 1526 bytes. The MAC accepts it, but this check drops it
as SKB_DROP_REASON_PKT_TOO_BIG. Before the patch the 64 bytes of slack
meant skb_put() took the frame and it was delivered.

The REG_MTU and REG_RX_BUF_SIZE mismatch was already there. With this
check it becomes silent loss of traffic that is within the MTU.

Could rx_buffer_len be sized from mtu + ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN
instead, for example max(AT_RX_BUF_SIZE, roundup(...))? Then the bound
enforced here would match what the MAC accepts.

[Severity: Medium]
This is a pre-existing issue and the patch does not make it worse, but is
length correct on big-endian hosts? struct atl1c_recv_ret_status declares
word0 and word3 as __le32. atl1c_clean_rx() masks the raw word and only
then byte-swaps a 16-bit value:

    length = le16_to_cpu((rrs->word3 >> RRS_PKT_SIZE_SHIFT) &
            RRS_PKT_SIZE_MASK);

rfd_num and rfd_index are read from rrs->word0 without conversion, and
RRS_RXD_IS_VALID(rrs->word3) also tests the raw word.

On big-endian, this bound would compare a meaningless length against the
buffer_info of the wrong slot. Should the length be
(le32_to_cpu(rrs->word3) >> RRS_PKT_SIZE_SHIFT) & RRS_PKT_SIZE_MASK
instead?

> +			dev_core_stats_rx_dropped_inc(netdev);
> +			if (netif_msg_rx_err(adapter))
> +				dev_warn_ratelimited(&pdev->dev,
> +						     "dropped rx frame: %u bytes, buffer %u\n",
> +						     length, buffer_info->length);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);

[Severity: Low]
Runt frames (length < ETH_HLEN + ETH_FCS_LEN) take this path too. Won't
drop_monitor and the kfree_skb tracepoint then report them as
SKB_DROP_REASON_PKT_TOO_BIG?

SKB_DROP_REASON_PKT_TOO_SMALL already exists for that case. Could the
reason depend on which bound failed?

[Severity: High]
This is a pre-existing issue, but could the link-change worker already
have freed this skb?

atl1c_common_task() resets the rings on a link change without stopping
NAPI:

    if (test_and_clear_bit(ATL1C_WORK_EVENT_LINK_CHANGE,
        &adapter->work_event)) {
        atl1c_irq_disable(adapter);
        atl1c_check_link_status(adapter);
        atl1c_irq_enable(adapter);
    }

atl1c_irq_disable() masks interrupts and calls synchronize_irq(). That
waits for the hardirq handler, but not for a NAPI poll already running on
another CPU.

On link down the worker runs:

atl1c_check_link_status()
    netif_carrier_off()
    atl1c_reset_mac()
    atl1c_reset_dma_ring()->atl1c_clean_rx_ring()->atl1c_clean_buffer()
    atl1c_configure()->atl1c_alloc_rx_buffer(..., false)

A poll that passed its netif_carrier_ok() check before the carrier went
off may still hold skb = buffer_info->skb. After that it passes the skb to
kfree_skb_reason() here, or to skb_put()/napi_gro_receive(). It can also
run atl1c_alloc_rx_buffer() at the same time as the worker.

Can this end in a double free or use-after-free of the RX skbs, and a
corrupted ring? atl1c_clean_rx() also rewrites REG_IMR at the end, which
undoes the irq disable. atl1c_down() quiesces NAPI properly. Should the
link-change path do the same?

> +			/* atl1c_clean_rfd() has already recycled the RFD, so
> +			 * count the drop as work: the refill at the end of the
> +			 * poll only runs when work_done is non-zero, and
> +			 * sustained oversized traffic would otherwise drain the
> +			 * ring and stop RX for good.
> +			 */
> +			work_done++;
> +			continue;
> +		}

[Severity: High]
This is a pre-existing issue, but the error branch earlier in
atl1c_clean_rx() seems to have the same ring drain problem that this
comment describes:

    if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
        atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
        if (netif_msg_rx_err(adapter))
            dev_warn(&pdev->dev,
                 "wrong packet! rrs word3 is %x\n",
                 rrs->word3);
        continue;
    }

atl1c_clean_rfd() marks the slot ATL1C_BUFFER_FREE and advances
next_to_clean, but work_done is never incremented. The refill only runs
when work_done is non-zero:

    if (work_done)
        atl1c_alloc_rx_buffer(adapter, rrd_ring->num, true);

Suppose a run of errored frames (CRC errors, or a crafted 802.3 length
field mismatch) uses up every posted RFD with no good frame in between.
Each poll then ends with work_done == 0 and the ring is never refilled.
The ISR_OVER handler in atl1c_intr() only logs.

Can RX stop permanently in that case? This branch also does not count
against the NAPI budget, so one poll can consume any number of errored
descriptors.

[Severity: High]
Also pre-existing, and the v2 notes say it is deliberately left for a
separate patch, but the same error branch leaks one skb and one streaming
DMA mapping per errored frame. Since it is High severity, it is
reported here as well.

The branch runs before dma_unmap_single() and before the skb is fetched.
atl1c_clean_rfd() only does:

    buffer_info[rfd_index].skb = NULL;
    ATL1C_SET_BUFFER_STATE(&buffer_info[rfd_index],
                ATL1C_BUFFER_FREE);

Teardown cannot recover the slot either, because atl1c_clean_buffer()
skips free slots:

    if (buffer_info->flags & ATL1C_BUFFER_FREE)
        return;

atl1c_alloc_rx_buffer() then overwrites buffer_info->skb and
buffer_info->dma.

Could a peer sending CRC errored or length mismatched frames grow this
leak without bound, using up memory and IOMMU or swiotlb space? It might
be worth fixing in the follow-up patch, together with the missing
work_done accounting above.

>  		skb_put(skb, length - ETH_FCS_LEN);
>  		skb->protocol = eth_type_trans(skb, netdev);
>  		atl1c_rx_checksum(adapter, skb, rrs);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027115151.17092-1-federico%40rimpianto.com
