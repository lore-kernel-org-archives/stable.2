Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74D368D66;
	Sat, 26 Sep 2026 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449085; cv=none; b=AISbNLjrI/rU7fW0Vdh0Gb55JX/FtkdvZut1cFrOms6PSpplaFfQhCcfpR/D7IAlIJAhzZA1B9dzN/DuoDqyyAdqT8AQibBhpp96gFo/BQ/LbnX6PkviPUBRQf09+lVNZOLSWnZH0dmw/noRxPlrJCsDHBWNb52SDEukKNbeNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449085; c=relaxed/simple;
	bh=mWFmrQYgV2LAsBjAb2GiSDyoNZstKuqK2QwfumxlqDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKEpGSfL6lVlnFwUzw57urhoTfYZg2Lg/pvoqrHf+hI9QENaLKAEQbxJo6Deq1VaHaUiGGF5PmZ3cCwiAMqrHqvhv7Ua3nNLw7XQV0/8wjhNKqobcES7uaRhqdbdIMUGTHvo0S7xC8Udz/YbODzPacnuzzw8n+VRmIHqfmqoXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhdTsF6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhdTsF6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1171F000FF;
	Sat, 26 Sep 2026 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790449084;
	bh=1K5UDdT+kVdpYBMxZC6/uTgz5rv7oUyjevgEXos2qtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhdTsF6BQnLG1iGJ1Wwdp99Dx8iH0ZTL0dDksYkP06RyYJWQ7WhWX1QnNgPmTduDK
	 QEEWoSUdPfqpfAzcCoeZnwbKD8D5K3ibOkzI0NtE29kjN3I5GGxVXvn6YSmmxk+QmG
	 CH1st4LIUhpgbz03eUPMo/DL5WtXO2x70TAalZyXVg8eeaQAoJFva+RsNrbOJFu9Ob
	 BUNtvB6H4OyLb367Stdtb615AAHzFJOtrBngGB69El5+QrGZzuPSQyLKZHTYs6unTR
	 YDhjqAf88/u5aarDHVTGdYw0mLPZCQgesgc3ghOb1W9XwIbpQh5QtsF/RVK+zYJmsb
	 Q9d3DWldN8cTg==
From: Simon Horman <horms@kernel.org>
To: fanwu01@zju.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	songl@zju.edu.cn
Subject: Re: [PATCH net v4] net: mana: fix reset work race with device removal
Date: Sat, 26 Sep 2026 19:57:48 +0100
Message-ID: <20260926185748.757672-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922070728.309280-1-fanwu01@zju.edu.cn>
References: <20260922070728.309280-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922070728.309280-1-fanwu01@zju.edu.cn?part=1
---
net: mana: fix reset work race with device removal

The service work item is moved into struct gdma_context and its lifecycle
is guarded by a new serv_lock plus a waitqueue, so removal, shutdown and
the probe unwind can close admission and wait for an in-flight reset cycle
before gc is freed.  The probe boundary is handled by latching reset events
that arrive while the probe is still running.

A few questions below about the new admission gates and the paths that were
not converted.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8e9bfc1d6a2ae..b91d2542cfe56 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c

[ ... ]

> @@ -796,51 +899,94 @@ static void mana_recovery_delayed_func(struct work_struct *w)

[ ... ]

