Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558273A1E7E;
	Thu, 10 Sep 2026 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014970; cv=none; b=brH51bPi/UUGRD1ME7Oi8nNcJCSOXh9wavQBeuorh2ApJxQEW45A2DJfZWbP0Ov0CKZQX9KzNCCMrluxp7GUbl8t3McfcNUhwx/6fNWQ9Yi2YnPNMdCUgy40UutSoSPpt1Inqh7CzzOL09yupbeNyw3znD7UFRTIBUMnjEavKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014970; c=relaxed/simple;
	bh=gi6rJ3bt4biDASqoQHe2pYiRHSKK4K8EeZO8/yiPNAY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VyJIlZH/9/4NXwWR4XZZCvmkYRvv0B2q0CG1EUELHOzYc49INBwCfodPzQ4bAqA4JrndEqskZ4Ueq8fQC+gsrCGu38+gfqMrRM/4LjA1QDBx8MVak/QZjd/DHxq8UNVJOzHd1HSnt4u7jQGmwSOu1nJ6KMq7xKYvbq0mb7SnafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwMTANik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwMTANik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B47C1F00893;
	Thu, 10 Sep 2026 04:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014969;
	bh=IT7akshQlDjWtrlTNtOLNQbSUNvYlVBEcKrcp61V+fA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mwMTANikRNNuWL3+vGEFBfZY3vlj81qlIZTK7euilnJd1BF5AEvlKbRFcZJjc2TLm
	 Ts7JnVtcfFc56ckei2GtDAfYqwh1nIFldKTBJ53TO+rKmm5MSehrLwb4bRmRBxFRFp
	 ogXqfQWY8HMnGsAy/ic8DwIIa6mXUm+pRbJB5YwdgrI/Gl38sERYeENk5Rerpw97Rl
	 Jf4braX7W75YSlYJ5BAn36CJBdyMKhb+8ct22b4p7ER6muoF65oGtITBc8vePfXlos
	 L+pPlRK1QdpcmMtf9Xi99ENjJ63AKYjeKv7aLjvx2c8HZUyqsC76JEqF/FLyzqMGNZ
	 T/z2b9hIrhc8A==
Subject: Re: [PATCH net v3 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
From: netdev-bot+sashiko@kernel.org
To: me@cherr.cc
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 troy.kisky@boundarydevices.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
 horms@kernel.org, phucduc.bui@gmail.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 04:36:07 +0000
Message-ID: <178901496762.219967.11660527639623819235@kernel.org>
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
References: <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
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
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

- [High] Incomplete fix: only the PPS interrupt is converted to explicit
  request_irq()/free_irq().

Pre-existing issues:
- [High] Teardown ordering race in fec_ptp_stop()
  (drivers/net/ethernet/freescale/fec_ptp.c:856-874):…

--

net: fec: free the PPS interrupt before tearing down the PHC and netdev

This converts the PPS interrupt in fec_ptp_init() from devm_request_irq()
to request_irq(), records the irq number in fep->pps_irq, and releases it
with free_irq() in fec_ptp_stop() before ptp_clock_unregister().  The goal
is to make the handler go away before the PHC and the netdev are freed.

> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 7176803146f3..960b9f01c531 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -670,6 +670,7 @@ struct fec_enet_private {
>  
>  	/* pps  */
>  	int pps_channel;
> +	int pps_irq;
>  	unsigned int reload_period;
>  	int pps_enable;
>  	unsigned int next_counter;

> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 56801c2009d5..598cd8024123 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c

[ ... ]

> @@ -785,11 +786,12 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  	 * only the PTP_CLOCK_PPS clock events should stop
>  	 */
>  	if (irq >= 0) {
> -		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
> -				       0, pdev->name, ndev);
> +		ret = request_irq(irq, fec_pps_interrupt, 0, pdev->name, ndev);
>  		if (ret < 0)
>  			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
>  				 ret);
> +		else
> +			fep->pps_irq = irq;
>  	}

