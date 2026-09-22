Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192E3955F9;
	Tue, 22 Sep 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064035; cv=none; b=pxRAeZxJeg0ogEZt32wrkzXRZZLsP0FAsFCAVXhkstDifjXqLRxGMonZo4Fix1qnWvF4KUbImNLwbjL1D5HNvQSsFFvVS5XmtOGG/XWRN07VfxBZdC7Iaj9nAqELVLSUcUE/Bpftxale2fuTI77lP6znhU0pSg9SUnjLxEC2AOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064035; c=relaxed/simple;
	bh=TnjqiNDXYtqup4Pnr5urnY3VPyThkRbI60h0HDM1LUs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QiZvCuR4rBuh4utdns7nzChGogNatVQjA2YP1rhoqyXJQHD6OTRXWXcK7Vs7AqPWh2dGCTrmzYlmCvKjeDE7MTjnFLKdIeuEBInHJ6LTLrKZ+xFkGermGFAnI9yL/sapW9YeHtSAlzWJxtaIbRMkJ8QJQG04pggbgijMeX4ol34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoMOZvj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoMOZvj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAEF1F000FF;
	Tue, 22 Sep 2026 08:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790064017;
	bh=EMpVZZM5mC5bVjvCbhkmvo7doDXZJI1s6X0JLg7H8fY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NoMOZvj/oQcw4O8ehRCuxfMzUk5zWdTOXEEPLjKbcNHJQaOL7YaRwkvbwY3m/Isv1
	 8nnQcW8R7RynLj7PNT1MZExpIQ932pIyVKiL5NfUOcPAiZFnFNIiz0bZZQMz9Ly6Dl
	 FaSVUUyLwtHq3t7PISIEPsg1xoVSNYdqGtolzuM8vOtHdpgf1Au/3irEvsASSeNOt3
	 FLAGkZUZiTm6nSSN9cPLdr/GCJSzpVGyFgTjfM0MPUkDY1mBgeN5z99n/GajHrwSLc
	 fZadecHeoUdYjQUiAV6zZFVKydcPALRR/nwR9asOZ9aaNJFGuPMJ3qT1JdbK38PsqR
	 fbvGr0kEVjjKg==
Subject:
 Re: [PATCH net] net: macb: take bp->lock around NCR read-modify-writes
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.ferre@microchip.com, sean.anderson@linux.dev, atenart@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 stable@vger.kernel.org
Date: Tue, 22 Sep 2026 08:00:15 +0000
Message-ID: <179006401584.2160803.17052380807773862185@kernel.org>
In-Reply-To: <20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com>
References: <20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete NCR read-modify-write serialization: the patch takes
  bp->lock around the NCR RMW in macb_mac_link_down(),…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the work item
  it modifies (bp->hresp_err_bh_work / macb_hresp_error_task) is queued…
- [Medium] macb_hresp_error_task() performs a multi-step RE/TE state
  transition that per-RMW locking cannot protect: it clears NCR.RE|TE…

--

net: macb: take bp->lock around NCR read-modify-writes

The patch wraps the NCR read-modify-write sequences in
macb_mac_link_down(), macb_mac_link_up() and macb_hresp_error_task() with
spin_lock_irqsave(&bp->lock)/spin_unlock_irqrestore(), so that they no
longer race with the TSTART and RE writers that already hold bp->lock.
It is described as a theoretical fix that only aims at consistent NCR
read-modify-write operations.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index b8234ac4b602..b58d3f01f2cc 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -786,8 +787,10 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
>  				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
>  
>  	/* Disable Rx and Tx */
> +	spin_lock_irqsave(&bp->lock, flags);
>  	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
>  	macb_writel(bp, NCR, ctrl);
> +	spin_unlock_irqrestore(&bp->lock, flags);
>  
>  	netif_tx_stop_all_queues(netdev);
>  }

[Severity: High]

The commit message enumerates the NCR read-modify-write sites, but a few
more exist that still do not take bp->lock.  Should they be converted
too, or the changelog mention that they are knowingly left out?

In macb_ptp.c, gem_ptp_set_one_step_sync() does:

	reg_val = macb_readl(bp, NCR);

	if (enable)
		macb_writel(bp, NCR, reg_val | MACB_BIT(OSSMODE));
	else
		macb_writel(bp, NCR, reg_val & ~MACB_BIT(OSSMODE));

and gem_set_hwtst() does:

	regval = macb_readl(bp, NCR);
	macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));

Both are reached from ndo_hwtstamp_set -> macb_hwtstamp_set(), which
returns -EINVAL unless netif_running(), so they only run while the
interface is up, concurrently with the newly locked phylink callbacks and
with the bp->lock-holding macb_start_xmit()/macb_interrupt() writers.

Can that lose an update in either direction?  If the hwtstamp path samples
NCR, macb_mac_link_up() then sets RE|TE(|PTPUNI) under bp->lock, and the
hwtstamp path writes back its stale image, RE/TE end up clear while the
driver has already woken the queues; in the mirror case SRTSM/OSSMODE is
dropped and hardware timestamping is not armed.

The at91ether paths have the same shape.  at91ether_interrupt() does an
NCR read-modify-write from hard IRQ with no lock at all:

	/* Work-around for EMAC Errata section 41.3.1 */
	if (intstatus & MACB_BIT(RXUBR)) {
		ctl = macb_readl(bp, NCR);
		macb_writel(bp, NCR, ctl & ~MACB_BIT(RE));
		wmb();
		macb_writel(bp, NCR, ctl | MACB_BIT(RE));
	}

