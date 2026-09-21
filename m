Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C243C457D;
	Mon, 21 Sep 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990895; cv=none; b=QNq59SLXDjsmYhSsf8bd60r3V+sBGLy4PqAyy3EMpXHlcL2eiXu6Lvy3kmjqZa2iD7pBUTOE5bVqEZSVsYtphx3n6wlOYzAuK72Ti6Zm4khb0+JYuA0CSy2fsb8HYSHa/9c+uE1Tb2mwAsKf+5WjOY5saeV6svMWSQEbNNhea1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990895; c=relaxed/simple;
	bh=wCTfyqrrLLpIFt886tE9fryUGMspN1xZ0sz+gIix1ZE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SITyjgJekzOdj6QPphuHLmnbp3mmLN3hCAZpGCtDILOjX6XfMsAzRQoHw7PvC5LVX/ZmPoQo7IQXSJVzfI/kA1AMqmFjUAs4GfgDJcTJqNCEOOVbg8DnPE7bGhistvjf70XLj0zIQq2Ia3WD+mG5EGlxPeNKe8UVUt5PK5hX/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8PRNcwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8PRNcwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1CB1F000FF;
	Mon, 21 Sep 2026 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990893;
	bh=G7AZyWFFz2rKjcjfqSXQCHZ3fs2m/7gEOmYA4bsts4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V8PRNcwTxcAVRmE3DMX7vs3HFJOrFJGDWfnhgxuWIKYPiUDF5BWE9U9v8YFfb1CGd
	 AieHw6jH3vzGs3hx/GmwFq5qavEOuZcubvWfo+211Mcp2rvAW0onp5IzV0zjf4FKNF
	 zJrHHz38IeUlqnhLrEMuwoTNJeFsae5EBqhulmN7IN55RW59Lldka7w7o1HPQBpfDT
	 3ZREKJUiJq6lI2RaqdNmgGLtXhfWk9xy2ABY4c0C3BrcusA/YKVQRT4Bb/7Hp6uo6t
	 afbxtjzGZrJK3X2+AQZ98aqExFm/WzvayvcfMSpFAcH5fcaMNs+cdkTVBS9ElecKiE
	 c2/x5Sc2m0NAw==
Subject: Re: [PATCH] cxgb4: Fix ptp_tx_skb reference leak in cxgb4_eth_xmit()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew+netdev@lunn.ch, atul.gupta@chelsio.com, bharat@chelsio.com,
 davem@davemloft.net, edumazet@google.com, ganeshgr@chelsio.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 11:41:32 +0000
Message-ID: <178999089271.2160803.8514797299048887268@kernel.org>
In-Reply-To: <20260917105713.2147903-1-vulab@iscas.ac.cn>
References: <20260917105713.2147903-1-vulab@iscas.ac.cn>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] cxgb4_eth_xmit() releases the PTP reference based only on
  the pointer identity `adap->ptp_tx_skb == skb`, without knowing…
- [High] Holding adap->ptp_lock in cxgb4_eth_xmit() gives the new
  dev_kfree_skb_any(adap->ptp_tx_skb) calls no exclusion against the…
- [Low] The PTP arming step sets two pieces of state together at
  sge.c:1528-1529 - skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS and…

--

cxgb4: Fix ptp_tx_skb reference leak in cxgb4_eth_xmit()

The patch moves the netdev_priv()/pi->adapter lookup to the top of
cxgb4_eth_xmit() and then releases adap->ptp_tx_skb on the NETDEV_TX_BUSY
path and on the out_free path.  Both new blocks decide whether to drop the
extra reference by comparing adap->ptp_tx_skb against skb.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> index 9fccb8ea9bcd1..5d4c63d9a937a 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c

[ ... ]

> @@ -1553,6 +1554,10 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
>  		dev_err(adap->pdev_dev,
>  			"%s: Tx ring %u full while queue awake!\n",
>  			dev->name, qidx);
> +		if (adap->ptp_tx_skb == skb) {
> +			dev_kfree_skb_any(adap->ptp_tx_skb);
> +			adap->ptp_tx_skb = NULL;
> +		}
>  		return NETDEV_TX_BUSY;
>  	}

[Severity: Critical]
Can this release a reference that this invocation no longer owns?

