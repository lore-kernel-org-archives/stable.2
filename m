Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE653D813E;
	Wed, 23 Sep 2026 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139496; cv=none; b=Z3MlCxHJWlHWcwaKXxgeN5O21F5tUU2DeSx5gecKmLmlNMJ4okvN7NCIH0n/Hqq1b6j58K5RlhHCCLt3qUIWEOrOiI+eSZfmC2YN0boC9xURAAZvs6PlWcM7/9a31wJAKMLnZj5Ev/c+0NMvDvqIJ5J4TokRdNOqbay57LVB70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139496; c=relaxed/simple;
	bh=mHf8COD6Y5FpzKVDaKecmjQMUoxJMdvsM8LkqffBM+0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m1O0sFUJQka1TOL7WYWcNtN+ye3JVnAp2FUxKw7vQJ4Qr1IZczXNtpDFQ/oew407lPE38PBG++517QCQ1UMpVMpd/qKCuqhvID5zlCA1+ooJlqw4M78b5n6F9ZeA0QRtsH+omGnD6wLseo0LzxxgPhIz+hvCriU7MTkZrB03b2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1jugf1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1jugf1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE861F00898;
	Wed, 23 Sep 2026 04:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790139483;
	bh=PngHwzgKozpjFvH0lkFKvqkOGWSpj101HoFYbImvNfc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A1jugf1lpojoBky9ayD6dUKnqm6d46AVrXmtQd75lXHCmnUgfjvAgSr6YW6fkn0Jn
	 Fs3j1i9UMe2oP84cj1ZFveizmDbbDqwt79Fu9IG6OxfRfbnW4Sa/KKDK7TSTeJM4lI
	 52OptsI7At8F0TK31KS2m4MITs/89U5qBA1FAuMpaFpwnJQS7N6YFQW262VfTxntcl
	 CnjoJKMckMpWx0iTnunVC7RdWOcyFlsZGIxa80atxn4Unrj/gB/KrzJT0xdR6r963I
	 MSK6hojYIe3lR1MwHJzWt0UM+Wc2o6ffubGtk1gnQrZich16UOSLEX36QOJVmhcP8+
	 T2wr2oa1kqpBg==
Subject: Re: [PATCH net v3 1/2] net: stmmac: ethtool: ignore inapplicable
 per-queue coalesce fields
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org
Date: Wed, 23 Sep 2026 04:58:02 +0000
Message-ID: <179013948231.2160803.3048842634064805428@kernel.org>
In-Reply-To: <20260921135716.218420-1-xiaolinkui@126.com>
References: <20260921135716.218420-1-xiaolinkui@126.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit message inaccuracy: the changelog states "The roll-back
  that ethtool_set_per_queue_coalesce() runs for the queues it has…

Pre-existing issues:
- [Medium] On a probed-but-never-opened stmmac interface, every coalesce
  set request is rejected with -EINVAL, including requests that only…
- [Medium] __stmmac_set_coalesce() updates priv->rx_riwt[],
  priv->rx_coal_frames[], priv->tx_coal_frames[] and…
