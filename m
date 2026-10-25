Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932181;
	b=CrCFmnRuopqTSrpqsFrRkB4dr77x4yC1G+Lp557OuRoowjRJtZ14yYhoXOkSzUr5iNSV
	 nuVEKLIYHz6xCG8mfEWv5XbSSduBNK1IXxzF54zz0x/SEOyAZkEY1lUMqn8iX5xb+5XmY
	 wS7z0E/4B9ueN7R6tkWUDvbayGI11KPAGs87A5S9Mihs9MrCNvyZOxCCxUEn/TtwQN5ym
	 F2d67LG90keZh66DX/LpneYZT/5Dwm6Q97UQjJ91+6hI5a1+5g4nvuxUEIx07u+dxI0R0
	 23390jS136N29APEjktnmrUqxsHFGhqB2m8l/iMW0jRNFcaBBSxKvyJW4JqGg1wNjTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932181;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vJWoAwe3qnJBLGNpZc4vSHcUQx1lGIX+9ZrLVZI42Eg=;
	b=mv2v5M6N9EXGtg3qVX8KWKws+3B8dI1CWFdaa2F14JSlbWFbG3pegj8pmNv+8ejdzYCV
	 DqrTkpy0WB1wUWhLMdCP0JD/O0KowDuDUCr+jnF57AQrxW2tcQRHsYf+yYq0TbLNOexQ+
	 kNmWU7ACy4wC54FigptwXulFEbcQqNZhJJeL7UN/jrf63Z193cMuEqb2qab86Abb5nOV4
	 QWCB6J4l3qJ2UmVi/uto8oZKOZRp1b1UAUVjXvNShPVFY/qzy5tsrhltVlUc/xBAk5DSv
	 P1QOWWbJWsrcqu/EXArwwiGyC2nulHNPmpctdcYRA2bHDSBBRau+oAUnsRRkjFOk+lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPvDvKm4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D23606A31F;
	Sun, 25 Oct 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPvDvKm4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B307F1F01825;
	Sun, 25 Oct 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792932181;
	bh=vJWoAwe3qnJBLGNpZc4vSHcUQx1lGIX+9ZrLVZI42Eg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gPvDvKm4gpgD8A3UGLGuILA0BuFcoPnDD4xFJsEvSUZImaDTFj14PVrE3h82fEjIi
	 DgKIOeQS5WxmFCIWoCtlOuUZLAe00asFiMeIwWj69cksoGq1Q51IH0VZL4IuTPvgPw
	 DBOQjORfW76LLS3MLWkW24gB+f8VL1i5s4gmd0wfwYDSEQtwDiCamAV0HVnwmX/uAo
	 MydV0jPDW4repx6wB9yHpWlhf9KBxlZ9pdOSKE7cDmcXYcPIS+Qpex5Jrj6uohODsa
	 H4pDfbPjxuv/doQ34N/WnAKWxKRuLdYTy9yDWZ8zV7J+jRm4ttSTJE/Oosv/x47/No
	 GmsmYFCLwEoaA==
Subject: Re: [PATCH net v2] net: jme: keep RX MAC clock enabled for WoL
From: netdev-bot+sashiko@kernel.org
To: franck.baur.67@gmail.com
Cc: cooldavid@cooldavid.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 25 Oct 2026 12:43:00 +0000
Message-ID: <179293218031.3134.11897167819682448538@kernel.org>
In-Reply-To: <20261024-jme-wol-v2-submit-v2-1-7a89ef6fb4c9@gmail.com>
References: <20261024-jme-wol-v2-submit-v2-1-7a89ef6fb4c9@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] jme_suspend() now calls napi_disable() and
  tasklet_disable(pcc_task) and sets JME_FLAG_WOL_QUIESCE.
- [High] jme_shutdown() checks netif_running() and then calls
  napi_disable() and tasklet_disable() without holding rtnl_lock().
- [Medium] The patch keeps tasklets disabled for long periods while they
  can still be pending or newly scheduled.
- [Medium] Netpoll can queue link-change work after the new quiesce has
  run cancel_work_sync().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but neither
  jme_close() nor jme_remove_one() calls tasklet_kill(&jme->pcc_task).
- [Medium] This problem wasn't introduced by this patch, but
  jme_shutdown() arms WoL while the RX/TX engines are still enabled and…

--

net: jme: keep RX MAC clock enabled for WoL

This commit keeps the RX MAC clock ungated while WoL is armed on JMC250
rev 03 so that Magic Packet wake from S3 works, and gates the clock again
on resume. It also adds a JME_FLAG_WOL_QUIESCE flag. jme_suspend() and
jme_shutdown() now quiesce IRQs, link-change work, NAPI and tasklets
before programming WoL, and jme_resume() undoes this.

> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index 25ec5f757c682..acb4d41f56e10 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -1502,7 +1502,8 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
>  		 * all other events are ignored
>  		 */
>  		jwrite32(jme, JME_IEVE, intrstat);
> -		schedule_work(&jme->linkch_task);
> +		if (!test_bit(JME_FLAG_WOL_QUIESCE, &jme->flags))
> +			schedule_work(&jme->linkch_task);

[Severity: Medium]

Can netpoll still queue linkch_task after jme_suspend() or jme_shutdown()
has already run cancel_work_sync()?

With CONFIG_NET_POLL_CONTROLLER and netconsole bound to this device,
jme_netpoll() calls the interrupt handler directly:

drivers/net/ethernet/jme.c:jme_netpoll() {
	local_irq_save(flags);
	jme_intr(dev->irq, dev);
	local_irq_restore(flags);
}

synchronize_irq() doesn't wait for this caller. netpoll_poll_dev() only
checks netif_running(), and netif_device_detach() doesn't clear that.

Suppose the netpoll CPU reads the flag as clear and is then delayed
(NMI, SMI, vCPU preemption) before schedule_work():

CPU1 (netpoll)                      CPU2 (suspend/shutdown)
jme_intr_msi()
  test_bit(WOL_QUIESCE) == 0
                                    set_bit(JME_FLAG_WOL_QUIESCE)
                                    synchronize_irq()
                                    cancel_work_sync(&jme->linkch_task)
  schedule_work(&jme->linkch_task)

In jme_shutdown(), link_changing is still 1. That means
jme_link_change_work() can run all the way through and reach
jme_reset_mac_processor()->jme_mac_rxclk_off() after WoL is armed. The
commit message says this re-gating is prevented.

In jme_suspend(), the work can overlap the RX/TX ring teardown. If it
starts after atomic_dec(&jme->link_changing), it spins in its
link_changing wait loop until resume.

>  		goto out_reenable;
>  	}

[ ... ]

> @@ -3158,6 +3161,21 @@ jme_shutdown(struct pci_dev *pdev)
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct jme_adapter *jme = netdev_priv(netdev);
>  
> +	if (netif_running(netdev)) {
> +		set_bit(JME_FLAG_WOL_QUIESCE, &jme->flags);
> +		netif_device_detach(netdev);
> +		netif_stop_queue(netdev);
> +		jme_stop_irq(jme);
> +		synchronize_irq(pdev->irq);
> +		jme_stop_irq(jme);
> +		cancel_work_sync(&jme->linkch_task);
> +		tasklet_disable(&jme->pcc_task);
> +		napi_disable(&jme->napi);

[Severity: High]

Is anything serializing this with jme_close()?

jme_shutdown() checks netif_running() and then calls napi_disable() and
tasklet_disable() without rtnl_lock(). Meanwhile jme_close() tears down
the same NAPI instance under rtnl. device_shutdown() can run during
reboot -f or kexec -e while userspace (for example NetworkManager) is
still able to close the interface.

After a completed disable, napi_disable_locked() leaves
NAPIF_STATE_SCHED and NAPIF_STATE_NPSVC set, so a second disable spins
here forever:

net/core/dev.c:napi_disable_locked() {
	...
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
	...
}

The napi_disable_pending() guard in JME_NAPI_DISABLE() doesn't detect an
earlier disable that has already completed.

If jme_close() runs JME_NAPI_DISABLE() between the netif_running() check
and this napi_disable(), wouldn't the reboot hang here?

If the order is reversed, jme_close() would hang in napi_disable() while
holding rtnl. Its tasklet_kill() calls would also wait forever on
tasklets that are disabled but still scheduled.

Before this patch, jme_shutdown() didn't touch NAPI or tasklet state.
Would wrapping this block in rtnl_lock()/rtnl_unlock(), as
__igb_shutdown() does, avoid the race?

> +		tasklet_disable(&jme->txclean_task);
> +		tasklet_disable(&jme->rxclean_task);
> +		tasklet_disable(&jme->rxempty_task);
> +	}

[Severity: Medium]

Can these disabled tasklets still be pending, and would that leave
ksoftirqd spinning?

tasklet_disable() waits for a running instance but not for a pending
one. jme_intr_msi() also still schedules the tasklets without checking
JME_FLAG_WOL_QUIESCE:

drivers/net/ethernet/jme.c:jme_intr_msi() {
	...
	if (intrstat & INTR_TMINTR) {
		jwrite32(jme, JME_IEVE, INTR_TMINTR);
		tasklet_schedule(&jme->pcc_task);
	}
	...
}

The handler can still run after the quiesce in three ways:

- through the shared INTx line (jme_request_irq() uses IRQF_SHARED)
  when an event bit is latched in JME_IEVE
- from a handler that raced past synchronize_irq()
- from netpoll

When a scheduled tasklet has a non-zero count, tasklet_action_common()
requeues it and raises the softirq again:

