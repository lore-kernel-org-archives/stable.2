Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B195314A86;
	Wed,  9 Sep 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964770; cv=none; b=n2MwFPuItKW4Uzz160bTAUAJXb8XYZXjzCGFQ+Scai6sxMda75EsaBdHDQ+/yAJiq2MFxhAxvz7HoncidqC+AiZBeKtr5gkcQJjwoM9DRjEmMnkPL8RxUG51feUA6bIi1PNiaqaildU8OLBJUE0b3X/hKAQcu66a0x4osdQ9zTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964770; c=relaxed/simple;
	bh=1rzzRsFBAiuC+bYDPvS/SgKKe5unW7JKdmc8jw0Cpq8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZ/LD33khtO0Nt0hWwOlL/br0uXqTa6fVkne88/eB7cxt9fpnymCUrVRLq2wr7dx4yYHNzE/5v7MtULXQY0YqOrl9wUKK0x9SRzL2dJFfVnOifYTq88lQA4UuhnIN5yCdy6r2mDYPvu24a1+8y7v2Jxiu8f4u56Bqa25AMfTuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqcX/Z5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqcX/Z5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483791F00A3A;
	Wed,  9 Sep 2026 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964768;
	bh=+UIf8Zu80TSsKBxyqZn2MTJLVYa1HNYtb0XS0mqqrDM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cqcX/Z5F0wiZ2qcJe0b0D/ylWsfnaBX5mIhlSu3R0jYpAglQ1ZoVBrbT7cY7UsgB3
	 E2ibg1SP7n7ITRMoaKpivUwxaDRdVGqRjZXJ0ZeWx8jQleOw9Ouv1jppWOJ8016nU4
	 on1srxWDjSEy2oLpclOJKlhmiwRH31IzlDj8/ainsotrMKgCL8YVbyrY8YFYI9yggg
	 lkhRpa9FuHs+3V19TIClaoEJS/LWDTTA6yQc8kykxlI+PKNmb9+g0bL+dY4m3RBFct
	 q+tLQk7Cf3XKGyXlcMIG68vMXpwp10dyvrc7akCdy1ZpgsOhAOc0+KMhh06h4X6uoH
	 yDFeEvmWXd1Xg==
Subject: Re: [PATCH net v2 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
From: netdev-bot+sashiko@kernel.org
To: me@cherr.cc
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 troy.kisky@boundarydevices.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
 horms@kernel.org, phucduc.bui@gmail.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 09 Sep 2026 14:39:26 +0000
Message-ID: <178896476679.219967.6901697617013894396@kernel.org>
In-Reply-To: <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
References: <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0 (1)

- [Medium] fec_ptp_stop() now removes the PPS interrupt handler
  (devm_free_irq(), drivers/net/ethernet/freescale/fec_ptp.c:870)…

Pre-existing issues:
- [High] Use-after-free of fec_enet_private via the perout hrtimer during
  driver removal.
- [Medium] fec_pps_interrupt()
  (drivers/net/ethernet/freescale/fec_ptp.c:696-728) performs a read-…
- [Low] Kernel-doc above fec_ptp_init()
  (drivers/net/ethernet/freescale/fec_ptp.c:735) states "If ptp support…

--

net: fec: free the PPS interrupt before tearing down the PHC and netdev

This records the PPS interrupt number in struct fec_enet_private when
devm_request_irq() succeeds, and releases it with devm_free_irq() in
fec_ptp_stop() before ptp_clock_unregister(), so the handler is gone
before the PHC and the netdev go away.

A few questions about the teardown ordering and about state that is not
covered by the new devm_free_irq() call.

> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 56801c2009d59..567ea2a461173 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -778,6 +778,7 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  	hrtimer_setup(&fep->perout_timer, fec_ptp_pps_perout_handler, CLOCK_REALTIME,
>  		      HRTIMER_MODE_REL);
>  
> +	fep->pps_irq = -1;

[Severity: Low]
This is a pre-existing documentation issue and not something this patch
introduces, but the kernel-doc directly above fec_ptp_init() in
fec_ptp.c claims an early-exit path that the body does not have:

 * This function performs the required steps for enabling ptp
 * support. If ptp support has already been loaded it simply calls the
 * cyclecounter init routine and exits.

The body has no such test: every call re-populates fep->ptp_caps,
re-initialises tmreg_lock, the time_keep delayed work and perout_timer,
and now also resets fep->pps_irq before requesting the pps irq again.

Since fec_ptp_init() is only called once per probe from fec_probe(), this
has no runtime effect today. If a repeat initialisation ever became
possible though, would the unconditional fep->pps_irq = -1 erase the
recorded irq while the old non-shared handler is still installed, so that
the second devm_request_irq() fails and fec_ptp_stop() then skips
devm_free_irq() entirely?

Would it make sense to correct the comment while touching this function?

>  	irq = platform_get_irq_byname_optional(pdev, "pps");
>  	if (irq < 0)
>  		irq = platform_get_irq_optional(pdev, irq_idx);
> @@ -787,9 +788,12 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  	if (irq >= 0) {
>  		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
>  				       0, pdev->name, ndev);
> -		if (ret < 0)
> +		if (ret < 0) {
>  			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
>  				 ret);
> +		} else {
> +			fep->pps_irq = irq;
> +		}
>  	}
>  
> @@ -861,6 +865,12 @@ void fec_ptp_stop(struct platform_device *pdev)
>  
>  	cancel_delayed_work_sync(&fep->time_keep);
>  	hrtimer_cancel(&fep->perout_timer);

