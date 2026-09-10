Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20F37F72D;
	Thu, 10 Sep 2026 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014969; cv=none; b=SDK/TAyqapA7gEqHjTheYomBjlqKFrftqTZWSeR27HHzokvjXy0u37fUwfu4fs6iGD2nJhIx2VYCWX4/9tAq0VEokCgCwGvN0HQKZPdQhbPmCm4rx4QPUQYM3Eq5aSv8+op62mhX3/84UWQt6KJn4qN3YU3gZGmVSmdVX4INpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014969; c=relaxed/simple;
	bh=YyuN0m2jYrmVFdLTTvc7Lhq/rwtAShj49SccpqbNPKk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jskg+yUWE9x6Z6KKOzDMMtHDD1V5uGWPpJEBG9oGD8S5h9ziFbl4ONG+YdqTRny42MAxxcVdFb0//GiymVvevZZJGpaX7tZ/MgJ56X516E2DeG7W1iGVQByumvQHI+GTjCS2mN7OGr+XUd0zynuBDWAKzNPMM3mq6Z4ls8Ni0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wre+O8Bk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wre+O8Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853F61F000FF;
	Thu, 10 Sep 2026 04:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014967;
	bh=Z7KOKMDLvgMoTle1J1esWv52SIsOGWWBoe2sJ4cqNVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wre+O8BkI/aW5kkRmEk8fTndv/JM5OofmyNibfBPt3LHRJY97y/sAth66e27JQiav
	 gdLcQRDDsaCP1gSIfYuY2QqQ/Xn30W2Dc9XLcPuTC4QBFRQ4V/ip/RWp3NahHGCEAS
	 Nna+DHoXOL9DF8Bcydt+kJ83WjSwakRCczRlNTMNbuqGnExmeg+9+bm9DH/WdKKf92
	 C+o9SzSLvGzpG/LWb6cM3p6a/9v8JlJefW66IYl6YsuFR7kIMP19v8VNVKFnnbaO1+
	 pog7nILNBbeBgRiV1GcYPNefQ/Ip4b5CxOumAEuzxMUdSQGRkwK+ohLp8B67vbl9E3
	 9LP4HGDyQDijQ==
Subject: Re: [PATCH net v3 1/2] net: fec: stop the PTP clock after the netdev
 is unregistered
From: netdev-bot+sashiko@kernel.org
To: me@cherr.cc
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 troy.kisky@boundarydevices.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
 horms@kernel.org, phucduc.bui@gmail.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 04:36:06 +0000
Message-ID: <178901496609.219967.4341484781884273489@kernel.org>
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-1-bead12c29a16@cherr.cc>
References: <20260909-fec-ptp-pps-event-uaf-v3-1-bead12c29a16@cherr.cc>
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
issue(s) to consider:

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

- [Medium] Moving fec_ptp_stop() after unregister_netdev() in
  fec_drv_remove() (drivers/net/ethernet/freescale/fec_main.c:5503-5505)…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  fec_drv_remove() still cancels tx_timeout_work before the netdev is…
- [High] This problem wasn't introduced by this patch, but fec_ptp_stop()
  still cancels the perout hrtimer before unregistering the PHC, so a…

--

net: fec: stop the PTP clock after the netdev is unregistered

This moves the fec_ptp_stop() call in fec_drv_remove() to after
unregister_netdev() so that ethtool callbacks are drained before the PTP
clock is unregistered.  The probe error path is left unchanged.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 794ec427b0ee..a29c8ddbbf34 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -5500,9 +5500,9 @@ fec_drv_remove(struct platform_device *pdev)
>  			ERR_PTR(ret));
>  
>  	cancel_work_sync(&fep->tx_timeout_work);

[Severity: High]
This isn't a bug introduced by this patch, but can the tx timeout work be
re-queued after this cancel_work_sync() returns?

At this point the netdev is still registered and running, so the qdisc TX
watchdog can still call ndo_tx_timeout:

fec_main.c:fec_timeout() {
	...
	schedule_work(&fep->tx_timeout_work);
}

Nothing disarms the watchdog until unregister_netdev() -> dev_close() ->
dev_deactivate() runs, and there is no second cancel_work_sync() later in
fec_drv_remove().

fec_enet_timeout_work() also takes rtnl_lock(), which unregister_netdev()
holds, so it can be pushed past unregistration and still be pending when
fec_drv_remove() reaches:

fec_main.c:fec_drv_remove() {
	...
	fec_enet_deinit(ndev);
	free_netdev(ndev);
}

Since the work_struct lives inside netdev_priv memory and the worker
dereferences fep->netdev, does this become a use-after-free of the netdev
and the work_struct?