[Severity: High]
The commit message says the change closes the case where "a later interrupt
can dereference the freed netdev".  Does that hold once the main FEC
interrupts are considered?

fec_probe() still registers them with devres, using the same ndev cookie:

drivers/net/ethernet/freescale/fec_main.c:fec_probe() {
	...
		ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
				       0, pdev->name, ndev);
	...
		fep->irq[i] = irq;
}

devres_release_all() runs only after ->remove() returns, but
fec_drv_remove() already frees the netdev inside the callback:

drivers/net/ethernet/freescale/fec_main.c:fec_drv_remove() {
	...
	unregister_netdev(ndev);
	fec_ptp_stop(pdev);
	...
	fec_enet_deinit(ndev);
	free_netdev(ndev);
}

If the line is asserted in that window, fec_enet_interrupt() dereferences
the cookie immediately:

drivers/net/ethernet/freescale/fec_main.c:fec_enet_interrupt() {
	struct net_device *ndev = dev_id;
	struct fec_enet_private *fep = netdev_priv(ndev);
	...
}

The same ordering applies to the probe unwind, where failed_irq,
failed_mii_init and failed_register all fall through to free_netdev(ndev)
with the handlers still installed.

Should fep->irq[] be released with free_irq() in fec_drv_remove() (or the
netdev allocation switched to a devm-managed one) so the lifetime rule is
the same for every irq registered with ndev as dev_id?  As it stands the
driver ends up with two different conventions for identically-cookied
interrupts, and the failure mode described in the changelog is still
reachable through the main irq lines.

> @@ -861,6 +863,12 @@ void fec_ptp_stop(struct platform_device *pdev)
>  
>  	cancel_delayed_work_sync(&fep->time_keep);
>  	hrtimer_cancel(&fep->perout_timer);
> +
> +	if (fep->pps_irq >= 0) {
> +		free_irq(fep->pps_irq, ndev);
> +		fep->pps_irq = -1;
> +	}
> +
>  	if (fep->ptp_clock)
>  		ptp_clock_unregister(fep->ptp_clock);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the ordering in
fec_ptp_stop() means both hrtimer_cancel() and the new free_irq() run while
the PHC character device is still registered, since ptp_clock_unregister()
comes last.

Can an in-flight ioctl re-arm perout_timer after the cancel?
fec_ptp_enable() drops ptp_clk_mutex and tmreg_lock before arming:

drivers/net/ethernet/freescale/fec_ptp.c:fec_ptp_enable() {
	...
			if (delta > FEC_PTP_MAX_NSEC_COUNTER) {
				timeout = ns_to_ktime(delta - NSEC_PER_SEC);
				hrtimer_start(&fep->perout_timer, timeout, HRTIMER_MODE_REL);
	...
}

posix_clock_ioctl() holds only down_read(&clk->rwsem) across that callback,
and fec_ptp_stop() takes none of those locks.  ptp_clock_unregister() ->
posix_clock_unregister() then waits for the ioctl to finish, so the arm
completes and nothing cancels the timer again.

fec_drv_remove() afterwards calls free_netdev(ndev), which frees the
fec_enet_private embedding perout_timer, and the later expiry runs:

drivers/net/ethernet/freescale/fec_ptp.c:fec_ptp_pps_perout_handler() {
	struct fec_enet_private *fep = container_of(timer,
					struct fec_enet_private, perout_timer);

	fec_ptp_pps_perout(fep);
	...
}

The ptp_clk_on check in fec_ptp_enable() only rejects a fresh request; a
request already past that check is unaffected.  The window also exists on
the probe error path, fec_probe() failed_init -> fec_ptp_stop(), where
ptp_clk_on is true for the whole of probe.

Symmetrically, can a PTP_ENABLE_PPS ioctl reach fec_ptp_enable_pps(fep, 1)
after free_irq() and re-enable the hardware compare interrupt with no
handler installed?  fec_ptp_enable_pps() has no ptp_clk_on gate.

Would it be better to unregister (or defunct) the PHC first, or to re-cancel
the hrtimer after ptp_clock_unregister() returns?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16%40cherr.cc