Since the driver registers a single phylink instance with
macb_phylink_ops, EMAC parts use exactly the macb_mac_link_up() /
macb_mac_link_down() callbacks being locked here, while nothing on the
at91ether side takes bp->lock.  Can this handler re-arm RE right after
macb_mac_link_down() cleared it, or right after at91ether_stop() cleared
RE|TE and went on to at91ether_free_coherent()?  at91ether_start(),
at91ether_stop() and at91ether_open() also do unlocked NCR
read-modify-writes.

Finally, macb_reset_hw() performs the same RE|TE clear plus CLRSTAT
read-modify-write and is reached both with bp->lock held (macb_close(),
macb_suspend()) and without it (macb_init_hw() from macb_open() and
macb_resume()), so the locking rule for NCR is not uniform after this
patch.  Would funnelling all NCR read-modify-writes through one locked
helper be preferable?

[ ... ]

> @@ -940,11 +943,13 @@ static void macb_mac_link_up(struct phylink_config *config,
>  	}
>  
>  	/* Enable Rx and Tx; Enable PTP unicast */
> +	spin_lock_irqsave(&bp->lock, flags);
>  	ctrl = macb_readl(bp, NCR);
>  	if (gem_has_ptp(bp))
>  		ctrl |= MACB_BIT(PTPUNI);
>  
>  	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> +	spin_unlock_irqrestore(&bp->lock, flags);
>  
>  	netif_tx_wake_all_queues(netdev);
>  }

[ ... ]

> @@ -2003,9 +2009,11 @@ static void macb_hresp_error_task(struct work_struct *work)
>  					 MACB_TX_INT_FLAGS |
>  					 MACB_BIT(HRESP));
>  	}
> +	spin_lock_irqsave(&bp->lock, flags);
>  	ctrl = macb_readl(bp, NCR);
>  	ctrl &= ~(MACB_BIT(RE) | MACB_BIT(TE));
>  	macb_writel(bp, NCR, ctrl);
> +	spin_unlock_irqrestore(&bp->lock, flags);
>  
>  	netif_tx_stop_all_queues(netdev);
>  	netif_carrier_off(netdev);

[Severity: High]

This isn't a bug introduced by this patch, but while looking at the work
item being modified here: bp->hresp_err_bh_work is queued from hard IRQ in
macb_interrupt():

	if (status & MACB_BIT(HRESP)) {
		queue_work(system_bh_wq, &bp->hresp_err_bh_work);

and it is never cancelled on the close path.  macb_close() only does
cancel_delayed_work_sync(&bp->tx_lpi_work) before macb_reset_hw() and
macb_free(bp); the single cancel_work_sync(&bp->hresp_err_bh_work) in the
driver lives in macb_remove().

macb_free() dma_free_coherent()s the descriptor rings and then does:

	queue->tx_ring = NULL;
	queue->rx_ring = NULL;

If an HRESP interrupt arrives just before dev_close() clears
__LINK_STATE_START, so macb_interrupt()'s !netif_running() bail does not
fire, can the work still run after macb_free()?  macb_hresp_error_task()
has no netif_running() check and calls:

	bp->macbgem_ops.mog_init_rings(bp);

	/* Initialize TX and RX buffers */
	macb_init_buffers(bp);

which dereference queue->tx_ring / queue->rx_ring and reprogram
queue->RBQP/TBQP with the freed DMA addresses, then re-enable RE|TE and
call netif_carrier_on() / netif_tx_start_all_queues() on a closed netdev.
Would a cancel_work_sync(&bp->hresp_err_bh_work) in macb_close() (or a
state check in the worker) be appropriate?

> @@ -2022,8 +2030,10 @@ static void macb_hresp_error_task(struct work_struct *work)
>  			     MACB_TX_INT_FLAGS |
>  			     MACB_BIT(HRESP));
>  
> -	ctrl |= MACB_BIT(RE) | MACB_BIT(TE);
> -	macb_writel(bp, NCR, ctrl);
> +	spin_lock_irqsave(&bp->lock, flags);
> +	ctrl = MACB_BIT(RE) | MACB_BIT(TE);
> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | ctrl);
> +	spin_unlock_irqrestore(&bp->lock, flags);
>  
>  	netif_carrier_on(netdev);
>  	netif_tx_start_all_queues(netdev);

[Severity: Medium]

This is a pre-existing property rather than something introduced here, and
the changelog does say the lock is not taken "hoping to protect against
full races inbetween BH scheduling concurrently", so this is mostly a note
on what the new critical sections do and do not cover.

macb_hresp_error_task() is a multi-step transition: it clears RE|TE under
bp->lock, drops the lock, rebuilds hardware-visible state outside it
(mog_init_rings() and macb_init_buffers() rewrite descriptor fields and
queue->RBQP/TBQP), and only re-takes the lock for the final unconditional
RE|TE set above.

During that unlocked window macb_mac_link_up() can take bp->lock and set
RE|TE, and an in-flight macb_interrupt() that already sampled RXUBR runs:

	ctrl = macb_readl(bp, NCR);
	macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
	wmb();
	macb_writel(bp, NCR, ctrl | MACB_BIT(RE));

which restores RE regardless of the worker having deliberately cleared it.
Can the engines then fetch descriptors while the rings are still being
rewritten?

The reverse direction is also visible: if macb_mac_link_down() clears
RE|TE and stops the queues while recovery is in progress, the final hunk
sets RE|TE and calls netif_carrier_on() / netif_tx_start_all_queues()
anyway, undoing the link-down transition.  Would it be worth stating in
the changelog that these multi-step sequences remain uncoordinated?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-macb-ncr-rmw-v1-1-30c3494f93cd%40bootlin.com