> +/* Serialize admission with retirement.  Called in hard IRQ context, so
> + * serv_lock is taken with interrupts disabled and nothing that may
> + * sleep runs under it.
> + */
>  int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type)
>  {
> -	struct mana_serv_work *mns_wk;
> +	unsigned long flags;
> +	bool busy;

[ ... ]

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
Is system_wq the intended target here?  include/linux/workqueue.h carries:

    extern struct workqueue_struct *system_wq; /* use system_percpu_wq, this will be removed */

and system_wq is created with __WQ_DEPRECATED, so __queue_work() emits:

    workqueue: work func %ps enqueued on deprecated workqueue. Use system_{percpu|dfl}_wq instead.

The schedule_work() that was removed expanded to queue_work(system_percpu_wq,
...), so this hunk seems to newly pick the deprecated alias and a warning on
every service cycle.

Given that mana_serv_reset()/mana_serv_fpga() do msleep(MANA_SERVICE_PERIOD *
1000) and PCI stop/rescan, would system_long_wq (or system_dfl_long_wq) be a
better fit than the per-CPU queue?

[ ... ]

> @@ -2558,22 +2697,26 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	err = mana_rdma_probe(&gc->mana_ib);
>  	if (err)
> -		goto cleanup_mana;
> +		goto service_quiesce;
>  
>  	/*
>  	 * If a hardware reset event has occurred over HWC during probe,
>  	 * rollback and perform hardware reset procedure.
>  	 */
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
> +	/* The stats work can admit service once mana_probe() has run:
> +	 * retire an in-flight cycle before any teardown.
> +	 */
> +	mana_service_quiesce(gc);

[Severity: Low]
Does this comment still describe the code after the change in mana_en.c?

The stats work handler now only admits service when
mana_service_probe_done(gc) is true, and serv_probe_done is set solely by
mana_service_probe_complete(), which runs after mana_rdma_probe() has
succeeded.  On the path that jumps here because mana_rdma_probe() failed,
serv_probe_done is still false, so the stats work cannot have admitted a
cycle at all, and the EQ producer is gated on the same flag.

Could the comment be reworded to match the gate, or is a producer intended
that can still admit during probe?

[ ... ]

> @@ -2687,6 +2837,9 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  
>  	dev_info(&pdev->dev, "Shutdown was called\n");
>  
> +	/* Shutdown tears down the same HW paths as remove(). */
> +	mana_service_quiesce(gc);
> +
>  	mana_rdma_remove(&gc->mana_ib);
>  	mana_remove(&gc->mana, true);

[Severity: High]
This isn't a bug introduced by this patch, since the old GC_IN_SERVICE bit
was ignored by the PM callbacks too, but should mana_gd_suspend() and
mana_gd_resume() (installed as mana_driver.suspend/.resume) get the same
treatment as remove() and shutdown()?

An admitted cycle runs:

mana_serv_reset()
    mana_gd_suspend(pdev, PMSG_SUSPEND);
    msleep(MANA_SERVICE_PERIOD * 1000);
    ret = mana_gd_resume(pdev);

with serv_in_flight set for that whole 10+ second window, and the work sits
on system_wq, which is not WQ_FREEZABLE.  If the guest enters system suspend
or hibernate during that window, pci_pm_suspend() -> pci_legacy_suspend()
calls mana_gd_suspend() a second time on the same gc, and neither PM callback
consults serv_in_flight/serv_removing or calls mana_service_quiesce().

Both threads then reach mana_hwc_destroy_channel(), whose guard is not atomic
with the clearing store:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_destroy_channel() {
	struct hw_channel_context *hwc = gc->hwc.driver_data;

	if (!hwc)
		return;
	...
	kfree(hwc);
	gc->hwc.driver_data = NULL;
	gc->hwc.gdma_context = NULL;

	vfree(gc->cq_table);
	gc->cq_table = NULL;
}

mana_gd_cleanup_device() has the same shape around gc->service_wq:

	if (gc->service_wq) {
		destroy_workqueue(gc->service_wq);
		gc->service_wq = NULL;
	}

Can this interleaving double-free hwc and gc->cq_table, or call
destroy_workqueue() twice on gc->service_wq?  And can mana_gd_resume() from
the service cycle re-arm DMA/MMIO on a device the PM core has already
suspended?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 591fb4191d90d..0eb23aea2e139 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -4060,10 +4060,13 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
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
> +		if (mana_service_probe_done(gc))
> +			mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
>  		return;
>  	}
>  	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);

[Severity: Medium]
When mana_service_probe_done(gc) is false here, is the reset request lost for
good?

mana_probe() arms this work with a MANA_GF_STATS_PERIOD delay, while
serv_probe_done is only set later, at the tail of mana_gd_probe():

	err = mana_rdma_probe(&gc->mana_ib);
	if (err)
		goto service_quiesce;
	...
	rollback = mana_service_probe_complete(gc);

So the handler can run with serv_probe_done still false if mana_rdma_probe()
(register device plus the synchronous mana_ib adev probe and its HWC
requests) takes longer than that delay.

In that window an -ETIMEDOUT from mana_query_gf_stats() takes the new branch,
no cycle is admitted, serv_during_probe is not set so
mana_service_probe_complete() reports no rollback, and the return also skips
the schedule_delayed_work() re-arm.  If the probe then succeeds, is there any
remaining path that retries?  The recovery list in mana_gd_probe() is only
populated when the probe itself fails with -ETIMEDOUT/-EPROTO, and
hwc_timeout_occurred only feeds a warning, so hc_stats would stay zeroed for
the life of the binding and a wedged HWC would never be reset.  Before this
patch the request was unconditional and the resulting reset cycle re-armed
the stats work through mana_probe(resuming=true).

The EQ producer solves the same race by latching under serv_lock:

	admit = gc->serv_probe_done;
	first = !gc->serv_during_probe;
	if (!admit)
		gc->serv_during_probe = true;

Would routing this producer through the same latch-or-admit helper work, or
alternatively keeping the delayed work re-armed so the request is retried
once serv_probe_done is set?
