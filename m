Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D283AB5DC;
	Thu, 10 Sep 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014569; cv=none; b=ORQAKUPw4Knj8nyAe+BwjmNlOXlQhqTAq//xckyzTXsX7mfzKUUix8+zviN9EboYTAi5BaDHBeXj7SJCXUndlYkGhTO13s6Epzk+v8G88mTOdIQ4iDyY1mJs7qYSqgrUggb1KvNI2Tm2VaO3YyA/1Eu32SZfHRMFJS74GR/j7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014569; c=relaxed/simple;
	bh=0UQpCnHmZaz6eJE27RdBZoBNNLkmVXC9i16CVAVrYKc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBv8hE6l4wB9NLq7Sk2kcpAVFkbrt2/ECTWkpqhMwxnnxCg+/pooSlxtpuPLeuMhz1iMwwqrS/rmvdYdGa5fjx1Wn8dO5OXtDIGGJcLG0IAJyUBhuWI967tuZ3NW7W++HYfbfGcVMnF+bX6hJ8lstgCPCK7WhhiazKT68s7r/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxsjTs2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxsjTs2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AD31F000FF;
	Thu, 10 Sep 2026 04:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014567;
	bh=aRkxR0tfvuYcQsIW26vPk5E1hxrzATRnV3+jdRehPAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VxsjTs2iKUigxaTKsVJoTj7nRkH2zJFRUuIs794P49WZgsXoHIwAtEZJmMeaZzIFt
	 0bLz8xsBp2QVDpvre9Xta/ASiYP8p9nIa/KdNQgYmD4qx8DzKMQE4g6LFaUOcJ/HTX
	 F7pMGlzF0yGuOmbELk3rflwUO5HepSRev9PVv6W9ORMA5ZAcPfiPX/XFlEv7YYW2ID
	 4B/JWD776tsCMVV/DEqimtSqCvYyua0f4f4S4HVvmnjsDMWp/Bc1g+b22Z0ktyuwP8
	 bW33p7fDHBCOGXnIZmWWudjH4Icr7duArUM9NvpLUmKklSKA+axDVkT/WoydsnlyJ+
	 29Q8m+bAK9hEA==
Subject: Re: [PATCH net v3] net: mana: fix reset work race with device removal
From: netdev-bot+sashiko@kernel.org
To: fanwu01@zju.edu.cn
Cc: netdev@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org,
 songl@zju.edu.cn
Date: Thu, 10 Sep 2026 04:29:25 +0000
Message-ID: <178901456575.219967.1716228063014177420@kernel.org>
In-Reply-To: <20260909042529.652301-1-fanwu01@zju.edu.cn>
References: <20260909042529.652301-1-fanwu01@zju.edu.cn>
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
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1

- [High] GC_REMOVING is a one-way latch that is set on service exits
  which do not necessarily remove the device.
- [Medium] The new `if (test_bit(GC_PROBE_SUCCEEDED, &gc->flags))` gate
  in `mana_gf_stats_work_handler()` (mana_en.c:4068) silently discards…
- [Low] The new service-work submission uses `queue_work(system_wq,
  &gc->serv_work)` (gdma_main.c:886).

Pre-existing issues:
- [High] `mana_gd_shutdown()` (gdma_main.c:2776) tears down the HWC —
  `mana_gd_cleanup_device()` -> `mana_hwc_destroy_channel()` ->…

--

net: mana: fix reset work race with device removal

The service work is moved into struct gdma_context and GC_IN_SERVICE now
describes whether the work may still touch gc.  Removal and the probe
unwind set a new GC_REMOVING bit to close admission and then wait for an
in-flight cycle to retire before clearing drvdata and freeing gc.  Reset
events observed during probe are latched in GC_SERVICE_DURING_PROBE
instead of being admitted immediately.