kernel/softirq.c:tasklet_action_common() {
	...
		local_irq_disable();
		t->next = NULL;
		*tl_head->tail = t;
		tl_head->tail = &t->next;
		__raise_softirq_irqoff(softirq_nr);
		local_irq_enable();
	...
}

jme_suspend() keeps pcc_task disabled until jme_resume(). The CPU would
then keep running softirqs for the whole suspend period and couldn't go
idle under s2idle.

In jme_shutdown(), pcc_task, txclean_task, rxclean_task and rxempty_task
are never re-enabled. The RX engine is also left running with the RX
clock forced on. Wouldn't the spin then last for the rest of the
shutdown sequence?

Before this patch, pcc_task was never disabled, and the other tasklets
were disabled only briefly in jme_suspend().

> +
>  	jme_powersave_phy(jme);
>  	pci_pme_active(pdev, true);
>  }

[Severity: Medium]

This is a pre-existing issue and wasn't introduced by this patch.
jme_shutdown() arms WoL while the RX/TX engines are still enabled and
the descriptor ring registers still point at host memory. jme_suspend()
quiesces the MAC first:

drivers/net/ethernet/jme.c:jme_suspend() {
	...
		jme_stop_pcc_timer(jme);
		jme_disable_rx_engine(jme);
		jme_disable_tx_engine(jme);
		jme_reset_mac_processor(jme);
	...
}

jme_shutdown() does none of this before jme_powersave_phy(). Then
jme_set_100m_half() writes JME_GHC and forces the PHY to 100M half
while the engines are live. Now that NAPI and the RX tasklets are
disabled in this path, nothing drains the live RX ring either.

Could this leave the MAC in an undefined state for S5 Magic Packet
wake? The commit message notes that S5 wake wasn't validated.

> @@ -3172,11 +3190,16 @@ jme_suspend(struct device *dev)
>  	if (!netif_running(netdev))
>  		return 0;
>  
> -	atomic_dec(&jme->link_changing);
> -
> +	set_bit(JME_FLAG_WOL_QUIESCE, &jme->flags);
>  	netif_device_detach(netdev);
>  	netif_stop_queue(netdev);
>  	jme_stop_irq(jme);
> +	synchronize_irq(jme->pdev->irq);
> +	jme_stop_irq(jme);
> +	cancel_work_sync(&jme->linkch_task);
> +	tasklet_disable(&jme->pcc_task);

[Severity: High]

This isn't a bug introduced by this patch. Since pcc_task is now managed
explicitly here, though: neither jme_close() nor jme_remove_one() calls
tasklet_kill(&jme->pcc_task).

jme_close() kills only the other deferred contexts:

drivers/net/ethernet/jme.c:jme_close() {
	...
	cancel_work_sync(&jme->linkch_task);
	tasklet_kill(&jme->txclean_task);
	tasklet_kill(&jme->rxclean_task);
	tasklet_kill(&jme->rxempty_task);
	...
}

free_irq() waits for running handlers, but it doesn't flush tasklets
those handlers have already scheduled. The last pcc_task scheduled on
INTR_TMINTR may still be pending (for example, ksoftirqd starved by a
real-time task) when jme_remove_one() does this:

	unregister_netdev(netdev);
	iounmap(jme->regs);
	free_netdev(netdev);

jme_pcc_tasklet() would then dereference the freed jme_adapter and do
MMIO through the unmapped jme->regs in
jme_stop_pcc_timer()/jme_start_pcc_timer().

Should jme_close() also call tasklet_kill() on pcc_task?

> +	napi_disable(&jme->napi);

[Severity: High]

What happens if the interface is closed after jme_suspend() and before
jme_resume()?

NAPI stays disabled until jme_resume(), and jme_resume() only undoes
that when netif_running() is true. A close in that window would reach
JME_NAPI_DISABLE() in jme_close() and call napi_disable() a second
time.

After a completed disable, napi_disable_locked() leaves
NAPIF_STATE_SCHED and NAPIF_STATE_NPSVC set. Wouldn't the second call
spin forever while holding rtnl_lock and the netdev instance lock?

One path that can run during suspend is netns cleanup on netns_wq,
which is not freezable. It moves physical devices back to init_net:

netns cleanup work (netns_wq)
  __dev_change_net_namespace()
    netif_close()
      jme_close()
        JME_NAPI_DISABLE()
          napi_disable()

Even if the close got past NAPI, jme_resume() returns early for a
closed device. Neither jme_close() nor jme_open() clears
JME_FLAG_WOL_QUIESCE or re-enables pcc_task. After that, jme_intr_msi()
would never schedule link-change work or re-enable JME_IENS.

jme_shutdown() leaves the same state behind, and nothing ever undoes
it there.

> +	atomic_dec(&jme->link_changing);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024-jme-wol-v2-submit-v2-1-7a89ef6fb4c9%40gmail.com
