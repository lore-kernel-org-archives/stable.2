Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292E231836;
	Mon,  5 Oct 2026 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224460; cv=none; b=N9iL99NFr0emZu0vgQmbV3jvkPTZ1D2jSFu4zTpjRfXdm8fQVjk5sbU0uE7ypCirzNnEEbKLTBBTEPA/MWITXXOQq23H/Bl5SxMZTXL795DbTQSN0Uvoh2JlZd0ze2rSMoXu3y1sHg/20sPwFr/rg+vj8gBflvLBpGXSGfGbs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224460; c=relaxed/simple;
	bh=T+VVep/92PKjE2kTJDVWKSX/tmgRSpIQlYXRtCMUT9Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1bdMAy7g2Y/lDVBeIiKTMlm3fTYvAfuK43Vm4eF2h7D1SQjg79QZfYSBmEHL2joV8/dp3oD4FstBMzxKQU8fmk39H4Vc7g91DOxFpv9t/g39xWb+K1m+OID0jGAIDj6tL2ti0Tps5/c7KvR3PGjFQ5gzJbsAD+cDJlt4gQVKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgB7UOTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgB7UOTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9624C1F000FF;
	Mon,  5 Oct 2026 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791224458;
	bh=0jzubDrM1LBV2q2TOEssRBj48zjVZ8LqA0rRiUNuvyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NgB7UOTcYo6hS5I89BxvF58JQ075hcU+uMWcHM8cfmgZtYHEhobSKu8ENmT2/MYMy
	 tcS5y2wAMZTUZMYqvPwQ3TBwmhjZ4QEfLfu5wvRav44hUlk+dAA5bH5FFRgYsgkWln
	 9tC4qOsrW98x6LHNdtHqL3WcgOv+huOdvQZ4Owz+8wHnpUuqtcgTYyXKD3WyCfTwnf
	 m6O3ZZs0hkn9LHs6kdWWh3hbvFwUlj0eIhai4jEkPJHdwXVpZ75+aUxhFcp6EhmMnB
	 U6ELYzNkT4gmdUwbsbrSbksX2xYZ/XpkUzvjCFscLovwIC3h24z2DB26VSLPtu7n+f
	 QIh0vr2xdAOUQ==
Subject: Re: [PATCH net RESEND] net: fec: drain PEROUT requests before
 canceling the timer
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: wei.fang@nxp.com, netdev@vger.kernel.org, frank.li@nxp.com,
 shenwei.wang@nxp.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, horms@kernel.org,
 stable@vger.kernel.org, ae878000@gmail.com
Date: Mon, 05 Oct 2026 18:20:57 +0000
Message-ID: <179122445706.434549.1378689403745992657@kernel.org>
In-Reply-To: <20261001180258.4054391-1-mhun512@gmail.com>
References: <20261001180258.4054391-1-mhun512@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (2) · Medium: 1 (2) · Low: 1 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: fec: use-after-free of ptp_clock in fec_pps_interrupt
- [Medium] With the new `if (fep->ptp_clk_on)` guard,
  fec_ptp_pps_disable() can clear `fep->perout_enable` while skipping…
- [Low] The patch applies the new clock-off guard
  (`mutex_lock(&ptp_clk_mutex)` + `if (fep->ptp_clk_on)`) to only one of…

Pre-existing issues:
- [High] fec_ptp_stop() runs while the netdev is still registered.
- [High] fec_ptp_stop() unregisters the PTP clock without first draining
  the PPS interrupt handler.
- [Medium] The PEROUT enable path in fec_ptp_enable() publishes state
  before arming it: - Under ptp_clk_mutex and tmreg_lock it sets…
- [Medium] PPS and PEROUT share the same compare channel
  (fep->pps_channel).
- [Low] fec_ptp_enable_pps() checks `fep->perout_enable` before its
  `pps_enable == enable` no-op check.
- [Low] fec_ptp_init() copies `fsl,pps-channel` from the device tree
  straight into fep->pps_channel (fec_ptp.c:753-754) without a range…

--

net: fec: drain PEROUT requests before canceling the timer

The commit changes the order in fec_ptp_stop(). ptp_clock_unregister() now
runs before the PEROUT hrtimer is canceled, and fec_ptp_pps_disable() and the
PPS disable come after it. fec_ptp_pps_disable() now takes ptp_clk_mutex and
skips the TCSR write when the PTP clock is off.

> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 56801c2009d59..67901e036ac32 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -506,10 +506,13 @@ static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
>  
>  	hrtimer_cancel(&fep->perout_timer);

[Severity: Medium]
This is a pre-existing issue, but can a concurrent PEROUT enable still arm
the timer or the hardware after this cancel has run?

In fec_ptp_enable(), the enable path sets the state and drops both locks
before it arms anything:

fec_ptp_enable() {
    ...
			fep->perout_enable = true;

unlock:
			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
			mutex_unlock(&fep->ptp_clk_mutex);
    ...
			if (delta > FEC_PTP_MAX_NSEC_COUNTER) {
				timeout = ns_to_ktime(delta - NSEC_PER_SEC);
				hrtimer_start(&fep->perout_timer, timeout, HRTIMER_MODE_REL);
			} else {
				return fec_ptp_pps_perout(fep);
			}
    ...
}

Suppose a PEROUT disable runs fec_ptp_pps_disable() inside that window:

- hrtimer_cancel() finds nothing armed.
- perout_enable is cleared and TCSR is zeroed.
- The enable thread then starts the hrtimer or programs toggle mode.

That leaves a live timer or periodic output while perout_enable == false. A
later PPS enable would then pass its perout_enable check on the same
channel.

This looks reachable because period_store() in drivers/ptp/ptp_sysfs.c calls
ops->enable() without ptp->pincfg_mux, while the chardev path holds it.

With this patch's teardown order, the hrtimer is canceled only after
ptp_clock_unregister() has drained sysfs and chardev users. So this is a
state mismatch rather than a use-after-free.

>  
> +	mutex_lock(&fep->ptp_clk_mutex);
>  	spin_lock_irqsave(&fep->tmreg_lock, flags);
>  	fep->perout_enable = false;
> -	writel(0, fep->hwp + FEC_TCSR(channel));
> +	if (fep->ptp_clk_on)
> +		writel(0, fep->hwp + FEC_TCSR(channel));

[Severity: Medium]
Can this leave the compare channel armed while the driver records PEROUT as
disabled?

When ptp_clk_on is false, perout_enable is cleared but the only write that
disarms TCSR(pps_channel) is skipped. Nothing replays that write later.

A possible sequence:

1. PEROUT is armed. fec_ptp_pps_perout() sets toggle mode, TIE and TF in
   TCSR.

2. ip link set down. On FEC_QUIRK_HAS_MULTI_QUEUES parts (and with
   NO_HARD_RESET plus link), fec_stop() -> fec_ctrl_reset() only writes
   ECNTRL = 0, without FEC_ECR_RESET. fec_ptp_restore_state() only
   reprograms PPS. fec_enet_clk_enable(false) then sets ptp_clk_on = false
   with the channel still armed.

3. A PEROUT-off request (chardev period 0, or a write to the sysfs period
   file) reaches fec_ptp_enable() -> fec_ptp_pps_disable(). There is no
   ptp_clk_on check on that path. perout_enable becomes false, but TCSR is
   not written.

4. ip link set up. fec_restart() again does no hard reset, and
   fec_ptp_restore_state() does not touch TCSR for PEROUT. Once clk_ptp
   runs, the stale channel fires and fec_pps_interrupt() keeps reloading
   TCCR, so the output pin keeps toggling.

Before this patch the write was unconditional. Whether this misbehaves
depends on hardware: whether TCSR survives clock gating, and whether the old
unconditional write took effect with clk_ptp gated.

[Severity: Medium]
This isn't a bug introduced by this patch, but can a PEROUT disable silently
stop an active PPS output here?

PPS and PEROUT share fep->pps_channel, but they exclude each other only on
the enable side. In fec_ptp_enable(), a PEROUT request with on = 0 goes
straight to:

		} else {
			fec_ptp_pps_disable(fep, fep->pps_channel);
		}

There is no pps_enable check first. This writes TCSR(pps_channel) = 0 while
PPS is running, which clears TMODE and TIE, but fep->pps_enable stays 1.

The driver then reports PPS as enabled, but the hardware no longer generates
PPS interrupts or events.

[ ... ]