No Link: tags in the commit header.  Earlier postings referenced in the
changelog:
  https://lore.kernel.org/netdev/20260905023602.425827-1-fanwu01@zju.edu.cn
  https://lore.kernel.org/netdev/20260805143812.220509-1-fanwu01@zju.edu.cn

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index f92b2d0bf926..28544f00e8ce 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -678,10 +678,38 @@ static void mana_serv_rescan(struct pci_dev *pdev)
>  	pci_unlock_rescan_remove();
>  }
>  
> -static void mana_serv_fpga(struct pci_dev *pdev)
> +/* Retire one service cycle: GC_IN_SERVICE is the last state published
> + * by the work, so remove() and the probe unwind may free gc once it
> + * is clear.  Must run before the exit paths take pci_lock_rescan_remove():
> + * removal can be waiting on the bit while holding that lock.
> + */
> +static void mana_service_done(struct gdma_context *gc)
> +{
> +	/* Pairs with test_bit_acquire() on the wait side. */
> +	clear_bit_unlock(GC_IN_SERVICE, &gc->flags);
> +	/* wake_up_var() requires a full barrier between the update of the
> +	 * waited-on variable and the wake.
> +	 */
> +	smp_mb__after_atomic();
> +	wake_up_var(&gc->flags);
> +}
> +
> +/* Retire a cycle whose exit removes the device: close admission
> + * first so no new cycle can be admitted in the retire window.
> + */
> +static void mana_service_done_removing(struct gdma_context *gc)
> +{
> +	set_bit(GC_REMOVING, &gc->flags);
> +	mana_service_done(gc);
> +}
> +
> +static void mana_serv_fpga(struct pci_dev *pdev, struct gdma_context *gc)
>  {
>  	struct pci_bus *bus, *parent;
>  
> +	if (gc)
> +		mana_service_done_removing(gc);
> +
>  	pci_lock_rescan_remove();
>  
>  	bus = pdev->bus;
> @@ -706,9 +734,8 @@ static void mana_serv_fpga(struct pci_dev *pdev)
>  	pci_unlock_rescan_remove();
>  }
>  
> -static void mana_serv_reset(struct pci_dev *pdev)
> +static void mana_serv_reset(struct pci_dev *pdev, struct gdma_context *gc)
>  {
> -	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct hw_channel_context *hwc;
>  	int ret;
>  
> @@ -738,6 +765,7 @@ static void mana_serv_reset(struct pci_dev *pdev)
>  	if (ret == -ETIMEDOUT || ret == -EPROTO) {
>  		/* Perform PCI rescan on device if we failed on HWC */
>  		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
> +		mana_service_done_removing(gc);
>  		mana_serv_rescan(pdev);
>  		return;
>  	}

[Severity: High]
Is GC_REMOVING guaranteed to be followed by an actual removal here?  Both
callers of mana_service_done_removing() can return with the device still
bound.

In mana_serv_fpga(), the bit is set before the bus checks:

	if (gc)
		mana_service_done_removing(gc);

	pci_lock_rescan_remove();

	bus = pdev->bus;
	if (!bus) {
		dev_err(&pdev->dev, "MANA service: no bus\n");
		goto out;
	}

	parent = bus->parent;
	if (!parent) {
		dev_err(&pdev->dev, "MANA service: no parent bus\n");
		goto out;
	}

bus->parent is NULL whenever the MANA function sits on a root bus, so
this exits through "goto out" without calling
pci_stop_and_remove_bus_device().

The failed-resume path has the same shape: mana_serv_rescan() has its own
"if (!parent)" bail-out that returns without removing the device, after
GC_REMOVING has already been latched.

I can't find any code that clears GC_REMOVING again.  Once it is set on a
live gc, mana_schedule_serv_work() refuses every subsequent request:

	if (test_bit(GC_REMOVING, &gc->flags)) {
		dev_info(gc->dev, "Device is being removed\n");
		mana_service_done(gc);
		return -EBUSY;
	}

and mana_tx_timeout() in mana_en.c also stops queueing queue-reset work
for the rest of the binding:

	if (test_bit(GC_IN_SERVICE, &gc->flags) ||
	    test_bit(GC_REMOVING, &gc->flags))
		return;

Does this leave a still-bound device permanently without HWC reset
service and without TX queue reset?  Would it be better to set
GC_REMOVING only after the point where removal is known to happen, or to
clear it on the bail-out paths?

> @@ -796,48 +841,49 @@ static void mana_recovery_delayed_func(struct work_struct *w)

[ ... ]

>  int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type)
>  {
> -	struct mana_serv_work *mns_wk;
> -
>  	if (test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
>  		dev_info(gc->dev, "Already in service\n");
>  		return -EBUSY;
>  	}
>  
> +	/* Pairs with set_bit(GC_REMOVING) + smp_mb__after_atomic() in
> +	 * mana_gd_remove(): the test_and_set_bit() above is fully ordered,
> +	 * so either this read sees GC_REMOVING and the cycle aborts, or
> +	 * remove() observes GC_IN_SERVICE and waits for the cycle to retire
> +	 * before it frees gc.
> +	 */
> +	if (test_bit(GC_REMOVING, &gc->flags)) {
> +		dev_info(gc->dev, "Device is being removed\n");
> +		mana_service_done(gc);
> +		return -EBUSY;
> +	}
> +
>  	if (!try_module_get(THIS_MODULE)) {
>  		dev_info(gc->dev, "Module is unloading\n");
> -		clear_bit(GC_IN_SERVICE, &gc->flags);
> +		mana_service_done(gc);
>  		return -ENODEV;
>  	}
>  
> -	mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> -	if (!mns_wk) {
> -		module_put(THIS_MODULE);
> -		clear_bit(GC_IN_SERVICE, &gc->flags);
> -		return -ENOMEM;
> -	}
> -
>  	dev_info(gc->dev, "Start MANA service type:%d\n", type);
> -	mns_wk->pdev = to_pci_dev(gc->dev);
> -	mns_wk->type = type;
> -	pci_dev_get(mns_wk->pdev);
> -	INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> -	schedule_work(&mns_wk->serv_work);
> +
> +	gc->serv_type = type;
> +	pci_dev_get(to_pci_dev(gc->dev));
> +	queue_work(system_wq, &gc->serv_work);
>  	return 0;
>  }

[Severity: Low]
This isn't a bug, but was system_wq intended here rather than
system_percpu_wq?  In this tree the declaration is:

