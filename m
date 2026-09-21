Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FF238C1A;
	Mon, 21 Sep 2026 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956366; cv=none; b=DSly0CTqVzEjcA8NpfmMAf0pwbwXhxmOk0lB09/gd9oxucJhe/MXC9Ef0+fOhFX3U/VL6V9tE0wlB/mNeYWT4s+yv2dVtqSCrrQSwWWeSY9GHMg2HdqaJPQuZajERqo9be/6lhoOaTGrB4Azo7sH+ZcKjcW/9VL8OezxDYQ+rgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956366; c=relaxed/simple;
	bh=I2pTEgl9UU+mwogpVvb9biyJlssMUpAugyWq9uXXeNs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DuTJ6RP+ZuZi2hL7w2DBw7JE/hz6MAtcva9AKiOUE7AxvGzGy4vcasMeKLQ1L0RjBzwh+vsTq2vQ1aKY5NaWH8EADXG1hw8GNC0Qd2Fu9x5JGdmc/bdK/QzsszMo9OORgebVBczp/gC/QcVle01dC93PYr7Q5PBVH16IvtYsmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv1HcJgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv1HcJgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EF31F00893;
	Mon, 21 Sep 2026 02:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956365;
	bh=l68p6y9NHhQ5pKgUx9BaN4JsbLotPe4iTlUtg3ojSsw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Uv1HcJgdLofEzF9PavymWJvOADIi2uWTL3rwJxvEuadPjw7BKf9XTaOTofIZw/aQ6
	 S4YZNL4A06aX4nPIebMxRmRalSsfvPEJnf3oJIWxAEGvYrHtKu6xOrxRrAA8MyMVcd
	 ZRUO9XQ3Hi+1Pk9l2ia0fibEqqu2YD/hufzUDt3JkaBfopJlfRJ9xmCTVEF/3aJMYJ
	 Lljb/43hNnfHqDJSO0Ft3o2i4Du6beXQOf1OGbgWWrzFWBuCp5LERjFyxlXENJSeeY
	 Aa1izOTEyxO8fR3gXxPtlPiuDqnMTuK5KmZKSaRfbzeN+08f4jDTd0c3Nbq5pT+CTu
	 IskVPZPAepJEg==
Subject: Re: [PATCH net v2] net: stmmac: ethtool: validate TX coalesce before
 reprogramming RX
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 02:06:03 +0000
Message-ID: <178995636352.2160803.2776927980309704252@kernel.org>
In-Reply-To: <20260920015647.1783574-1-xiaolinkui@126.com>
References: <20260920015647.1783574-1-xiaolinkui@126.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the TX validation relocated to the top of
  __stmmac_set_coalesce()…