The reference is taken in exactly one place in cxgb4_eth_xmit():

	if (ptp_enabled) {
		if (!(adap->ptp_tx_skb)) {
			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
			adap->ptp_tx_skb = skb_get(skb);
		} else {
			goto out_free;
		}

but the new cleanup infers ownership from the pointer comparison
adap->ptp_tx_skb == skb.  Note the else branch also reaches out_free
without owning a reference.

The completion side drops the reference before it clears the field:

drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c:cxgb4_ptp_read_hwstamp() {
	...
	skb_tstamp_tx(adapter->ptp_tx_skb, skb_ts);
	dev_kfree_skb_any(adapter->ptp_tx_skb);
	spin_lock(&adapter->ptp_lock);
	adapter->ptp_tx_skb = NULL;
	spin_unlock(&adapter->ptp_lock);
}

t4_start_xmit() holds ptp_lock across the whole of cxgb4_eth_xmit() for PTP
frames, so the receive-side thread can sit blocked on that spin_lock() with
the reference already dropped while adap->ptp_tx_skb still equals skb:

CPU0, t4_ethrx_handler() -> t4_tx_hststamp() -> cxgb4_ptp_read_hwstamp()
	dev_kfree_skb_any(adapter->ptp_tx_skb);	/* refcount 2 -> 1 */
	spin_lock(&adapter->ptp_lock);		/* blocks, CPU1 holds it */

CPU1, t4_start_xmit() -> spin_lock(&adap->ptp_lock) -> cxgb4_eth_xmit()
	if (adap->ptp_tx_skb == skb) {		/* still true */
		dev_kfree_skb_any(adap->ptp_tx_skb);	/* 1 -> 0, freed */

Here the skb is then handed back to the qdisc with NETDEV_TX_BUSY and
retransmitted, so can this become a use-after-free?  On out_free the
following dev_kfree_skb_any(skb) would free it a second time.

The window is the whole xmit call, not a few instructions, and the
completion path is entered for any inbound UDP frame with source and
destination port 319 (cxgb4_ptp_is_ptp_rx()) without checking that it is
the loopback of the pending skb.  The ptptxq is allocated with 8
descriptors, so credits < 0 is readily reachable.

Would recording ownership locally, for example a bool set where skb_get()
succeeds, and dropping the reference only under that condition and under
ptp_lock, be a safer form of this fix?

Separately, t4_start_xmit() takes ptp_lock only for PTP frames:

	if (is_ptp_enabled(skb, dev)) {
		struct adapter *adap = netdev2adap(dev);
		netdev_tx_t ret;

		spin_lock(&adap->ptp_lock);
		ret = cxgb4_eth_xmit(skb, dev);
		spin_unlock(&adap->ptp_lock);
		return ret;
	}

	return cxgb4_eth_xmit(skb, dev);

so for ordinary traffic the new read and store of adap->ptp_tx_skb run with
no lock at all, against a field documented in struct adapter as covered by
ptp_lock.  Should these accesses be gated on ptp_enabled?

[Severity: Low]
The arming step sets two pieces of state together:

			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
			adap->ptp_tx_skb = skb_get(skb);

Should this abort path also clear SKBTX_IN_PROGRESS?  The skb goes back to
the qdisc with the flag still set, while no work request with
TXPKT_TSTAMP_F was written to adap->sge.ptptxq and adap->ptp_tx_skb has
just been cleared, so t4_tx_hststamp()/cxgb4_ptp_read_hwstamp() can no
longer produce a completion for that frame.

If userspace disables transmit timestamping between the abort and the retry
(cxgb_hwtstamp_set() clearing pi->ptp_enable), the retry takes the ordinary
path, and the stale flag then also suppresses the software timestamp:

net/core/skbuff.c:__skb_tstamp_tx() {
	...
	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
		return;
	...
}

so the SO_TIMESTAMPING consumer gets neither a hardware nor a software
timestamp for that frame.

> @@ -1723,6 +1728,10 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  
>  out_free:
> +	if (adap->ptp_tx_skb == skb) {
> +		dev_kfree_skb_any(adap->ptp_tx_skb);
> +		adap->ptp_tx_skb = NULL;
> +	}
>  	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }

[Severity: High]
Does holding ptp_lock in cxgb4_eth_xmit() actually exclude the racing user
of this field?  cxgb4_ptp_read_hwstamp() dereferences the skb, reports the
timestamp and drops the reference entirely outside ptp_lock, taking the
lock only to store NULL:

drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c:cxgb4_ptp_read_hwstamp() {
	skb_ts = skb_hwtstamps(adapter->ptp_tx_skb);
	...
	skb_tstamp_tx(adapter->ptp_tx_skb, skb_ts);
	dev_kfree_skb_any(adapter->ptp_tx_skb);
	spin_lock(&adapter->ptp_lock);
	adapter->ptp_tx_skb = NULL;
	...
}

and the non-NULL test is done with no lock either:

drivers/net/ethernet/chelsio/cxgb4/sge.c:t4_tx_hststamp() {
	if (!is_t4(adapter->params.chip) && adapter->ptp_tx_skb) {
		cxgb4_ptp_read_hwstamp(adapter, pi);
	...
}

Before this patch the transmit path never stored NULL into
adap->ptp_tx_skb, so this hunk and the NETDEV_TX_BUSY hunk add a second
writer.  Can that produce a NULL dereference?

CPU0, t4_tx_hststamp()
	if (... && adapter->ptp_tx_skb)		/* non-NULL */

CPU1, cxgb4_eth_xmit() out_free
	adap->ptp_tx_skb = NULL;

CPU0, cxgb4_ptp_read_hwstamp()
	skb_ts = skb_hwtstamps(adapter->ptp_tx_skb);	/* NULL skb */

Would extending ptp_lock over the whole read_hwstamp sequence, including
the non-NULL test, or not touching the shared pointer from these error
paths at all, address both this and the reference-drop race above?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917105713.2147903-1-vulab%40iscas.ac.cn