> @@ -856,11 +859,12 @@ void fec_ptp_stop(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  
> -	if (fep->pps_enable)
> -		fec_ptp_enable_pps(fep, 0);
> -
>  	cancel_delayed_work_sync(&fep->time_keep);
> -	hrtimer_cancel(&fep->perout_timer);
>  	if (fep->ptp_clock)
>  		ptp_clock_unregister(fep->ptp_clock);

[Severity: High]
Does moving the PPS disable after ptp_clock_unregister() open a
use-after-free of fep->ptp_clock in fec_pps_interrupt()?

Before this patch, fec_ptp_stop() cleared pps_enable and zeroed
TCSR(pps_channel) before the clock was unregistered. Now the driver's
own fec_ptp_enable_pps(fep, 0) runs only after ptp_clock_unregister()
has done its final put_device(). That put can free the ptp_clock and
its pps_source.

The interrupt handler checks pps_enable without a lock and then uses
the clock:

	if (fep->pps_enable) {
		event.type = PTP_CLOCK_PPS;
		ptp_clock_event(fep->ptp_clock, &event);
	}

The irq is requested with devm_request_irq() in fec_ptp_init(), so it
stays live until after fec_drv_remove() returns.

Some trees have a ptp_clock_unregister() that does not disable PPS
itself, and this patch is tagged for stable. There, pps_enable stays
1 and the compare channel stays armed with TIE set for the whole
unregister. The next compare event, at most a second or two later,
then does:

fec_pps_interrupt()
  fep->pps_enable == 1
  ptp_clock_event(fep->ptp_clock)   <- freed by put_device()

On such a tree, the fec_ptp_enable_pps(fep, 0) call that now follows
unregister comes too late to prevent this.

Where ptp_disable_all_events() does call fec_ptp_enable_pps(fep, 0)
from inside unregister, the window is smaller but not closed. That
call clears pps_enable under tmreg_lock. The handler does not take
tmreg_lock, and nothing calls synchronize_irq(). A handler that has
already passed the check can still reach the freed clock. That part
was already possible before this patch.

The hrtimer race described in the commit message only needs the
PEROUT cleanup to run after unregister. Could the PPS disable stay
before ptp_clock_unregister()? It could be followed by a
synchronize_irq() on the PPS interrupt, so the handler is quiesced
before the clock and pps_source are released.

[Severity: High]
This is a pre-existing issue, but is the PPS interrupt handler drained before
ptp_clock_unregister() releases the clock?

fec_pps_interrupt() checks pps_enable without a lock and then uses the
clock:

		if (fep->pps_enable) {
			event.type = PTP_CLOCK_PPS;
			ptp_clock_event(fep->ptp_clock, &event);
		}

ptp_clock_unregister() does:

	ptp_disable_all_events(ptp);
	...
	if (ptp->pps_source)
		pps_unregister_source(ptp->pps_source);

	/* The final put, normally here, will invoke ptp_clock_release(). */
	put_device(&ptp->dev);

A possible interleaving:

CPU1 (fec_pps_interrupt)
  passes the fep->pps_enable check

CPU0 (fec_ptp_stop)
  ptp_clock_unregister()
    ptp_disable_all_events()
      fec_ptp_enable_pps(fep, 0)   <- tmreg_lock does not exclude the handler
    pps_unregister_source()
    put_device()                   <- frees pps_device and ptp_clock

CPU1
  ptp_clock_event()
    pps_event(ptp->pps_source)     <- takes pps->lock on freed memory

The irq is requested with devm_request_irq() in fec_ptp_init(), so it stays
live until after remove returns. Nothing calls synchronize_irq() or
disable_irq() before the clock and PPS source are released.

On PREEMPT_RT the force-threaded handler is preemptible, which widens the
window.

[Severity: Low]
This isn't a bug introduced by this patch, but does removal with PEROUT
active always log a spurious "PEROUT is running" error here?

The call chain is ptp_clock_unregister() -> ptp_disable_all_events() ->
fec_ptp_enable(PTP_CLK_REQ_PPS, 0) -> fec_ptp_enable_pps(fep, 0).
fec_ptp_enable_pps() checks perout_enable before its no-op check:

	if (fep->perout_enable) {
		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
		dev_err(&fep->pdev->dev, "PEROUT is running");
		return -EBUSY;
	}

	if (fep->pps_enable == enable) {

fec_ptp_stop() clears perout_enable only after ptp_clock_unregister()
returns. So a PPS disable that should be a no-op returns -EBUSY and logs an
error on every such removal.

> +
> +	/* An in-flight PEROUT ioctl can arm the timer until unregister returns. */
> +	fec_ptp_pps_disable(fep, fep->pps_channel);

[Severity: Low]
This is a pre-existing issue, but fep->pps_channel comes straight from the
device tree in fec_ptp_init() without a range check:

	fep->pps_channel = DEFAULT_PPS_CHANNEL;
	of_property_read_u32(np, "fsl,pps-channel", &fep->pps_channel);

It is then used in FEC_TCSR(n), which is 0x608 + n * 0x08, while the driver
defines MAX_TIMER_CHANNEL as 3. With this new unconditional call, a malformed
fsl,pps-channel value would cause an MMIO write outside the timer channel
block on every remove or probe failure, whenever ptp_clk_on is set.

The same unchecked index is already used by fec_ptp_enable_pps(),
fec_ptp_pps_perout() and fec_pps_interrupt().

Should the value be checked against MAX_TIMER_CHANNEL when it is read?

> +	if (fep->pps_enable)
> +		fec_ptp_enable_pps(fep, 0);
>  }

[Severity: Low]
Can this check ever be true on the remove path?

ptp_caps.pps is set, so ptp_clock_unregister() above has already done:

ptp_clock_unregister()
  ptp_disable_all_events()
    fec_ptp_enable(PTP_CLK_REQ_PPS, 0)
      fec_ptp_enable_pps(fep, 0)   <- sets pps_enable = 0

So pps_enable is normally 0 by the time this runs, and the "then disable
PPS" step described in the commit message does nothing here.

Related to that, the new ptp_clk_mutex / ptp_clk_on guard is only added in
fec_ptp_pps_disable(). The disable branch of fec_ptp_enable_pps() writes the
same register with only tmreg_lock held:

	} else {
		writel(0, fep->hwp + FEC_TCSR(fep->pps_channel));
	}

