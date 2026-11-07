Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049403;
	b=dR3r+2frKdPsd4ROR2iN80tGXGfLTsC3tQw0VqHD4FPMaKLdiCi12qezBzgkFAZOG2In
	 VC31RB0y2KNrSlxX7ThK9pH18NctWA/72hN8UnlHdals1K0ThUxS11WZ3oGBVBn1CAKex
	 hzMCXqruZSzVJT6K4O/5H3PDtTWTleS3wxYrM9qhGeBUix5aw9Kt+Pbtx5UytxPcOe2d6
	 WskvG648xs6qis1LAcTvu8814j3K84WUUOUFEcZI3AkXIt9QJPnqd3lPdpC1+45Q90sYc
	 eN7hXiId6+QZqznkHqg22jz63D4smiYGfh6wr2u4XPDPB7twEpcy6JkOaUuBlZ3H0bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049403;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/wX9SkEQ6GTlYhulXYx5S+rXELMWgypRE+xtTTGp6Js=;
	b=RfcOQoVbIy62UtTgUTm910te/LVvakThv2SySrNVqe/dMPAZODNE/7Ta0jYWxcLwZ4vO
	 O/oDIPkEtVLHGVIWnyAdoKeWbs7gNBVresnXz7vfc0dxhoP78+40JFKRLOyaDn+cgysaD
	 KKzdh75JgNs/uACdf1vLmvxUsnIU0PV7ftNWIOLQdut5cMWk34wpNO2CvA1vuHaMvBUzt
	 +q5ZpSLt5J2ZJboO1ikPAtNIg/Mt9dxBucSnDkoGeOTKikUhskN3MaGOQC4L3H5Ljb8Yg
	 tInTlzXy3aqwBcEiI0EBGzAoPltZw2RXlL9N8/7DFZSum/tuVERgNBhzWiAd8Sw5e4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ps2vc9Su;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796F606A32E;
	Sat,  7 Nov 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ps2vc9Su
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714AC1F008A5;
	Sat,  7 Nov 2026 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049402;
	bh=/wX9SkEQ6GTlYhulXYx5S+rXELMWgypRE+xtTTGp6Js=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ps2vc9SuDCF12+y7TxOsF7TFVyNHBqgqzYpiLLB5ICAz1Pj5vIdTizDFJN0ycPCx2
	 R+t6/i0CT4QBLOjUlOYrr6crUEJchGMAVsUi0tCPYYbhcmDbViCsZ+Dre68Sz7ZmNL
	 NOYQp2wOAzfB7yf+k+b9jfpbs7Cn5Zo2aoRYw+R+0v95ef5VGGt+O2Q4H6+IPmDPmZ
	 Vh+4JmUIlNsRtthe/BoqLlASiCKEDNRskHO/1ST227/gzwaE5txYt4SFZgnbjc/R0a
	 WNmg3l6BdL2i/wG0NZzHN2l+7Kc90cM6ckJh5WEvl1ZN7vNrD+fsuIdBQ3pi/IgbTh
	 QkA2hDRf2LGDg==
Subject:
 Re: [PATCH] net: cxgb4: do not leak a PTP skb when the Tx queue is busy
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 11:03:21 +0000
Message-ID: <179404940199.994134.17549120390579622204@kernel.org>
In-Reply-To: <20261103100530.1309928-1-vulab@iscas.ac.cn>
References: <20261103100530.1309928-1-vulab@iscas.ac.cn>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch splits the claim on adap->ptp_tx_skb into a NULL
  check at the top of cxgb4_eth_xmit() (sge.c:1526) and a store about…
- [Low] The commit message lists "an unsupported FCoE offload" as one of
  the out_free paths that leaks the PTP reference.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the consumer
  side of adapter->ptp_tx_skb has no synchronization.
- [Low] This problem wasn't introduced by this patch, but
  cxgb4_eth_xmit() still sets SKBTX_IN_PROGRESS (sge.c:1528) before the…

--

net: cxgb4: do not leak a PTP skb when the Tx queue is busy

This patch moves the skb_get() that stores the PTP skb in
adap->ptp_tx_skb. It used to sit at the top of cxgb4_eth_xmit() and now
runs just before the packet is handed to the hardware, so the
NETDEV_TX_BUSY and out_free paths no longer leak the extra reference.
The early check for an outstanding PTP skb is kept, and the patch relies
on adap->ptp_lock for serialization.

> cxgb4_eth_xmit() stores the PTP skb in adap->ptp_tx_skb with an extra
> reference before the descriptor credits are checked.  When the PTP
> queue is full the function returns NETDEV_TX_BUSY, and later failures
> such as an unsupported FCoE offload or a failed DMA mapping jump to
> out_free.

[Severity: Low]
Can a PTP skb actually reach the FCoE path?

is_ptp_enabled() requires cxgb4_ptp_is_ptp_tx(), which only matches
skb->protocol == htons(ETH_P_IP). For anything else,
cxgb_fcoe_offload() returns 0 right away:

	if (skb->protocol != htons(ETH_P_FCOE))
		return 0;

Even for real FCoE frames, cxgb_fcoe_offload() returns -ENOTSUPP, but
cxgb4_eth_xmit() compares against a different errno:

	ret = cxgb_fcoe_offload(skb, adap, pi, &cntrl);
	if (unlikely(ret == -EOPNOTSUPP))
		goto out_free;

