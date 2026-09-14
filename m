Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DF35E93B;
	Mon, 14 Sep 2026 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360829; cv=none; b=lEPvmTheFvYzYea8qbtnCnLKVklCfZSMKp5lSPxbdSGoBHHkjDYDEcyMo/lHS66SMQEuKzdX03P8bJLMoZk334Y26Ukuj5/AwWe5IxXW/he/rUhJsFdgG1jmgusk4TeZYMBf1Ik73qBIwNwX6CWClflG6pEDPNluwSsp57s7gN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360829; c=relaxed/simple;
	bh=Y82kSJ098fXQWOwBdDrAUJmCV8kyPqaLqBXI9WjFeTM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cIIYpwNEGfjdDMWaQYnaJnu65xlUinmeIjWgepvFOp0e1zKIq/LxL9wIHunEaSPIlLYAip8Pk6d96/Gk/tpCDHuUP9NbOHuZWzKhditcbzbyJWaJ1W7YxYC8ER16yRpVekYMtK71p/w0ivPIUEnCsGRVDQ2fud3ZtEKopJJg9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek5y+Z3k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek5y+Z3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D294E1F000FF;
	Mon, 14 Sep 2026 04:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789360827;
	bh=jG0B12XgCRxXgcOPPpKSxX/lA7abyk4jEZxMska5KdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ek5y+Z3kbOMZuyIDwDAN3nflZzHVXsiy/iLLhqjSDndXW7xUXIFHkPF8qxC9lm2oM
	 ltrWEx2lc7o8C1l60tZa/Ok6nQIAWjPd7JsyUgdmO7pP8IxscwHkgGly4n9REGeCxW
	 uzPgscujhJBa+v4UX+bmAonYah7JvcoUFP1Jd6mUf1SKV88Xq9CPSfWqXv+cBqIYzR
	 r6ktI/rOGIbvMk6q/nyAxeV0+fzC/TIOXuAG6Az1WG1vK/2ZIAqboRG3ycHntBH0Hh
	 NXdw88xcmT5CF3iv7fyyhOgej2Zm4yEVR7ZQnku8r/pbs7SsriOC6YyBz0l+ZApduT
	 tnZiC9iZUc16w==
Subject:
 Re: [PATCH net] dm9000: free the wake IRQ before releasing board resources
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ben-linux@fluff.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com
Date: Mon, 14 Sep 2026 04:40:26 +0000
Message-ID: <178936082640.22033.13106626657282829765@kernel.org>
In-Reply-To: <20260913035557.19347-1-mhun512@gmail.com>
References: <20260913035557.19347-1-mhun512@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

- [High] The shared wake IRQ handler is live before its MMIO mappings
  exist, and the patch's new free_irq() makes that window…
- [Medium] dm9000_release_board() now frees the wake IRQ action
  (drivers/net/ethernet/davicom/dm9000.c:806-807) but nothing ever…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but dm9000_probe()
  ignores register_netdev() failure: at…
- [Medium] This problem wasn't introduced by this patch, but
  dm9000_probe() treats an -EPROBE_DEFER result for the optional wake…

--

dm9000: free the wake IRQ before releasing board resources

The patch adds a wake_irq_requested bit to struct board_info so that a
successful request_irq() for the optional wake interrupt is tracked
separately from wake_supported, and frees that IRQ from
dm9000_release_board() before the register windows are unmapped.  This
covers both the probe unwind path and driver removal.

> diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
> index b87eaf0c250ce..c8ff07fe31a5b 100644
> --- a/drivers/net/ethernet/davicom/dm9000.c
> +++ b/drivers/net/ethernet/davicom/dm9000.c

[ ... ]

