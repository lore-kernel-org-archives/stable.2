Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437D2B2D7;
	Wed,  5 Aug 2026 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891984; cv=none; b=j5a75KFRpChZd7bjwGZt5GYtWb7NRUZ2w/xaPck0ebv3+e/H44SLYdRtHz7zf/vgUE3Xl0cvi9XGq2Dq+z8/cgCT1gtOYvYI+K3xr+1I5soPrwZy6H9ej2P0J4E93LVvd8fzgA0UyDXjTm5Eu1SXimVZMGQUZdtZYxcxeZyq9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891984; c=relaxed/simple;
	bh=/CwtU0ZziOedjIL+x8nP5JfjPDyReN+Luy2NUklA2AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyuSEXB32En1Q6bd0tGQzsNnWrJfvvhIhR916K1l2HfCdaE9KzshV+FVKVeqhutYic9WtawOc6E62od/XNJDFujTBA07fQd+z5QQNuVEOViEPbFd7k6TUqDrBBgBux3V+Ic2WDrNnFdJRTE9CND8PT1RMeU1DJLY3hCd5rNLuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqZtRCQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqZtRCQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C381F000E9;
	Wed,  5 Aug 2026 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891982;
	bh=OnA7fFDjN2SsjgCUjMQ2sL7FA/wreeWWw9pJTyQjb2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqZtRCQ3d+cNhg9+XiCf3e2+6Rxxx4SieyW78nvXUKyarsBRG7iXPCK3yekCLbYaO
	 nOPjeJs087FLY/H+cvdGTggF5uwNPP+TXS7Jx8AIxtqs58mwiZr7B+QZU6GgNmK95G
	 PUrsHb+P2ftgLA17hc0NtqlCV+3+AyPBPJ9li8WCSrNtBewiYNTXRkc5xFI6kUA0ae
	 UWlkJYGG066rslSBmoy+TbFwIzGyfXCiPaY2jRhWPG/QWe3sBneyvmoVWLBkFxz4C6
	 AO9ZIJJ0jH9KBRUj3t0QbWID0X5QIkRRfL6GMEoWBkEAIneJV74/i8qXrFCs12N7b/
	 9jMRaWPc747Gw==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	niklas.soderlund@ragnatech.se,
	paul@pbarker.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	luoxuanqiang@kylinos.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ravb: fix use-after-free in ravb_get_ts_info
Date: Tue,  4 Aug 2026 18:06:20 -0700
Message-ID: <20260805010620.4093075-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802090750.116215-1-xuanqiang.luo@linux.dev>
References: <20260802090750.116215-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ravb: fix use-after-free in ravb_get_ts_info

This clears priv->ptp.clock in ravb_ptp_stop() after unregistering the PHC,
so that ravb_get_ts_info() no longer hands a dangling pointer to
ptp_clock_index().  It also gates the whole hardware timestamping capability
block in ravb_get_ts_info() on priv->ptp.clock being set.

A few questions on the changelog and on the new guards.

> The PHC is registered by ravb_open() and unregistered by ravb_close().
> However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
> clock. Since the netdev remains registered after ndo_stop, get_ts_info
> can still pass the dangling pointer to ptp_clock_index(), resulting in a
> use-after-free.

[Severity: Low]
Should the changelog also mention the plain NULL dereference case?
ravb_ptp_init() is only reached from ravb_open(), ravb_wol_restore() /
ravb_resume(), ravb_set_ringparam() and ravb_tx_timeout_work(), never from
ravb_probe().

So between register_netdev() and the first open, priv->ptp.clock is NULL,
and pre-patch ravb_get_ts_info() passed it directly to ptp_clock_index(),
which is just:

drivers/ptp/ptp_clock.c:ptp_clock_index() {
	return ptp->index;
}