[Severity: High]
This is a pre-existing race and not introduced here (the patch only
inserts devm_free_irq() between this cancel and the unregister), but since
the teardown order is what the patch is about: can the perout hrtimer be
re-armed after this hrtimer_cancel() and outlive free_netdev()?

fec_ptp_enable() drops both locks before arming the timer:

drivers/net/ethernet/freescale/fec_ptp.c:fec_ptp_enable() {
	...
unlock:
			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
			mutex_unlock(&fep->ptp_clk_mutex);
	...
			if (delta > FEC_PTP_MAX_NSEC_COUNTER) {
				timeout = ns_to_ktime(delta - NSEC_PER_SEC);
				hrtimer_start(&fep->perout_timer, timeout, HRTIMER_MODE_REL);
	...
}

So for a PTP_PEROUT_REQUEST whose start time is more than
FEC_PTP_MAX_NSEC_COUNTER away, a concurrent unbind can run
fec_drv_remove() -> unregister_netdev() -> fec_ptp_stop() and execute
hrtimer_cancel() while the timer is not yet armed, and the ioctl arms it
afterwards.

Does anything cancel it again? ptp_clock_unregister() waits for in-flight
posix-clock operations and then calls ptp_disable_all_events(), which only
touches EXTTS pins and PPS. This driver sets ptp_caps.n_pins = 0, and the
PPS-off request returns -EBUSY from fec_ptp_enable_pps() while
fep->perout_enable is set, so PEROUT is never disabled.

fec_drv_remove() then reaches:

drivers/net/ethernet/freescale/fec_main.c:fec_drv_remove() {
	...
	fec_enet_deinit(ndev);
	free_netdev(ndev);
}

which frees the netdev private area containing both fep and the still
queued perout_timer. When it expires, fec_ptp_pps_perout_handler()
recovers the freed fec_enet_private with container_of() and
fec_ptp_pps_perout() writes fep->hwp registers that devres already
unmapped. Should fec_ptp_stop() do its hrtimer cancellation after the PHC
has been made inaccessible, rather than before?

> +
> +	if (fep->pps_irq >= 0) {
> +		devm_free_irq(&pdev->dev, fep->pps_irq, ndev);
> +		fep->pps_irq = -1;
> +	}

[Severity: Medium]
This is a pre-existing problem, not one added by the patch, but it affects
where the new devm_free_irq() should go: fec_pps_interrupt() does a
read-modify-write of the compare channel without taking fep->tmreg_lock:

drivers/net/ethernet/freescale/fec_ptp.c:fec_pps_interrupt() {
	val = readl(fep->hwp + FEC_TCSR(channel));
	if (val & FEC_T_TF_MASK) {
		writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
		do {
			writel(val, fep->hwp + FEC_TCSR(channel));
		} while (readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);
	...
}

Every other accessor (fec_ptp_enable_pps(), fec_ptp_pps_perout(),
fec_ptp_pps_disable()) holds spin_lock_irqsave(&fep->tmreg_lock), and the
irqsave variant suggests the handler was meant to take it too.

Because val is sampled before the disabling writel(0, FEC_TCSR(ch)) in
fec_ptp_enable_pps(fep, 0), can a handler running on another CPU write
TIE and TMODE back into TCSR after that disable, re-arming the channel and
clobbering fep->next_counter?

In fec_ptp_stop() the new devm_free_irq() sits after
fec_ptp_enable_pps(fep, 0), so the handler is only quiesced once the
state has already been torn down. Would freeing the irq first close that
window?

[Severity: Medium]
Removing the handler here does not seem to be paired with quiescing the
1588 compare channel in hardware for the PEROUT case. The channel is only
disabled when fep->pps_enable is set, via
fec_ptp_stop() -> fec_ptp_enable_pps(fep, 0), which writes 0 to FEC_TCSR.

When the channel was armed through PTP_CLK_REQ_PEROUT instead,
fec_ptp_pps_perout() leaves it enabled:

drivers/net/ethernet/freescale/fec_ptp.c:fec_ptp_pps_perout() {
	...
	temp_val |= (1 << FEC_T_TF_OFFSET | 1 << FEC_T_TIE_OFFSET);
	temp_val &= ~(FEC_T_TMODE_MASK);
	temp_val |= (FEC_TMODE_TOGGLE << FEC_T_TMODE_OFFSET);
	writel(temp_val, fep->hwp + FEC_TCSR(fep->pps_channel));
	...
}

and fec_ptp_stop() only cancels the software hrtimer; it never calls the
existing helper that clears the register:

drivers/net/ethernet/freescale/fec_ptp.c:fec_ptp_pps_disable() {
	hrtimer_cancel(&fep->perout_timer);
	spin_lock_irqsave(&fep->tmreg_lock, flags);
	fep->perout_enable = false;
	writel(0, fep->hwp + FEC_TCSR(channel));
	...
}

The later ptp_clock_unregister() -> ptp_disable_all_events() PPS-off
request cannot help either, since fec_ptp_enable_pps() returns -EBUSY
immediately while fep->perout_enable is true, without touching TCSR.

The close path does not reliably clear it either. On SoCs with
FEC_QUIRK_HAS_MULTI_QUEUES, or FEC_QUIRK_NO_HARD_RESET with the link up,
fec_ctrl_reset() only disables the MAC:

drivers/net/ethernet/freescale/fec_main.c:fec_ctrl_reset() {
	...
		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
			writel(0, fep->hwp + FEC_ECNTRL);
	...
}

so TCSR and TCCR survive fec_stop().

fec_pps_interrupt() is the only code that acknowledges the write-1-to-clear
TF flag and reloads TCCR from fep->next_counter. After this devm_free_irq(),
does the channel stay enabled with TF latched and unacknowledged, and the
output pin still toggling?

And on a later re-bind, would the stale armed channel be serviced as soon
as fec_ptp_init() re-installs the handler with devm_request_irq() -- which
happens before ptp_clock_register() and before anything resets TCSR, as
fec_ptp_start_cyclecounter() only writes ATIME_INC, ATIME_EVT_PERIOD and
ATIME_CTRL -- reprogramming TCCR from a freshly zeroed fep->next_counter
on a channel the new instance considers idle?

Would it be better to clear FEC_TCSR for fep->pps_channel (acknowledging
TF) for both the pps and perout cases, for example by calling
fec_ptp_pps_disable(), and only then drop the handler?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade%40cherr.cc
