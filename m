Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BD377A81;
	Fri,  2 Oct 2026 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919181; cv=none; b=M5WeCaamHnG7x3TMiwf+5oRzcQdwH3pPOTRSTiIsxeVsjoqtlzVCAR3NLeX3i/AU0ByTkcjClrvNW2XEKN93znAvIJFPHyaqZxSun9YpWrbYukCJaoE98xQEpnclvaRLoerhwYAU4883FHyNHgkotZI4p1xx8fQEp76NWvQ2hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919181; c=relaxed/simple;
	bh=5fR8XI1ZEmNG6weXpXbU4sW5t5o3ly+HoLt8cA2Q8yk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UyqG5bc9E6cZPMhaZb9uuFt6MJjiUZyMfA9IiQX504lff05Zb6xIezWE9eypEvwpolCeaUoDjy1bRILRkIbTXIqVr7Or/Y5cgljU/9/gtDUh1eABK1K0NMkXpbHqzndg3Gt35vVhPUJMr1XvwKN3VNM/isy8Q2tlgh5JZMG7gV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSNYpFOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSNYpFOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B2B1F000FF;
	Fri,  2 Oct 2026 05:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790919170;
	bh=CoVWSZX+Xvv1m88OSTsqz9MZ+Eh+7jD5+KQpJAhjTUM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gSNYpFOw/GnO06tibC2WpN6YUhPr/PETOG0bqZw5j1bDlqvc3OPAEILZTC7ANcHp3
	 S0IUUEWt7Dglt+q5LJq2MgfcuV1D0ij+H5LPdB+jEZerEoOgclFOcqmZrki0Z96ZzD
	 FdTlyH2Jxq+2eTcf9hPQTED7HTAQBxtN8WzEx+NjkdDvQ4jtI0wTLepPs5JtMVvHzh
	 itBhSnz3G9CfRWte7G7uqCUmnM6DQPQ9zzdIALmNlvU2p+PmZezHg2QrHtEoTKERI2
	 h5vZffAFrQQJES99DYrCZ2KYMSJhDWMcK8lhdw8uIxcdeE68TAO04APmdXUTvB6eth
	 RPMuI68wQ4knw==
Subject: Re: [PATCH net v5] net: mana: fix reset work race with device removal
From: netdev-bot+sashiko@kernel.org
To: fanwu01@zju.edu.cn
Cc: netdev@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, songl@zju.edu.cn
Date: Fri, 02 Oct 2026 05:32:49 +0000
Message-ID: <179091916908.434549.1012399591583356885@kernel.org>
In-Reply-To: <20260927105243.592348-1-fanwu01@zju.edu.cn>
References: <20260927105243.592348-1-fanwu01@zju.edu.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The rescan exits signal 'idle' to remove/shutdown before the PCI
  manipulation they still have to do.
- [Medium] Probe rollback leaves admission open.
- [Medium] Embedding serv_work in gc allows a workqueue self-deadlock
  through a recycled work address.
- [Low] Comments in mana_gf_stats_work_handler() (mana_en.c) contradict
  the code.

Pre-existing issues:
- [High] This bug predates the patch, but the patch leaves it in place.

--

net: mana: fix reset work race with device removal

This patch embeds the MANA service work in gdma_context and adds a
serv_lock and waitqueue to control when a service cycle may be admitted
and when it retires. Removal, shutdown and the probe unwind close
admission and wait for any in-flight cycle before freeing gc. Reset
events seen during probe are latched and left to the probe rollback path.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8e9bfc1d6a2ae..4ebe595971a4f 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -659,63 +659,149 @@ EXPORT_SYMBOL_NS(mana_gd_ring_dim, "NET_MANA");

[ ... ]

> +static void mana_serv_rescan(struct pci_dev *pdev, struct gdma_context *gc)
> +{
> +	struct pci_bus *parent;
>
>  	parent = pdev->bus;
>  	if (!parent) {
>  		dev_err(&pdev->dev, "MANA service: no parent bus\n");
> -		goto out;
> +		/* Still bound: keep admission open for later events. */
> +		if (gc)
> +			mana_service_retire(gc);
> +		return;
>  	}
>
> +	if (gc)
> +		mana_service_retire_removing(gc);
> +
> +	pci_lock_rescan_remove();
> +
>  	pci_stop_and_remove_bus_device(pdev);
>  	pci_rescan_bus(parent);

[Severity: High]
Can mana_gd_remove() or mana_gd_shutdown() finish while this cycle still
has PCI work left to do?

mana_service_retire_removing() clears serv_in_flight and wakes
serv_waitq. That lets mana_service_quiesce() return, and the teardown
owner carries on.

The cycle then takes pci_lock_rescan_remove() and still runs
pci_stop_and_remove_bus_device(pdev) and pci_rescan_bus(parent). Both act
on a topology captured before the lock was taken, and nothing checks
again whether teardown already happened. mana_serv_fpga() has the same
ordering.

Shutdown: mana_gd_shutdown() gets past quiesce and runs mana_rdma_remove(),
mana_remove(&gc->mana, true), mana_gd_cleanup_device() and
pci_disable_device(), but the driver stays bound. The cycle then removes
the device, so device_release_driver() runs mana_gd_remove() a second
time through the leftover ac. The second pci_disable_device() then hits:

    dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
                  "disabling already-disabled device");

