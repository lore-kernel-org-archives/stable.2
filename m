Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880330D3E8;
	Thu, 10 Sep 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023288; cv=none; b=sVHj9N8sVXjKzUoJlUsL/NKrxJ2aLX+41vK+nw0a2dpZgCXDnxp1FMLVjpx+t8L9lmltFB3UDwu/GsXFuYc7tUl2xs56c6McjnwGrOVcAQk8q5YC/r4vIDVTwn19WPzrT8I32tcHgKyz6Q/tMEgNiWLcNuOvpSa5Sc3YYyMIqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023288; c=relaxed/simple;
	bh=n9odGZdEAfMv1EitzufznCQRLwi8wplX0Uov18O85ls=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tsNkBlnVKIh1FS2s2PHarlLAKf46/uCfKnGhalc+zwyY7eUu0Wi1elHsNaPB+9aJJvjalQ9T1lTZuhqexFaUphMmreo+9ojanAWfdViitqMqTbrIbadT7NCGEgzUtxb/pPLHJPMRY5rxmylPLqKZr53TNjGpsmBLWUfE+nArwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncr1GlNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncr1GlNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63581F000FF;
	Thu, 10 Sep 2026 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789023286;
	bh=wi5rBy9HhdLl2dwL3tu5ohZQ+FFI73SL/VWlC+ZFZ3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ncr1GlNbddpXLnfe78bkT/V5vz9kYB0MyFUCtUyBidyDHnqDQtX2+jpl5lC4mjaBn
	 Y/4QIpAIjQumHo9uOH30Uls0uJBRjnVkOV1JZQQyoXR936Ff1HvZWzC5N5W/ocP0Ut
	 xOlMnY4mbcFFIwbeO7cAzcDiRw960Lo6stiHJ8qoE6E2zRn2F8bJcIeKFsVNgAsHfY
	 v/MkyhNLclCYyiyeBemg3w+bTAPXGAcVm9SBbmgkZPmfhYxZcberB64cLuMsmczm9y
	 ipI2VyGUCL6pPxfgvJiRKdfzKtZvZd+0G+Mz08eknO2XdJGGab73UWKpXdiolR42Hm
	 wWl6a8lHwGg7w==
Subject: Re: [PATCH v2] net: tulip: use mod_timer() in t21142_lnk_change()
From: netdev-bot+sashiko@kernel.org
To: linmag7@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 06:54:45 +0000
Message-ID: <178902328547.219967.7621030268252739442@kernel.org>
In-Reply-To: <20260905225454.439466-1-linmag7@gmail.com>
References: <20260905225454.439466-1-linmag7@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

- [High] Incomplete fix: the illegal hardirq timer_delete_sync() on the
  non-TIMER_IRQSAFE media timer is still reachable from the exact call…
- [Low] Stale synchronization comment left behind by the conversion.

Pre-existing issues:
- [High] t21142_lnk_change() re-arms tp->timer from hardirq
  (drivers/net/ethernet/dec/tulip/21142.c:219 and :227) with no…

--

net: tulip: use mod_timer() in t21142_lnk_change()

This replaces the timer_delete_sync() + expires + add_timer() sequences in
t21142_lnk_change() with a single mod_timer() call, since the function runs
in hardirq context and tp->timer is not TIMER_IRQSAFE.  The mod_timer() is
placed before t21142_start_nway() so a pending timer cannot fire while the
NWay state is being reprogrammed.  The comment in tulip_interrupt() is
updated to point at pnic2_lnk_change() instead.