Pre-existing issues:
- [High] __stmmac_set_coalesce() accepts tx_max_coalesced_frames == 0 as
  long as tx_coalesce_usecs != 0 (the check at stmmac_ethtool.c:855 only…

--

net: stmmac: ethtool: validate TX coalesce before reprogramming RX

The two TX parameter checks in __stmmac_set_coalesce() are moved ahead of the
RX block so that a request rejected because of its TX values no longer
reprograms the RX watchdog and rx_riwt[]/rx_coal_frames[] first.  The
changelog motivates this with the per-queue path, where ethtool reads the
current values back and sends them straight in again.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 1be5310ca766..193b65f9650f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -850,6 +850,16 @@ static int __stmmac_set_coalesce(struct net_device *dev,
>  	else if (queue >= max_cnt)
>  		return -EINVAL;
>  
> +	/* Check TX parameters before applying any RX setting */
> +
> +	if (ec->tx_coalesce_usecs == 0 &&
> +	    ec->tx_max_coalesced_frames == 0)
> +		return -EINVAL;

[Severity: High]
Does this reordering actually fix the per-queue case described in the
changelog?  The relocated check runs for every queue index, but the TX apply
block further down is gated on the queue having a TX ring:

	} else if (queue < tx_cnt) {
		priv->tx_coal_frames[queue] = ec->tx_max_coalesced_frames;
		priv->tx_coal_timer[queue] = ec->tx_coalesce_usecs;
	}

and __stmmac_get_coalesce() deliberately reports zeros for an index that has
no TX ring:

	if (queue < tx_cnt) {
		ec->tx_coalesce_usecs = priv->tx_coal_timer[queue];
		ec->tx_max_coalesced_frames = priv->tx_coal_frames[queue];
	} else {
		ec->tx_coalesce_usecs = 0;
		ec->tx_max_coalesced_frames = 0;
	}

On a device with rx_queues_to_use > tx_queues_to_use (dwmac-intel
tgl_common_data sets 6 RX and 4 TX queues, so queues 4 and 5 are RX-only),
does ethtool -Q ethX queue_mask 0x10 --coalesce rx-usecs N still return
-EINVAL here?

If so, is the net effect for that queue not worse than before?  Previously
the RX watchdog and rx_riwt[]/rx_coal_frames[] were programmed and -EINVAL
was returned; now the early return means the RX part is never applied, so
per-queue RX coalescing on an RX-only queue index has no effect at all.

There is a second consequence in the ethtool core.
ethtool_set_per_queue_coalesce() snapshots the getter output per queue and
replays it on failure, discarding the return code:

net/ethtool/ioctl.c:ethtool_set_per_queue_coalesce() {
	...
roll_back:
	if (ret != 0) {
		tmp = backup;
		for_each_set_bit(i, queue_mask, bit) {
			dev->ethtool_ops->set_per_queue_coalesce(dev, i, tmp);
			tmp++;
		}
	}
	...
}

For an RX-only queue the saved backup necessarily carries tx_coalesce_usecs
== 0 and tx_max_coalesced_frames == 0, so the new first check rejects the
replay before the RX block runs.  Can the RX watchdog and rx_riwt[] of that
queue therefore stay at the values of the failed request after a later queue
in the mask fails?

> +
> +	if (ec->tx_coalesce_usecs > STMMAC_MAX_COAL_TX_TICK ||
> +	    ec->tx_max_coalesced_frames > STMMAC_TX_MAX_FRAMES)
> +		return -EINVAL;
> +
>  	if (priv->use_riwt) {
>  		rx_riwt = stmmac_usec2riwt(ec->rx_coalesce_usecs, priv);
>  
> @@ -875,14 +885,6 @@ static int __stmmac_set_coalesce(struct net_device *dev,

The mirror of the same problem is left in place for a TX-only index.  With
priv->use_riwt set and queue >= rx_cnt, the getter reports
rx_coalesce_usecs = 0, stmmac_usec2riwt() returns 0 and

		if ((rx_riwt > MAX_DMA_RIWT) || (rx_riwt < MIN_DMA_RIWT))
			return -EINVAL;

rejects the request before any TX value is stored.

include/linux/ethtool.h documents both halves of the contract:

 * @get_per_queue_coalesce: ... If only a RX queue or a TX
 *	queue has this number, set the inapplicable fields to ~0 and return 0.
 * @set_per_queue_coalesce: ... If only a RX queue or a TX
 *	queue has this number, ignore the inapplicable fields.

Would making the validation direction-aware, so the TX checks only apply when
all_queues || queue < tx_cnt and the rx_riwt check only when
all_queues || queue < rx_cnt (plus the getter reporting ~0 instead of 0 for
the inapplicable fields), address both directions rather than reordering
alone?

[Severity: High]
This isn't a bug introduced by this patch, but since the validation is being
moved anyway, is the zero tx_max_coalesced_frames case worth handling here
too?  The check above only rejects both TX fields being zero, so
ethtool -C ethX tx-usecs 10 tx-frames 0 stores priv->tx_coal_frames[queue]
== 0, and stmmac_xdp_xmit_xdpf() divides by it with no zero test:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xdp_xmit_xdpf() {
	...
	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
		set_ic = true;
	...
}

That is reached from stmmac_xdp_xmit_back() for XDP_TX and from
stmmac_xdp_xmit() for ndo_xdp_xmit, so does this divide by zero in softirq
context on x86?

The other TX sites do test for zero, but the guard and the divisor are
separate unannotated loads of the same plain u32 with no lock, for example in
stmmac_xmit() and stmmac_tso_xmit():

	else if (!priv->tx_coal_frames[queue])
		set_ic = false;
	...
	else if ((tx_q->tx_count_frames %
		  priv->tx_coal_frames[queue]) < tx_packets)

and in stmmac_xdp_xmit_zc():

		if (!priv->tx_coal_frames[queue])
			set_ic = false;
		else if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)

Can a concurrent ethtool store of 0 land between the guard and the modulo
reload?  Would a single READ_ONCE() snapshot per transmit path be
appropriate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920015647.1783574-1-xiaolinkui%40126.com