- [Low] Documented ABI vs implementation mismatch in the paired getter:
  include/linux/ethtool.h (kernel-doc for…

--

net: stmmac: ethtool: ignore inapplicable per-queue coalesce fields

The patch makes __stmmac_set_coalesce() derive from the queue index whether
that index has an RX ring, a TX ring or both, and validates and applies only
the directions that exist.  The TX range checks are also moved ahead of the
RX apply block so a rejected request no longer leaves the RX half
reprogrammed.

Link: https://lore.kernel.org/all/20260920015647.1783574-1-xiaolinkui@126.com/

A few questions below, mostly about the changelog and about pre-existing
behaviour that sits next to the modified code.

The changelog says:

  "The roll-back that ethtool_set_per_queue_coalesce() runs
   for the queues it has already changed then trips over the same test and
   cannot restore them."

Is that the mechanism for the read-modify-write flow the changelog itself
describes?  In net/ethtool/ioctl.c the rollback is:

  roll_back:
	if (ret != 0) {
		tmp = backup;
		for_each_set_bit(i, queue_mask, bit) {
			dev->ethtool_ops->set_per_queue_coalesce(dev, i, tmp);

The loop stops at bit, so the failing index is never restored at all.  For
the dwmac-intel EHL example (rx_cnt = 6, tx_cnt = 4, mask 0x3f) indices 0-3
carry both directions, so their backups have non-zero TX fields from
stmmac_init_coalesce() and their restore succeeds.  The half-applied RX state
of index 4 survives because index 4 is excluded from the loop, not because
the rollback hits the TX zero test.

[Severity: Low]
Could that sentence be reworded to match what the rollback loop actually
does?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 1be5310ca766c..daec9cf9eba16 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c

[ ... ]

> @@ -850,7 +852,20 @@ static int __stmmac_set_coalesce(struct net_device *dev,
>  	else if (queue >= max_cnt)
>  		return -EINVAL;
>  
> -	if (priv->use_riwt) {
> +	has_rx = all_queues || queue < rx_cnt;
> +	has_tx = all_queues || queue < tx_cnt;
> +
> +	/* An index can be RX-only or TX-only; ignore the missing side. */
> +	if (has_tx &&
> +	    ec->tx_coalesce_usecs == 0 && ec->tx_max_coalesced_frames == 0)
> +		return -EINVAL;
> +
> +	if (has_tx &&
> +	    (ec->tx_coalesce_usecs > STMMAC_MAX_COAL_TX_TICK ||
> +	     ec->tx_max_coalesced_frames > STMMAC_TX_MAX_FRAMES))
> +		return -EINVAL;

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but should the
paired getter be brought in line at the same time?  The kernel-doc for
ethtool_ops::get_per_queue_coalesce in include/linux/ethtool.h says:

 *	queue has this number, set the inapplicable fields to ~0 and return 0.

__stmmac_get_coalesce() writes 0 instead:

  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c:__stmmac_get_coalesce() {
	if (queue < tx_cnt) {
		...
	} else {
		ec->tx_coalesce_usecs = 0;
		ec->tx_max_coalesced_frames = 0;
	}
	...
	} else {
		ec->rx_max_coalesced_frames = 0;
		ec->rx_coalesce_usecs = 0;
	}
  }

ethtool_get_per_queue_coalesce() copies the driver reply straight to
userspace without translating the sentinel, so ethtool -c --per-queue on an
RX-only index of a 6 RX / 4 TX dwmac-intel part prints tx-usecs: 0 and
tx-frames: 0, and userspace cannot tell "no TX ring at this index" from
"coalescing is 0".  Both halves come from the same commit named in the
Fixes: tag.

> +
> +	if (has_rx && priv->use_riwt) {
>  		rx_riwt = stmmac_usec2riwt(ec->rx_coalesce_usecs, priv);
>  
>  		if ((rx_riwt > MAX_DMA_RIWT) || (rx_riwt < MIN_DMA_RIWT))
> 			return -EINVAL;

[Severity: Medium]
This isn't introduced by this patch either, but does the same "usec 0 ->
riwt 0 -> -EINVAL" failure remain for indices that do have an RX ring before
the first open?

priv->use_riwt is set to 1 in stmmac_hw_init() at probe time, while
priv->rx_riwt[] only gets its DEF_DMA_RIWT default in stmmac_hw_setup():

  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_hw_setup() {
	...
			if (!priv->rx_riwt[queue])
				priv->rx_riwt[queue] = DEF_DMA_RIWT;
	...
  }

Between probe and the first ndo_open, rx_riwt[queue] is 0, so
__stmmac_get_coalesce() reports rx_coalesce_usecs = stmmac_riwt2usec(0) = 0.
__ethnl_set_coalesce() calls ops->get_coalesce and then overwrites only the
attributes present in the request before calling ops->set_coalesce, so that 0
is echoed back and this block computes rx_riwt = stmmac_usec2riwt(0) = 0 and
returns -EINVAL on rx_riwt < MIN_DMA_RIWT, discarding the TX part of the
request as well.

So ethtool -C eth0 tx-usecs 100, or ethtool --per-queue eth0 queue_mask 0x1
--coalesce tx-frames 10, fails until ip link set eth0 up has run once.  The
new has_rx gating removes this only for indices without an RX ring; queue 0
and the all-queues setter still take the path above.

> @@ -866,7 +881,7 @@ static int __stmmac_set_coalesce(struct net_device *dev,
>  				priv->rx_coal_frames[i] =
>  					ec->rx_max_coalesced_frames;
>  			}
> -		} else if (queue < rx_cnt) {
> +		} else {
>  			priv->rx_riwt[queue] = rx_riwt;
>  			stmmac_rx_watchdog(priv, priv->ioaddr,
>  					   rx_riwt, queue);

[ ... ]

> @@ -892,7 +899,7 @@ static int __stmmac_set_coalesce(struct net_device *dev,
>  			priv->tx_coal_timer[i] =
>  				ec->tx_coalesce_usecs;
>  		}
> -	} else if (queue < tx_cnt) {
> +	} else if (has_tx) {
>  		priv->tx_coal_frames[queue] =
>  			ec->tx_max_coalesced_frames;
>  		priv->tx_coal_timer[queue] =

[Severity: Medium]
This is also pre-existing and the changelog does not claim to address it, but
since this hunk newly makes the per-queue TX store reachable for TX-only
indices, is the lack of any serialization here worth a look?

These stores happen in process context under rtnl with no lock and no
WRITE_ONCE(), while the transmit paths read the same fields from softirq
context holding nothing in common:

  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xmit() {
	...
	else if (!priv->tx_coal_frames[queue])
		set_ic = false;
	...
	else if ((tx_q->tx_count_frames %
		  priv->tx_coal_frames[queue]) < tx_packets)
	...
  }

The zero test and the modulo divisor are two separate plain loads of a value
the setter can change in between, and tx_coal_frames may legally be stored as
0 whenever tx_coalesce_usecs is non-zero.  The same check-then-reload appears
in stmmac_tso_xmit() and stmmac_xdp_xmit_zc(), and stmmac_tx_timer_arm()
reads priv->tx_coal_timer[queue] the same way, so a concurrent xmit can also
see the new frame threshold with the old timer.  Note the later
"net: stmmac: fix a divide by zero in stmmac_xdp_xmit_xdpf()" change adds the
missing zero test there but keeps the same unannotated pattern.

Would READ_ONCE()/WRITE_ONCE() on these fields, or reading the divisor once
into a local, be appropriate here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921135716.218420-1-xiaolinkui%40126.com
