Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32653BB687;
	Mon, 21 Sep 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020444; cv=none; b=PqtI3Uml8exHX2GLDs4lHH/IcKAnFyqKWNQpG7HIa2E+pY+/bky5vr+WOV5jq48autzEWDrKrJd2h14CwY8nMlqDOybpeBE6UsjXpyptaevxAfbKsMIGj47fce9lemDYW9yO0EAXfg1S9hzwQmT6L04vTu0EQ9YHZyo5iP6cLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020444; c=relaxed/simple;
	bh=q5I3uTP7PB2xW+/srh1dl5TmyLIeS2leATw2iix1tJ0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7quSntWPhgqlo+RqjbVUF5MrJiMIvwVP0sru6nC4i89sbHRZnSlxzy0Z7E0sDGLlR425Cr5D/7JZjD8bXjeGjr3p3inrUMlQWyl4di4VOjG0xThk9JFLSZl7QyJjL0O++EYL+ywW1a/Ggf39QZezEztTioh3oT2BBKHN1l/HGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrqXoQT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrqXoQT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F731F000FF;
	Mon, 21 Sep 2026 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020441;
	bh=VLQVaPaIz4Oo4ECfSXhlQRNeQ/Xty59vDImusrSG7WE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PrqXoQT9JUH+Mt5DFo6jb5wNRcLao0KYZs4UJcMxZxkt4Mb/I6kA/cLCJ0Z4eaKo8
	 QV1DK5ofiscj7r2qd6/WWmuWxwzuSd7lpodpOJczVDJ6aqpdJtKqlgnGJy42tXSNpW
	 aOG3E1Sfr9uRcYZOcuf8JXEw11WqTYa9fgjYb0U7tME2kreOUZTHEWqmUenZEvgMqt
	 +Elk1cUTempX8d359+DG1J5/V8f7URIutfbo/I6klwDxLP8ikFF0c57d5jDGviLwRl
	 sxMv/Vm8blNpy6V/NvKXVlDMGIrRoGbvRnisjrRLGXeLErGUU/sO0LvFrCWNZE6SfN
	 DvFbfWp9XtIbQ==
Subject: Re: [PATCH net] net: ti: icss-iep: Cancel compare work before
 releasing device resources
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, diogo.ivo@siemens.com, stable@vger.kernel.org,
 ae878000@gmail.com
Date: Mon, 21 Sep 2026 19:54:00 +0000
Message-ID: <179002044036.2160803.17680070427629412173@kernel.org>
In-Reply-To: <20260917193847.63849-1-mhun512@gmail.com>
References: <20260917193847.63849-1-mhun512@gmail.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the compare work is still not drained before the
  PTP clock it uses is torn down.

Pre-existing issues:
- [High] Deadlock: `icss_iep_pps_enable()`
  (drivers/net/ethernet/ti/icssg/icss_iep.c:579-618) calls…
- [High] Fix scope is narrower than the commit message implies: detach of
  the icss-iep device remains fundamentally unsafe.

--

net: ti: icss-iep: Cancel compare work before releasing device resources

The patch moves the iep_cap_cmp IRQ request in icss_iep_probe() to after the
platform data and regmap are set up, and switches the compare work from
INIT_WORK() to devm_work_autocancel() so that devres frees the IRQ, then
cancels the work, before the rest of the devm resources are released.

No Link: tags in the commit header.

> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index ec085897edf09..fa45538f1faa6 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c

[ ... ]