> @@ -802,6 +803,9 @@ dm9000_poll_work(struct work_struct *w)
>  static void
>  dm9000_release_board(struct platform_device *pdev, struct board_info *db)
>  {
> +	if (db->wake_irq_requested)
> +		free_irq(db->irq_wake, db->ndev);
> +
>  	/* unmap our resources */
>  
>  	iounmap(db->io_addr);

[Severity: High]
Can this free_irq() call dm9000_wol_interrupt() while db->io_addr and
db->io_data are still NULL?

In dm9000_probe() the wake IRQ is requested well before the register
windows are mapped:

	ret = request_irq(db->irq_wake, dm9000_wol_interrupt,
			  IRQF_SHARED, dev_name(db->dev), ndev);
	...
	db->addr_req = request_mem_region(...);
	db->io_addr = ioremap(db->addr_res->start, iosize);
	...
	db->io_data = ioremap(db->data_res->start, iosize);

db comes from netdev_priv() of a freshly alloc_etherdev()'d device, so
both __iomem pointers are NULL at request time, and the handler starts
with MMIO access:

dm9000_wol_interrupt() {
	nsr = ior(db, DM9000_NSR);
	wcr = ior(db, DM9000_WCR);

ior() {
	writeb(reg, db->io_addr);
	return readb(db->io_data);
}

With CONFIG_DEBUG_SHIRQ, __free_irq() calls the handler once after
unregistering a shared action:

kernel/irq/manage.c:__free_irq() {
	if (action->flags & IRQF_SHARED) {
		local_irq_save(flags);
		action->handler(irq, dev_id);
		local_irq_restore(flags);
	}

So every probe failure that reaches the out: label before or between the
two ioremap() calls (addr_req == NULL, io_addr == NULL, data_req == NULL,
io_data == NULL) now runs dm9000_wol_interrupt() -> ior() ->
writeb(reg, NULL) from the new cleanup.

Independently of the debug config, since the action is IRQF_SHARED, can
the line be asserted by a co-owner (or by a DM9000 whose NSR_WAKEST is
already latched across a warm reboot) during the sleeping
request_mem_region()/ioremap() calls, with the same result?  The same
window also lets the handler's index/data two-cycle register protocol
interleave with the unlocked ior()/iow() sequences in dm9000_reset(), the
VID/PID retry loop and the EEPROM reads, since dm9000_probe() never takes
db->lock.

Would it be preferable to move the request_irq() and the
irq_set_irq_wake() capability test to after the register windows are
mapped, dm9000_set_io() has run and the chip has been reset?  That
ordering also makes the unwind natural and removes the need for the new
wake_irq_requested bit in the shared cleanup helper.

[Severity: Medium]
Does this teardown leak the interrupt wake reference taken by
dm9000_set_wol()?

When userspace enables WAKE_MAGIC, the reference is taken here:

dm9000_set_wol() {
	if (dm->wake_state != opts) {
		/* change in wol state, update IRQ state */

		if (!dm->wake_state)
			irq_set_irq_wake(dm->irq_wake, 1);
		else if (dm->wake_state && !opts)
			irq_set_irq_wake(dm->irq_wake, 0);
	}

That is the only place the reference is dropped, and only on a
wake_state 1 -> 0 transition driven by ethtool.  dm9000_stop(),
dm9000_shutdown(), dm9000_release_board() and dm9000_drv_remove() do not
clear db->wake_state and do not call irq_set_irq_wake(db->irq_wake, 0).

desc->wake_depth and IRQD_WAKEUP_STATE are maintained only by
irq_set_irq_wake(), and __free_irq() does not touch them, so after
	ethtool -s ethX wol g
	echo ... > unbind   (or rmmod)
the descriptor keeps wake_depth > 0 and IRQD_WAKEUP_STATE set with no
handler attached.  Because the line was requested IRQF_SHARED, a co-owner
that later does its own enable/disable pair only brings wake_depth back
to 1, so set_irq_wake_real(irq, 0) is never reached and the co-owner can
no longer turn the wake source off.

Should the new cleanup drop that reference, for example
irq_set_irq_wake(db->irq_wake, 0) when db->wake_state is set, before the
free_irq()?

> @@ -1519,6 +1523,7 @@ dm9000_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(db->dev, "cannot get wakeup irq (%d)\n", ret);
>  		} else {
> +			db->wake_irq_requested = 1;
>  
>  			/* test to see if irq is really wakeup capable */
>  			ret = irq_set_irq_wake(db->irq_wake, 1);

[Severity: High]
This isn't a bug introduced by this patch, but since the patch extends the
out: unwind in dm9000_probe(), is the registration failure path reaching it
at all?  Near the end of dm9000_probe():

	platform_set_drvdata(pdev, ndev);
	ret = register_netdev(ndev);

	if (ret == 0) {
		...
	}
	return 0;

The return value is only used to gate the success printk and then 0 is
returned unconditionally, so a failed register_netdev() reports probe
success.  The driver core records a successful bind, the out: unwind that
now calls free_irq()/dm9000_release_board() is never taken, and the board
keeps its mapped registers plus the newly tracked wake IRQ attached to an
unregistered net_device.

Removal then calls unregister_netdev() on that device:

net/core/dev.c:unregister_netdevice_many_notify() {
		if (dev->reg_state == NETREG_UNINITIALIZED) {
			...
			WARN_ON(1);
			list_del(&dev->unreg_list);
			continue;
		}
		dev->dismantle = true;
		BUG_ON(dev->reg_state != NETREG_REGISTERED);

In the common case register_netdevice() has rolled back to
NETREG_UNINITIALIZED and this is the WARN_ON(1).  If registration instead
failed via the NETDEV_REGISTER notifier path, which internally
unregisters the device and clears needs_free_netdev, reg_state is no
longer NETREG_UNINITIALIZED and the later unregister_netdev() reaches the
BUG_ON(dev->reg_state != NETREG_REGISTERED).

Would "if (ret) goto out;" be the intended control flow here?

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but a few
lines above this hunk dm9000_probe() folds -EPROBE_DEFER into "the
optional interrupt is absent":

	db->irq_wake = platform_get_irq_optional(pdev, 1);
	if (db->irq_wake >= 0) {

platform_get_irq_optional() forwards to platform_get_irq_affinity(),
which explicitly propagates the deferral:

drivers/base/platform.c:platform_get_irq_affinity() {
		ret = of_irq_get(to_of_node(fwnode), num);
		if (ret > 0 || ret == -EPROBE_DEFER)
			goto out;

So when the second interrupt is described in DT but its irqchip has not
probed yet, probe silently continues and returns success, wake_supported
stays 0, and ethtool set_wol returns -EOPNOTSUPP for the lifetime of the
binding with no retry.  Should -EPROBE_DEFER be propagated out of
dm9000_probe() instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913035557.19347-1-mhun512%40gmail.com