That is the write that actually runs inside ptp_clock_unregister().

This looks reachable: enable PPS, run ip link set down, then remove the
driver.

- fec_stop() -> fec_ptp_restore_state() re-enables PPS, leaving
  pps_enable = 1.
- fec_enet_clk_enable(false) gates clk_ptp and clears ptp_clk_on.
- fec_drv_remove() only resumes ipg/ahb through pm_runtime_get_sync().

In that state, the new guard skips the PEROUT write, but the PPS write to the
same channel still happens with clk_ptp gated.

If the guard is needed, should fec_ptp_enable_pps() have it too? If it is
not needed, is the new conditional in fec_ptp_pps_disable() necessary?

[Severity: High]
This is a pre-existing issue, but can a concurrent fec_restart() re-enable
PPS after this one-shot check?

fec_drv_remove() calls fec_ptp_stop() before unregister_netdev() and without
rtnl:

	fec_ptp_stop(pdev);
	unregister_netdev(ndev);

So fec_restart() can still run, from fec_enet_open(), link change or ethtool
paths. fec_restart() calls fec_ptp_save_state() first and
fec_ptp_restore_state() last, and restore_state does:

	if (fep->ptp_saved_state.pps_enable) {
		/* Re-enable PPS */
		fec_ptp_enable_pps(fep, 1);
	}

A possible interleaving:

fec_restart()                      fec_drv_remove()->fec_ptp_stop()
  fec_ptp_save_state()
    saved pps_enable = 1
                                   ptp_clock_unregister()
                                     ptp_disable_all_events()
                                       pps_enable = 0
                                     pps_unregister_source()
                                     put_device()  <- may free ptp_clock
                                   if (fep->pps_enable)  <- false
  fec_ptp_restore_state()
    fec_ptp_enable_pps(fep, 1)
      pps_enable = 1, TCSR armed with TIE

When the compare fires 1-2 seconds later, before close gates clk_ptp:

fec_pps_interrupt()
  ptp_clock_event(fep->ptp_clock)   <- freed
    pps_event(ptp->pps_source)      <- freed

fep->ptp_clock is never cleared after unregister, and nothing serialises
fec_restart() against fec_ptp_stop(). The close path inside
unregister_netdev() also goes through fec_stop() and restore_state, which
re-arms PPS once more before clk_ptp is gated.

This patch narrows one interleaving by disabling PPS again after unregister,
but it does not seem to close the race.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001180258.4054391-1-mhun512%40gmail.com
