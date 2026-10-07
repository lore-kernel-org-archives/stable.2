Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651243C1D62;
	Wed,  7 Oct 2026 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791346961; cv=none; b=BhbnVXoeST8o+g8yw2pyH3FBUw2W1WBl0Vq6ofAwzmdLQOsfwjA+EHGE79EiAkBTNo5AEFMyiS6qKRfs5mGH2Cn6lnu59sAV9bc4e+Kn9/7AZa5FUBllW2y2VUZ6WO6p6GBeJIBlgTg6L9SpeOUj1UuzIBTD+9XCC+K7ao1Adhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791346961; c=relaxed/simple;
	bh=Byx5e0MZF3e+6UdiiYp/Wzz+q5hiDT6L1Ft++XEQ0PQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7zILfemFAAptsk0oUpfir56T2BRM/sNX/QwuWX7SzOyvZe4d4fsc2h9lwYeoY7RAle63vpnWYOPdFJulkbz7D3aNF/lu+tUj8lOZK7VmjLp7MoFqK8aa5g8V34JXA9T97U5BrSPgftoQtgicms1OR13mxZMvfnvAYYupZnMsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx+YJLYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx+YJLYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3E71F0089B;
	Wed,  7 Oct 2026 04:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791346959;
	bh=/nAdc4Y9g0Ft3unXJ2Op8GBWhN8QQGcJL7acZdLT7vA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qx+YJLYicNQwfEoBSnafgZxvFitXFnG0h9QIQIUt2M1ID2cZApojMl51DURBo75tv
	 hoxFaqJfOjkGniQrLi/DfZUGlKWQ/UOzSC5Umtay5MKbrewV42tVJma8ViROfLa9+R
	 Hi57rLJ+FdSgD1qkbeyS20ZANCv6lKGm72zBCNcORIJ1pGNe0hYvvk/XKibbp6s7LG
	 gvWQ45bxLMFgU6Nxm+1eXIZ6C4dCLxgerGwBhvUCFy9tAOZbDuaMX/qta+OArv77CM
	 hE4XQgFhnomXOxIxSODOMFTJeDYIwK0mHZbKdTIiL+0RPeL1XSHX94uFvWZHupqOQx
	 tNQEu6yDy7UPw==
Subject:
 Re: [PATCH v2 net] bnxt_en: fix DMA mapping length for padded small packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, sfle@kth.se,
 edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, berni@debian.org
Date: Wed, 07 Oct 2026 04:22:37 +0000
Message-ID: <179134695789.434549.53526916334276884@kernel.org>
In-Reply-To: <20261006042153.199444-1-edumazet@kernel.org>
References: <20261006042153.199444-1-edumazet@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Regression in the software UDP GSO path.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sister
  bnge driver has the same stale-fragment ordering bug that the bnxt v2…

--

bnxt_en: fix DMA mapping length for padded small packets

This patch moves short-frame padding in bnxt_start_xmit() to the top of
the function and uses skb_put_padto(). As a result, skb_headlen() now
includes the pad when the linear head is DMA-mapped. This fixes the IOMMU
read faults that happened when the TX BD length was larger than the
mapped length.

Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d7728d0c5b6e6..7f379f21fe465 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -507,6 +507,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	txr = &bp->tx_ring[bp->tx_ring_map[i]];
>  	prod = txr->tx_prod;
>  
> +	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
> +		/* SKB already freed. */
> +		goto tx_kick_pending;
> +	}
> +

[Severity: Medium]
Does moving the pad ahead of the SW USO branch change what
bnxt_sw_udp_gso_xmit() puts on the wire?

Before this patch, padding only ran at normal_tx:, after the SW USO branch
had already returned. So bnxt_sw_udp_gso_xmit() always got the unpadded
skb.

Now a UDP GSO skb shorter than 52 bytes is padded first. On devices
without BNXT_FLAG_UDP_GSO_CAP it then goes here:

	if (skb_is_gso(skb) &&
	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
		int rc = bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);

bnxt_sw_udp_gso_xmit() in bnxt_gso.c then computes:

	total_payload = skb->len - hdr_len;
	num_segs = DIV_ROUND_UP(total_payload, mss);

This counts the zero pad as UDP payload. tso_build_hdr() builds
iph->tot_len and the UDP length from the segment payload, and the NIC
fills in valid checksums. Would the receiver then accept the pad bytes as
real UDP data?

For example, Ethernet 14 + IPv4 20 + UDP 8 + 2 bytes of data is 44 bytes.
With gso_size=1 that is padded to 52. total_payload goes from 2 to 10, so
10 datagrams are sent instead of 2, and eight of them carry only zeros.

An unprivileged UDP socket can trigger this by setting UDP_SEGMENT to a
small gso_size and sending a few bytes over IPv4.

Also, BNXT_MIN_PKT_SIZE is a per-frame minimum. Padding the super-packet
still leaves the individual SW USO segments (for example 43 bytes)
shorter than that.

Should the pad be skipped for skb_is_gso() skbs, or applied after the SW
USO branch?

[Severity: High]
This isn't a bug introduced by this patch, but the sister bnge driver
seems to have the ordering problem that this v2 placement avoids for
bnxt. In bnge_start_xmit() in drivers/net/ethernet/broadcom/bnge/bnge_txrx.c,
the frag count is read before padding:

	last_frag = skb_shinfo(skb)->nr_frags;
	...
	tx_buf->nr_frags = last_frag;
	...
	if (eth_skb_pad(skb))
		goto tx_kick_pending;

A nonlinear skb shorter than ETH_ZLEN has skb_tailroom() of 0. In that
case __skb_pad() goes through pskb_expand_head() and skb_linearize().
That pulls the frag data into the head, drops the frag page references
and sets nr_frags to 0.

bnge_start_xmit() then keeps using the stale last_frag:

	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
		TX_BD_CNT(last_frag + 2);
	...
	for (i = 0; i < last_frag; i++) {
		frag = &skb_shinfo(skb)->frags[i];
		...
		mapping = skb_frag_dma_map(bd->dev, frag, 0, len,
					   DMA_TO_DEVICE);

Can this DMA-map frag pages that the skb no longer holds a reference to?
If so, the NIC would send the frag data twice and read pages that may
already be freed or recycled, such as page_pool pages.

Two ways to get such skbs are AF_PACKET TX_RING SOCK_RAW frames and
forwarded small packets whose payload stayed in a frag after
pskb_trim_rcsum().

As a separate fix, would it make sense to call eth_skb_pad() before
nr_frags is read in bnge_start_xmit(), the same way this patch does for
bnxt?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006042153.199444-1-edumazet%40kernel.org