> diff --git a/drivers/net/ethernet/dec/tulip/21142.c b/drivers/net/ethernet/dec/tulip/21142.c
> index 76767dec216da..950abf4a8c14a 100644
> --- a/drivers/net/ethernet/dec/tulip/21142.c
> +++ b/drivers/net/ethernet/dec/tulip/21142.c
> @@ -216,20 +216,16 @@ void t21142_lnk_change(struct net_device *dev, int csr5)
>  		    (csr12 & 2) == 2) ||
>  		   (tp->nway && (csr5 & (TPLnkFail)))) {
>  		/* Link blew? Maybe restart NWay. */
> -		timer_delete_sync(&tp->timer);
> +		mod_timer(&tp->timer, RUN_AT(3 * HZ));
>  		t21142_start_nway(dev);
> -		tp->timer.expires = RUN_AT(3*HZ);
> -		add_timer(&tp->timer);

[Severity: High]
This isn't a bug introduced by this patch, but can this hardirq re-arm make
the media timer pending again after teardown already cancelled it?

tulip_down() in tulip_core.c does the sync-cancel while chip interrupts and
the registered IRQ are still live:

	cancel_work_sync(&tp->media_work);
	napi_disable(&tp->napi);
	timer_delete_sync(&tp->timer);
	spin_lock_irqsave(&tp->lock, flags);
	/* Disable interrupts by clearing the interrupt mask. */
	iowrite32(0x00000000, ioaddr + CSR7);
	...
	timer_setup(&tp->timer, tulip_tbl[tp->chip_id].media_timer, 0);

free_irq() only happens later, in tulip_close().  A TPLnkFail/TPLnkPass
interrupt taken in that window reaches:

	tulip_interrupt() -> tp->link_change() -> t21142_lnk_change()
	   -> mod_timer(&tp->timer, RUN_AT(3 * HZ));

and the hook is deliberately called outside tp->lock, so this can run on
another CPU while tulip_down() holds the lock.  tulip_down() then calls
timer_setup() on a timer that is pending again, which re-initialises
timer->entry while the node is still linked into base->vectors[idx].  Can
that corrupt the timer base's hlist, so a later detach_timer() ->
__hlist_del() writes through a NULL pprev from the timer softirq?

If the entry instead stays armed, tulip_remove_one() only calls
unregister_netdev() with no final timer_delete_sync()/timer_shutdown_sync(),
so tulip_timer() would dereference tp->dev after the netdev and the embedded
tulip_private are gone.

The old code had the same shape (sync-delete then add_timer() from hardirq),
so this is not new, but the conversion makes the post-teardown re-arm silent
where add_timer() would at least have tripped WARN_ON_ONCE(timer_pending()).
Would it make sense to mask CSR7 and free the IRQ before the timer sync (or
switch tulip_down() to timer_shutdown_sync()), or to guard the hardirq
re-arm?

There is a symmetric case on the way up: tulip_up() enables CSR7 interrupts
before the unlocked pair

	tp->timer.expires = RUN_AT(next_tick);
	add_timer(&tp->timer);

so a concurrent hardirq mod_timer() races that plain store, and add_timer()
can then hit its pending warning and leave the wrong deadline.

[Severity: Low]
With both add_timer() calls here converted, does the comment in
t21142_media_task() still describe an existing call site?

drivers/net/ethernet/dec/tulip/21142.c:t21142_media_task() {
	...
	/* mod_timer synchronizes us with potential add_timer calls
	 * from interrupts.
	 */
	mod_timer(&tp->timer, RUN_AT(next_tick));
}

tulip_media_task() in timer.c carries the identical wording.  tulip_tbl[]
gives t21142_media_task to DC21142/43 and tulip_media_task to DC21140,
AX88140, I21145, DM910X and RS7112; of those only DC21142/43 and I21145 have
HAS_NWAY, so tp->link_change is t21142_lnk_change, whose two add_timer()
calls this patch removed.  The remaining add_timer(&tp->timer) is in
tulip_up(), which is process context, and the interrupt-path re-arms in
interrupt.c already use mod_timer().

The analogous comment in tulip_interrupt() was updated in this patch, so
should these two say mod_timer calls from interrupts as well?

>  	} else if (dev->if_port == 3  ||  dev->if_port == 5) {
>  		if (tulip_debug > 1)
>  			dev_info(&dev->dev, "21143 %s link beat %s\n",
>  				 medianame[dev->if_port],
>  				 (csr12 & 2) ? "failed" : "good");
>  		if ((csr12 & 2)  &&  ! tp->medialock) {
> -			timer_delete_sync(&tp->timer);
> +			mod_timer(&tp->timer, RUN_AT(3 * HZ));
>  			t21142_start_nway(dev);
> -			tp->timer.expires = RUN_AT(3*HZ);
> -			add_timer(&tp->timer);
>  		} else if (dev->if_port == 5)
>  			iowrite32(csr14 & ~0x080, ioaddr + CSR14);
>  	} else if (dev->if_port == 0  ||  dev->if_port == 4) {

> diff --git a/drivers/net/ethernet/dec/tulip/interrupt.c b/drivers/net/ethernet/dec/tulip/interrupt.c
> index 0a12cb9b3ba78..6ed4b68ad86c2 100644
> --- a/drivers/net/ethernet/dec/tulip/interrupt.c
> +++ b/drivers/net/ethernet/dec/tulip/interrupt.c
> @@ -698,9 +698,8 @@ irqreturn_t tulip_interrupt(int irq, void *dev_instance)
>  				dev->stats.rx_errors++;
>  				tulip_start_rxtx(tp);
>  			}
> -			/*
> -			 * NB: t21142_lnk_change() does a timer_delete_sync(), so be careful
> -			 * if this call is ever done under the spinlock
> +			/* NB: pnic2_lnk_change() does a timer_delete_sync(), so be careful
> +			 * if this call is ever done under the spinlock.
>  			 */
>  			if (csr5 & (TPLnkPass | TPLnkFail | 0x08000000)) {
>  				if (tp->link_change)

[Severity: High]
Since the same hazard is still reachable through this exact hook, would it
be better to convert pnic2_lnk_change() in the same patch rather than
document it in the comment?

tulip_init_one() installs both handlers into the one hook:

drivers/net/ethernet/dec/tulip/tulip_core.c:tulip_init_one() {
	...
	if (tp->chip_id == PNIC2)
		tp->link_change = pnic2_lnk_change;
	else if (tp->flags & HAS_NWAY)
		tp->link_change = t21142_lnk_change;
	...
	timer_setup(&tp->timer, tulip_tbl[tp->chip_id].media_timer, 0);
}

The timer is set up with flags 0, i.e. not TIMER_IRQSAFE, and
pnic2_lnk_change() still has three copies of the old sequence:

drivers/net/ethernet/dec/tulip/pnic2.c:pnic2_lnk_change() {
	...
		timer_delete_sync(&tp->timer);
		pnic2_start_nway(dev);
		tp->timer.expires = RUN_AT(3*HZ);
		add_timer(&tp->timer);
	...
}

On a PNIC-II board a link-state interrupt therefore produces the same
WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE)) splat this patch
fixes for the 21142.

Beyond the warning, __timer_delete_sync() then spins:

kernel/time/timer.c:__timer_delete_sync() {
	do {
		ret = __try_to_del_timer_sync(timer, shutdown);

		if (unlikely(ret < 0)) {
			del_timer_wait_running(timer);
			cpu_relax();
		}
	} while (ret < 0);
}

del_timer_wait_running() is a no-op without CONFIG_PREEMPT_RT, so if the
tulip hardirq lands on the CPU whose timer softirq is currently in
pnic2_timer(), can that callback ever complete, or does the CPU spin
indefinitely?

The commit message says:

  "pnic2_lnk_change() still calls timer_delete_sync() from the same hardirq
  path, but its timer callback re-arms the timer directly with mod_timer(),
  so fixing that path requires separate consideration of the
  callback/reschedule race."

pnic2_timer() re-arming with mod_timer() looks like the same situation as
t21142_media_task()/tulip_media_task(), whose overwrite race the commit
message already accepts for the converted sites.  What makes the PNIC2 case
different?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260905225454.439466-1-linmag7%40gmail.com