include/linux/workqueue.h:
	extern struct workqueue_struct *system_wq; /* use system_percpu_wq, this will be removed */

and system_wq is allocated with __WQ_DEPRECATED, so __queue_work() emits:

kernel/workqueue.c:__queue_work() {
	if (unlikely(wq->flags & __WQ_DEPRECATED))
		pr_warn_once("workqueue: work func %ps enqueued on deprecated workqueue. "
			"Use system_{percpu|dfl}_wq instead.\n",
			work->func);
}

The code being replaced used schedule_work(), which queues on
system_percpu_wq.  The stated reason for staying off gc->service_wq is
satisfied equally by schedule_work(&gc->serv_work).

[ ... ]

> @@ -2624,6 +2700,20 @@ static void mana_gd_remove(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  
> +	/* Close admission and retire an in-flight cycle before any
> +	 * teardown: the service work is the only user of gc that
> +	 * remove() does not otherwise synchronise with.  The service
> +	 * exits retire before taking the PCI rescan/remove lock, so
> +	 * this wait cannot deadlock against them.
> +	 */
> +	set_bit(GC_REMOVING, &gc->flags);
> +	/* Pairs with the ordered test_and_set_bit(GC_IN_SERVICE) in
> +	 * mana_schedule_serv_work().
> +	 */
> +	smp_mb__after_atomic();
> +	wait_var_event(&gc->flags,
> +		       !test_bit_acquire(GC_IN_SERVICE, &gc->flags));
> +
>  	pci_disable_sriov(pdev);
>  
>  	mana_rdma_remove(&gc->mana_ib);

[Severity: High]
This isn't a bug introduced by this patch, but should mana_gd_shutdown()
get the same admission-close and drain that is added here?  It tears the
HWC down with no synchronisation against an in-flight service cycle:

static void mana_gd_shutdown(struct pci_dev *pdev)
{
	struct gdma_context *gc = pci_get_drvdata(pdev);

	dev_info(&pdev->dev, "Shutdown was called\n");

	mana_rdma_remove(&gc->mana_ib);
	mana_remove(&gc->mana, true);

	mana_gd_cleanup_device(pdev);

	pci_disable_device(pdev);
}

Meanwhile mana_serv_reset() caches the HWC pointer and then sleeps for
MANA_SERVICE_PERIOD seconds across suspend/resume:

	hwc = gc->hwc.driver_data;
	...
	hwc->hwc_timeout = 0;
	...
	mana_gd_suspend(pdev, PMSG_SUSPEND);

	msleep(MANA_SERVICE_PERIOD * 1000);

	ret = mana_gd_resume(pdev);

mana_gd_cleanup_device() -> mana_hwc_destroy_channel() does kfree(hwc),
and both paths call it.  device_shutdown() takes only
device_lock(&pdev->dev), which the service work does not hold, so on
reboot or kexec during a reset cycle can this end up as a use-after-free
of hwc and a second kfree()/destroy_workqueue() on the same objects?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 591fb4191d90..c297de8bb762 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -4061,9 +4061,12 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
>  		dev_warn(gc->dev,
>  			 "Gf stats wk handler: gf stats query timed out.\n");
>  		/* As HWC timed out, indicating a faulty HW state and needs a
> -		 * reset.
> +		 * reset.  Never admit service work before the probe has
> +		 * completed: a probe that is failing unwinds netdevs and the
> +		 * HWC channel itself and cannot drain a cycle.
>  		 */
> -		mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
> +		if (test_bit(GC_PROBE_SUCCEEDED, &gc->flags))
> +			mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
>  		return;
>  	}
>  	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);

[Severity: Medium]
What happens to the reset request when this gate is false but the probe
then succeeds?

mana_probe() arms this work before returning to mana_gd_probe():

	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);

with MANA_GF_STATS_PERIOD being 2 * HZ, while mana_gd_probe() still has
mana_rdma_probe() to run before it publishes the flag:

	set_bit(GC_PROBE_SUCCEEDED, &gc->flags);
	if (test_and_set_bit(GC_SERVICE_DURING_PROBE, &gc->flags)) {

So a mana_query_gf_stats() timeout in that window takes the new branch,
drops the request, and the bare "return;" also skips the
schedule_delayed_work() re-arm below it.

The EQE handler in gdma_main.c latches and re-checks instead:

	if (!test_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
		if (!test_and_set_bit(GC_SERVICE_DURING_PROBE, &gc->flags))
			dev_info(gc->dev,
				 "Service is to be processed in probe\n");
		else if (test_bit(GC_PROBE_SUCCEEDED, &gc->flags))
			mana_schedule_serv_work(gc, type);
		break;
	}

Here there is neither a latch nor a re-check, and the plain test_bit()
also races the set_bit() at the probe boundary.  If the probe goes on to
succeed, the device is left with ac->hwc_timeout_occurred set, the stats
poll never re-armed, and no reset cycle requested, where the previous
code called mana_schedule_serv_work() unconditionally.  Should this call
site latch into GC_SERVICE_DURING_PROBE (or re-check after the boundary)
so the request is not lost?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909042529.652301-1-fanwu01%40zju.edu.cn