That means ethtool -T on a gptp/ccc_gac ravb interface that has never been
brought up faulted too.  Since this carries Cc: stable, would it help
backport triage to state that the most easily reachable manifestation is a
NULL dereference in the never-opened state, not only a dangling pointer read
after close?

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 5f88733094d0f..f22cff05ba35d 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1768,7 +1768,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *hw_info = priv->info;
>  
> -	if (hw_info->gptp || hw_info->ccc_gac) {
> +	if ((hw_info->gptp || hw_info->ccc_gac) && priv->ptp.clock) {

[Severity: High]
This isn't a bug introduced by this patch, but does a NULL-only test cover
the failure mode that actually puts an invalid pointer in priv->ptp.clock?
ravb_ptp_init() stores the return value unchecked:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_init() {
	...
	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
}

With CONFIG_PTP_1588_CLOCK=y, ptp_clock_register() returns ERR_PTR(-EINVAL),
ERR_PTR(-ENOMEM) or ERR_PTR(err) on failure, so priv->ptp.clock can be a
non-NULL error pointer.  An error pointer passes the new test here and then
reaches ptp_clock_index(), which is a bare return ptp->index, and it also
passes the new test in ravb_ptp_stop() and reaches ptp_clock_unregister(),
which dereferences it right away via ptp_vclock_in_use(ptp) and
get_device(&ptp->dev).

Would !IS_ERR_OR_NULL(priv->ptp.clock) be the right guard, plus having
ravb_ptp_init() normalize a failed registration to NULL?  The sibling driver
does check: rcar_gen4_ptp_register() tests IS_ERR() and propagates
PTR_ERR().

[Severity: Medium]
Is suppressing the entire block, rather than just phc_index, the intended
behaviour change?  With no PHC registered, ethtool -T now reports
tx_types = 0, rx_filters = 0 and loses SOF_TIMESTAMPING_TX_SOFTWARE, since
__ethtool_get_ts_info() only ORs back:

net/ethtool/common.c:__ethtool_get_ts_info() {
	...
	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
				 SOF_TIMESTAMPING_SOFTWARE;
}

Meanwhile the peer paths in the same driver still implement all of it:
ravb_hwtstamp_set() still accepts HWTSTAMP_TX_ON and
HWTSTAMP_FILTER_PTP_V2_L2_EVENT (and silently promotes unknown filters to
HWTSTAMP_FILTER_ALL), ravb_start_xmit() still calls skb_tx_timestamp(), and
the receive path still fills skb_hwtstamps().

There is a second effect on CONFIG_PTP_1588_CLOCK=n builds.  CONFIG_RAVB
depends on PTP_1588_CLOCK_OPTIONAL and ravb_ptp.o is linked
unconditionally, and the stub is:

include/linux/ptp_clock_kernel.h {
	static inline struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
							   struct device *parent)
	{ return NULL; }
}

so priv->ptp.clock is permanently NULL there and this block becomes dead
code, even though the timestamping registers are still programmed and the
hwtstamp ioctl still works.  Before the patch those builds reported the
hardware filters with phc_index == -1.

Also, ethtool -T is generally read as static device capability, but it now
changes with interface up/down because the PHC lifetime follows
ravb_open()/ravb_close().  Would keeping the capability bits and only
computing info->phc_index when a PHC exists be a narrower fix?

>  		info->so_timestamping =
>  			SOF_TIMESTAMPING_TX_SOFTWARE |
>  			SOF_TIMESTAMPING_TX_HARDWARE |

[ ... ]

> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 226c6c0ab945b..fc8c601ed3a5e 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -337,5 +337,8 @@ void ravb_ptp_stop(struct net_device *ndev)
>  	ravb_write(ndev, 0, GIC);
>  	ravb_write(ndev, 0, GIS);
>  
> -	ptp_clock_unregister(priv->ptp.clock);
> +	if (priv->ptp.clock) {
> +		ptp_clock_unregister(priv->ptp.clock);
> +		priv->ptp.clock = NULL;
> +	}
>  }

[Severity: Medium]
Can this new NULL store race the interrupt handler?  ravb_ptp_interrupt()
reads the same field in hardirq context and passes it on without a NULL
check:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_interrupt() {
	u32 gis = ravb_read(ndev, GIS);

	gis &= ravb_read(ndev, GIC);
	if (gis & GIS_PTCF) {
		...
		event.timestamp = ravb_read(ndev, GCPT);
		ptp_clock_event(priv->ptp.clock, &event);
	}
	...
}

The locksets do not intersect: ravb_ptp_interrupt() runs from
ravb_interrupt()/ravb_multi_interrupt() under spin_lock(&priv->lock), while
ravb_ptp_stop() runs in process context and takes no lock.  The irqs are
installed with devm_request_irq() at probe and stay installed while the
interface is down, and ravb_close() calls ravb_ptp_stop() before
ravb_stop_dma() and before napi_disable().

Writing GIC = 0 first does not appear to close the window, because the
handler's guard gis &= ravb_read(ndev, GIC) may already have been sampled:

CPU0 (hardirq)
    reads GIS (GIS_PTCF set), reads GIC (GIC_PTCE set)
    ravb_read(ndev, GCPT)          <-- slow MMIO read

CPU1 (ravb_close)
    ravb_write(ndev, 0, GIC);
    ptp_clock_unregister(priv->ptp.clock);
    priv->ptp.clock = NULL;

CPU0 (hardirq, continues)
    ptp_clock_event(NULL, &event); <-- spin_lock_irqsave(&ptp->tsevqs_lock)

Would masking GIC, then serializing with the handler (clearing the pointer
under spin_lock_irqsave(&priv->lock), or synchronize_irq() on the
DMAC/gPTP irq), and only then calling the sleeping ptp_clock_unregister()
on a local copy be safer?  Should ravb_ptp_interrupt() also tolerate a NULL
clock now that NULL is a reachable state while the irq is live?

[Severity: Medium]
Does clearing the pointer only after ptp_clock_unregister() returns leave
part of the use-after-free in place?  ravb_get_ts_info() does two separate
loads of priv->ptp.clock, one for the new test and one for
ptp_clock_index(), and there is no lock shared with this writer.

The assumption that RTNL serializes the two sides does not seem to hold.
__ethtool_get_ts_info() calls ops->get_ts_info() under nothing stronger
than rcu_read_lock(), and it is reachable from setsockopt(SO_TIMESTAMPING,
SOF_TIMESTAMPING_BIND_PHC):

net/core/sock.c:sock_timestamping_bind_phc() {
	...
	num = ethtool_get_phc_vclocks(dev, &vclock_index);
	dev_put(dev);
	...
}

which holds only a dev_get_by_index() reference, no rtnl_lock().  So:

CPU0 (setsockopt)                    CPU1 (ip link set down)
ravb_get_ts_info()
  priv->ptp.clock != NULL            ravb_ptp_stop()
                                       ptp_clock_unregister(...)
                                       priv->ptp.clock = NULL;
  ptp_clock_index(priv->ptp.clock)
    return ptp->index;   <-- NULL

And during the window where the pointer is still non-NULL but
ptp_clock_unregister() is sleeping in the device_del()/put_device() path, a
reader can still use a clock that is being torn down; ptp_clock_release()
ends in a plain kfree(ptp) with no RCU deferral and the reader holds no
kref.

Would loading and clearing the pointer once under a lock shared with the
reader (for example priv->lock), and clearing it before the unregister,
close both of these?
-- 
pw-bot: cr