Would moving cancel_work_sync() to after unregister_netdev() (or adding a
second cancel before free_netdev()) address that?

> +	unregister_netdev(ndev);
>  	if (fep->bufdesc_ex)
>  		fec_ptp_stop(pdev);

[Severity: Medium]
With this ordering, does fec_ptp_stop() now touch the 1588 registers while
clk_ptp is gated?

unregister_netdev() -> dev_close() -> fec_enet_close() runs first, and for
bufdesc_ex it goes through fec_stop():

fec_main.c:fec_stop() {
	...
		fec_ptp_start_cyclecounter(ndev);
		fec_ptp_restore_state(fep);
}

fec_ptp_restore_state() re-arms PPS via fec_ptp_enable_pps(fep, 1) when PPS
was enabled, so fep->pps_enable is 1 on return.  fec_enet_close() then
does:

fec_main.c:fec_enet_close() {
	...
	fec_enet_clk_enable(ndev, false);
}

which does clk_disable_unprepare(fep->clk_ptp) and clears fep->ptp_clk_on.

Control then returns to fec_drv_remove() and fec_ptp_stop() runs:

fec_ptp.c:fec_ptp_stop() {
	if (fep->pps_enable)
		fec_ptp_enable_pps(fep, 0);

	cancel_delayed_work_sync(&fep->time_keep);
	hrtimer_cancel(&fep->perout_timer);
	...
}

fec_ptp_enable_pps() reaches the disable branch with no ptp_clk_on or
ptp_clk_mutex guard:

fec_ptp.c:fec_ptp_enable_pps() {
	...
	} else {
		writel(0, fep->hwp + FEC_TCSR(fep->pps_channel));
	}
}

Every other 1588 register path in the driver (fec_ptp_gettime,
fec_ptp_settime, the PEROUT branch of fec_ptp_enable, fec_time_keep) bails
out when !fep->ptp_clk_on.  If this write is not latched with the clock
gated, does the output-compare channel and its TIE interrupt enable stay
armed while software records pps_enable = 0?

The same reorder also moves hrtimer_cancel(&fep->perout_timer) past the
clock gating, so can an already-armed perout hrtimer run
fec_ptp_pps_perout() from hardirq context and touch FEC_ATIME_CTRL /
FEC_TCCR / FEC_TCSR in the gated clock domain?

fec_ptp.c:fec_ptp_pps_perout() {
	...
	temp_val = readl(fep->hwp + FEC_ATIME_CTRL);
	temp_val |= FEC_T_CTRL_PINPER;
	writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
	...
}

Would quiescing PPS/PEROUT and cancelling the hrtimer while clk_ptp is
still on, and deferring only ptp_clock_unregister() past
unregister_netdev(), keep the intended ethtool lifetime fix without this
window?

[Severity: High]
This is a pre-existing issue, but fec_ptp_stop() cancels the perout hrtimer
before unregistering the PHC, so can a concurrent PTP ioctl re-arm it?

fec_ptp.c:fec_ptp_stop() {
	...
	cancel_delayed_work_sync(&fep->time_keep);
	hrtimer_cancel(&fep->perout_timer);
	...
	if (fep->ptp_clock)
		ptp_clock_unregister(fep->ptp_clock);
}

In the PTP_CLK_REQ_PEROUT branch of fec_ptp_enable(), fep->ptp_clk_on is
validated under ptp_clk_mutex, but both ptp_clk_mutex and tmreg_lock are
dropped before the timer is armed:

fec_ptp.c:fec_ptp_enable() {
	...
			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
			mutex_unlock(&fep->ptp_clk_mutex);
	...
			if (delta > FEC_PTP_MAX_NSEC_COUNTER) {
				timeout = ns_to_ktime(delta - NSEC_PER_SEC);
				hrtimer_start(&fep->perout_timer, timeout, HRTIMER_MODE_REL);
	...
}

A thread preempted between the check and hrtimer_start() can arm the timer
at an arbitrary later point.  ptp_clock_unregister() only waits for the
ioctl to finish, which is after hrtimer_cancel() has already run.
fec_drv_remove() then proceeds to fec_enet_deinit(ndev) and
free_netdev(ndev), freeing fep together with the embedded hrtimer, so does
fec_ptp_pps_perout_handler() end up running against freed memory?

This patch narrows the window (ptp_clk_on is false once the netdev is
closed) but does not close it.  Would unregistering the PHC first, then
cancelling the hrtimer and the delayed work, be the right order here?

> -	unregister_netdev(ndev);
>  	fec_enet_mii_remove(fep);
>  	if (fep->reg_phy)
>  		regulator_disable(fep->reg_phy);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16%40cherr.cc