> @@ -895,9 +884,24 @@ static int icss_iep_probe(struct platform_device *pdev)
>  
>  	iep->ptp_info = icss_iep_ptp_info;
>  	mutex_init(&iep->ptp_clk_mutex);
> -	dev_set_drvdata(dev, iep);
>  	icss_iep_disable(iep);
>  
> +	if (irq > 0) {
> +		ret = devm_work_autocancel(dev, &iep->work, icss_iep_cap_cmp_work);
> +		if (ret)
> +			return ret;

[Severity: High]

Does this cover the teardown path that actually releases the resource the
worker touches?  devm_work_autocancel() only drains the work when devres
runs, i.e. at icss-iep driver detach.  The resource the worker dereferences,
iep->ptp_clock, is released much earlier by icss_iep_exit(), which the
consumer calls on interface stop while the icss-iep device stays bound:

drivers/net/ethernet/ti/icssg/icssg_prueth.c:prueth_emac_common_stop() {
	...
	icss_iep_exit(emac->iep);
	...
}

icss_iep_exit() drops the clock first and only then looks at the enable
state:

int icss_iep_exit(struct icss_iep *iep)
{
	if (iep->ptp_clock) {
		ptp_clock_unregister(iep->ptp_clock);
		iep->ptp_clock = NULL;
	}
	icss_iep_disable(iep);

	if (iep->pps_enabled)
		icss_iep_pps_enable(iep, false);
	else if (iep->perout_enabled)
		icss_iep_perout_enable(iep, NULL, false);

	return 0;
}

icss_iep_perout_enable() has no cancel_work_sync(), so on the perout branch
the work is never drained here at all.

Meanwhile icss_iep_cap_cmp_irq() keeps queueing while either flag is set:

	if (iep->pps_enabled || iep->perout_enabled)
		schedule_work(&iep->work);

and icss_iep_cap_cmp_work() uses the pointer unconditionally:

	pevent.pps_times.ts_real = ns_to_timespec64(ns);
	pevent.type = PTP_CLOCK_PPSUSR;
	pevent.index = 0;
	ptp_clock_event(iep->ptp_clock, &pevent);

For PTP_CLOCK_PPSUSR, ptp_clock_event() reads ptp->pps_source and hands it
to pps_event(), which dereferences it without a NULL check.

So with PEROUT enabled on /dev/ptpN and a CMP1 interrupt already having
queued the work, can an ifdown reach ptp_clock_event() with iep->ptp_clock
already NULL (or pointing at the just-unregistered clock)?  Would stopping
event production, synchronizing the IRQ and draining the work before
ptp_clock_unregister() in icss_iep_exit() be the placement that closes the
window described in the commit message?

> +
> +		ret = devm_request_irq(dev, irq, icss_iep_cap_cmp_irq,
> +				       IRQF_TRIGGER_HIGH, "iep_cap_cmp", iep);
> +		if (ret)
> +			dev_info(iep->dev, "cap_cmp irq request failed: %x\n",
> +				 ret);
> +		else
> +			iep->cap_cmp_irq = irq;
> +	}
> +
> +	dev_set_drvdata(dev, iep);
> +
>  	return 0;
>  }

[Severity: High]

This is a pre-existing issue and not introduced by this patch, but since the
patch adds a second cancel site for the same work, it may be worth looking
at the existing one in icss_iep_pps_enable().

The disable branch calls cancel_work_sync() with ptp_clk_mutex still held,
as the mutex is only dropped at the exit label:

static int icss_iep_pps_enable(struct icss_iep *iep, int on)
{
	...
	mutex_lock(&iep->ptp_clk_mutex);
	...
	} else {
		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
		if (iep->cap_cmp_irq)
			cancel_work_sync(&iep->work);
	}
	...
exit:
	mutex_unlock(&iep->ptp_clk_mutex);

and the work handler takes the same mutex as its first action:

static void icss_iep_cap_cmp_work(struct work_struct *work)
{
	...
	mutex_lock(&iep->ptp_clk_mutex);

If the work was already queued by an earlier CMP1 interrupt and is blocked
on mutex_lock(&iep->ptp_clk_mutex), can cancel_work_sync() then wait
forever for a worker that is waiting for the lock the canceller holds?

Disabling the compare hardware just before the cancel narrows the window,
but does it close it for a work item that is already queued or running?

[Severity: High]

This is also a pre-existing gap rather than something this patch introduces,
but the commit message frames the change as making driver detach safe, so
the scope may be worth clarifying for stable backporters.

icss_iep_driver has no .remove callback:

static struct platform_driver icss_iep_driver = {
	.driver = {
		.name = "icss-iep",
		.of_match_table = icss_iep_of_match,
	},
	.probe = icss_iep_probe,
};

and icss_iep_get_idx() hands the devm-allocated iep out to the consumer
while only taking a device reference:

	pdev = of_find_device_by_node(iep_np);
	...
	iep = platform_get_drvdata(pdev);
	...
	iep->client_np = np;

Nothing there pins the icss-iep driver, so on a sysfs unbind while prueth is
still bound, devres frees iep and unmaps iep->base while the PTP clock
registered from &iep->ptp_info in icss_iep_init() is still registered, and
while prueth still calls icss_iep_exit()/icss_iep_get_count_*() on that
pointer.  After unbind, does a PHC ioctl such as icss_iep_ptp_gettimeex()
still reach container_of(ptp_info) on freed memory and readl() on the
unmapped window?

Should the commit message say that the change drains the work item only, and
that unbind of the icss-iep device remains unsafe for other reasons?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917193847.63849-1-mhun512%40gmail.com