So that goto out_free never runs. Should the FCoE example be removed
from the commit message? That would leave only the NETDEV_TX_BUSY and
DMA mapping failure paths.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> index 9fccb8ea9bcd1..7e83f60bd14ec 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> @@ -1523,12 +1523,9 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	qidx = skb_get_queue_mapping(skb);
>  	if (ptp_enabled) {
> -		if (!(adap->ptp_tx_skb)) {
> -			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> -			adap->ptp_tx_skb = skb_get(skb);
> -		} else {
> +		if (adap->ptp_tx_skb)
>  			goto out_free;

[Severity: High]
This is a pre-existing issue, but ptp_lock does not protect the consumer
side of adap->ptp_tx_skb. Can two RX contexts free the same skb?

t4_tx_hststamp() checks the pointer without taking the lock:

	if (!is_t4(adapter->params.chip) && adapter->ptp_tx_skb) {
		cxgb4_ptp_read_hwstamp(adapter, pi);

cxgb4_ptp_read_hwstamp() then timestamps and frees the skb before it
clears the pointer under the lock:

	skb_tstamp_tx(adapter->ptp_tx_skb, skb_ts);
	dev_kfree_skb_any(adapter->ptp_tx_skb);
	spin_lock(&adapter->ptp_lock);
	adapter->ptp_tx_skb = NULL;
	spin_unlock(&adapter->ptp_lock);

t4_ethrx_handler() takes this path for any non-MPS RX frame on a
ptp_enable port that has RXF_UDP_F set and UDP source and destination
port 319. Nothing checks that the frame really is the hardware Tx
loopback.

ptp_tx_skb is shared by the whole adapter, but each port's RX queue runs
in its own NAPI context. Suppose such a frame arrives on one port while
the real loopback is handled on another port. Both CPUs can then see the
same non-NULL pointer, and both call dev_kfree_skb_any() on it.

In the immediate path, the second CPU writes hwtstamps into freed memory
and then frees the skb again. In the SGL path, the second free drops the
reference that still belongs to sgl_sdesc->skb, so the later TX reclaim
frees memory that is already freed.

I could not confirm whether the hardware delivers non-loopback UDP
319->319 frames as plain CPL_RX_PKT. Two cases where it might are the
rx_filter modes in which cxgb_hwtstamp_set() does not call
cxgb4_ptprx_timestamping(), and frames that the hardware PTP classifier
does not timestamp.

There is also a smaller effect on the transmit side. The check above
holds ptp_lock, but it can still see the freed, not yet NULL pointer and
drop a new PTP packet.

Could ptp_tx_skb be read and set to NULL in one step under ptp_lock,
with the timestamp and free done outside the lock?

> -		}
> +		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

[Severity: Low]
This isn't a bug introduced by this patch, but SKBTX_IN_PROGRESS is
still set before the credit check that can return NETDEV_TX_BUSY. The
flag is never cleared on that path. Can the requeued packet end up with
no TX timestamp at all?

Suppose cxgb_hwtstamp_set() clears pi->ptp_enable before the qdisc
retries the skb. The retry then goes through the normal ethtxq path
without TXPKT_TSTAMP_F, so the hardware produces no timestamp.

Because SKBTX_IN_PROGRESS is still set, __skb_tstamp_tx() also skips the
software timestamp, unless SOF_TIMESTAMPING_OPT_TX_SWHW is set.

>  		q = &adap->sge.ptptxq;
>  	} else {
>  		q = &adap->sge.ethtxq[qidx + pi->first_qset];

[ ... ]

> @@ -1707,6 +1704,9 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	skb_tx_timestamp(skb);
>  
> +	if (ptp_enabled)
> +		adap->ptp_tx_skb = skb_get(skb);
> +

[Severity: Medium]
The commit message says "PTP transmits are serialized by
adap->ptp_lock". Is that guaranteed when this store runs?

t4_start_xmit() decides whether to take ptp_lock from its own call to
is_ptp_enabled():

	if (is_ptp_enabled(skb, dev)) {
		...
		spin_lock(&adap->ptp_lock);
		ret = cxgb4_eth_xmit(skb, dev);
		spin_unlock(&adap->ptp_lock);
		return ret;
	}

	return cxgb4_eth_xmit(skb, dev);

cxgb4_eth_xmit() then calls it a second time and uses that result:

	bool ptp_enabled = is_ptp_enabled(skb, dev);

is_ptp_enabled() reads pi->ptp_enable without any synchronization.
cxgb_hwtstamp_set() can set it while holding only RTNL:

	if (config->rx_filter != HWTSTAMP_FILTER_NONE) {
		if (cxgb4_ptp_redirect_rx_packet(adapter, pi) >= 0)
			pi->ptp_enable = true;
	}

If the flag goes from false to true between the two calls,
cxgb4_eth_xmit() runs the PTP path without ptp_lock. Two CPUs on
different TX queues could then both see adap->ptp_tx_skb == NULL at the
top of the function. The same applies to one unlocked CPU and another
port that does hold ptp_lock.

Both CPUs would then build descriptors and reach this store. The second
skb_get() overwrites the first, so the first skb's extra reference
leaks. That is the leak this patch is meant to fix.

Before the patch, the check and the store were next to each other. Now
the whole descriptor build sits between them, which makes the window
much wider.

The concurrent writes to the ptptxq descriptors and pidx were already
possible before this patch.

Would it be more robust to evaluate is_ptp_enabled() once and pass the
result into cxgb4_eth_xmit()? Another option would be to take ptp_lock
inside cxgb4_eth_xmit() based on its own ptp_enabled value.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100530.1309928-1-vulab%40iscas.ac.cn