After that, pci_rescan_bus() re-enumerates the function during
reboot/kexec.

Unbind or sysfs remove: after gc is freed, the cycle still removes and
rescans. Could an unbound or removed device come back and rebind?

Hyper-V VF hot-remove: a removed VF makes mana_gd_resume() return
-ETIMEDOUT, so this rescan exit is the expected branch.
hv_pci_remove() calls mana_gd_remove() under pci_rescan_remove_lock and
quiesce returns. hv_pci_remove() then continues:

    pci_remove_root_bus(hbus->bridge->bus);
    pci_unlock_rescan_remove();
    ...
    hv_pci_bus_exit(hdev, false);
    ...
    kfree(hbus);

The waiting cycle then runs pci_rescan_bus() on the removed root bus.
pci_bus_get() in pci_alloc_dev() keeps the pci_bus struct alive, so
config reads still reach hv_pcifront_read_config():

    struct hv_pcibus_device *hbus =
        container_of(bus->sysdata, struct hv_pcibus_device, sysdata);

Does that use hbus after it has been freed?

Could the cycle recheck under the rescan/remove lock whether teardown has
already taken over? Or could it hold off signalling idle until the
remove/rescan is done?

[ ... ]

> @@ -738,7 +824,7 @@ static void mana_serv_reset(struct pci_dev *pdev)
>  	if (ret == -ETIMEDOUT || ret == -EPROTO) {
>  		/* Perform PCI rescan on device if we failed on HWC */
>  		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
> -		mana_serv_rescan(pdev);
> +		mana_serv_rescan(pdev, gc);
>  		return;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but the PCI PM callbacks are
still outside the new serv_lock admission/drain protocol. mana_driver
registers:

    .suspend	= mana_gd_suspend,
    .resume		= mana_gd_resume,

mana_serv_reset() calls the same functions directly from the system
workqueue:

    mana_gd_suspend(pdev, PMSG_SUSPEND);
    msleep(MANA_SERVICE_PERIOD * 1000);
    ret = mana_gd_resume(pdev);

system_percpu_wq is not freezable, and the worker does not take
device_lock. So can a system suspend or hibernate run
pci_legacy_suspend()->mana_gd_suspend() while an admitted cycle is in its
suspend/sleep/resume window?

If so, both threads run mana_rdma_remove(), mana_remove(&gc->mana, true)
and mana_gd_cleanup_device() on the same gc. For example,
mana_hwc_destroy_channel() does:

    struct hw_channel_context *hwc = gc->hwc.driver_data;

    if (!hwc)
        return;

Both callers can see hwc as non-NULL and free it. The
destroy_workqueue(gc->service_wq) call behind the NULL check in
mana_gd_cleanup_device() can also run twice.

The changelog below the fold says the PM path was left out. Could the
commit message itself say that this sibling teardown path is still
unprotected?

[ ... ]

> @@ -796,51 +899,94 @@ static void mana_recovery_delayed_func(struct work_struct *w)
>
>  static void mana_serv_func(struct work_struct *w)
>  {
> -	struct mana_serv_work *mns_wk;
> -	struct pci_dev *pdev;
> -
> -	mns_wk = container_of(w, struct mana_serv_work, serv_work);
> -	pdev = mns_wk->pdev;
> +	struct gdma_context *gc = container_of(w, struct gdma_context, serv_work);
> +	struct pci_dev *pdev = to_pci_dev(gc->dev);
>
> -	if (pdev)
> -		mana_do_service(mns_wk->type, pdev);
> +	mana_do_service(gc->serv_type, pdev, gc);
>
> +	/* The rescan exits of mana_do_service() remove the device, which
> +	 * frees gc before returning.  Only touch the pdev and the module
> +	 * reference from here on; both are held until this point drops them.
> +	 */
>  	pci_dev_put(pdev);
> -	kfree(mns_wk);
>  	module_put(THIS_MODULE);
>  }

[Severity: Medium]
Can embedding serv_work in gc cause a workqueue self-deadlock through a
recycled work address?

On the rescan exit, mana_serv_func() is still running when the gc that
holds its work_struct is freed and a new gc is allocated:

mana_serv_func()
  mana_do_service()
    mana_serv_reset()
      mana_serv_rescan()
        pci_stop_and_remove_bus_device()
          mana_gd_remove()
            vfree(gc)
        pci_rescan_bus()
          mana_gd_probe()
            gc = vzalloc(sizeof(*gc))

vzalloc() might return the same address. In that case the new
gc->serv_work has the same address and the same func as the work this
worker is executing.

Suppose the new probe then latches a reset event, and a second event or
a gf_stats timeout is admitted in the rollback window. That window is
covered in the comment on the mana_gd_probe() rollback below. The new
work is queued with schedule_work(). If it lands on the same pool,
find_worker_executing_work() matches:

    if (worker->current_work == work &&
        worker->current_func == work->func)
        return worker;

and assign_work() moves it onto this worker's scheduled list.

This worker, however, is the one blocked in mana_service_quiesce() in the
probe rollback, waiting for serv_in_flight to clear. So the queued work
never runs, and the worker would hang forever holding the new pdev's
device_lock and pci_rescan_remove_lock.

Before this patch, mns_wk was only freed after the rescan returned, so
its address could not be reused while it was still running. Closing
admission in the same serv_lock section on rollback in
mana_service_probe_complete() would also avoid this.

[ ... ]

> +static bool mana_service_probe_complete(struct gdma_context *gc)
> +{
> +	unsigned long flags;
> +	bool rollback;
> +
> +	spin_lock_irqsave(&gc->serv_lock, flags);
> +	gc->serv_probe_done = true;
> +	rollback = gc->serv_during_probe;
> +	spin_unlock_irqrestore(&gc->serv_lock, flags);
> +	return rollback;
> +}

[ ... ]

> @@ -2558,22 +2697,26 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

[ ... ]

> -	if (test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
> +	rollback = mana_service_probe_complete(gc);
> +	if (rollback) {
>  		err = -EPROTO;
> -		goto cleanup_mana_rdma;
> +		goto service_quiesce;
>  	}
>
>  	return 0;
>
> -cleanup_mana_rdma:
> +service_quiesce:
> +	/* Only a rollback can have admitted a cycle: it ran
> +	 * mana_service_probe_complete() before jumping here.
> +	 */
> +	mana_service_quiesce(gc);

[Severity: Medium]
Is admission left open between mana_service_probe_complete() and this
mana_service_quiesce()?

When mana_service_probe_complete() returns rollback == true, it has
already set serv_probe_done = true. serv_removing is not set until
mana_service_quiesce() runs here.

In that window, a hard IRQ reset or FPGA EQE goes through
mana_service_event():

    admit = gc->serv_probe_done;
    ...
    if (admit)
        mana_schedule_serv_work(gc, type);

This patch keeps mana_gf_stats_work_handler() re-arming during probe. In
the same window it sees mana_service_probe_done(gc) return true and calls
mana_schedule_serv_work() too.

If a cycle is admitted here, the probe sleeps in mana_service_quiesce()
under device_lock through the whole reset cycle. When the probe runs from
a service rescan, it may also hold pci_rescan_remove_lock. The cycle runs
mana_gd_suspend(), msleep(MANA_SERVICE_PERIOD * 1000) and
mana_gd_resume().

The probe then unwinds with mana_rdma_remove(), mana_remove() and
mana_gd_cleanup_device() on state the cycle just rebuilt, and queues the
-EPROTO recovery rescan. If the cycle's resume fails, the cycle also takes
its own rescan exit, so the device is serviced twice.

The commit message says:

    Do not admit service work while probe is still constructing or
    unwinding the device.

The label comment above also admits that a rollback can have let a cycle
in.

Could mana_service_probe_complete() set serv_removing in the same
serv_lock section when rollback is true? Or could it leave
serv_probe_done unset on rollback?

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 591fb4191d90d..c9ac982925224 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -4060,10 +4060,20 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
>  		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
>  		dev_warn(gc->dev,
>  			 "Gf stats wk handler: gf stats query timed out.\n");
> -		/* As HWC timed out, indicating a faulty HW state and needs a
> -		 * reset.
> +		/* As HWC timed out, indicating a faulty HW state and
> +		 * needs a reset.  Never admit service work before the probe
> +		 * has completed: a probe that is failing unwinds netdevs and
> +		 * the HWC channel itself and cannot drain a cycle.
>  		 */
> -		mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
> +		if (mana_service_probe_done(gc)) {
> +			mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
> +		} else {
> +			/* Retry once the probe completes: dropping the
> +			 * request would leave the stats work disarmed.
> +			 */
> +			schedule_delayed_work(&ac->gf_stats_work,
> +					      MANA_GF_STATS_PERIOD);
> +		}

[Severity: Low]
This isn't a bug, but the comments here don't match the code.

The new comment says a failing probe "cannot drain a cycle". However,
mana_gd_probe() now drains one with mana_service_quiesce(), both at the
service_quiesce label and again before vfree() at free_gc.

The existing comment just above this block also still says:

    /* HWC timeout detected - reset stats and stop rescheduling */

But the new else branch reschedules gf_stats_work.

Should both comments be updated?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927105243.592348-1-fanwu01%40zju.edu.cn
