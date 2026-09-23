Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08463546C8;
	Wed, 23 Sep 2026 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145786; cv=none; b=akR6c9pGcO3wzhY+8ksyWhXm0/OEvV4+rSGUCc52erFj/nIfU8eeygCDSnuCQfw1wqteKn9SgKfq+nMhlsY2VeMw/4REsBg87ug03XQNxUtIJUE4evmAFaBlvpEDrOZfnyqVpqd/w7qBdwcIpZkJIODiBstvFuRpxc72ahxugmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145786; c=relaxed/simple;
	bh=phfjwCDGsiKVmGSZKI1mGtXLs0G7Y+WZWBvquSg+j/0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/zEmNu92tfX4+vbXQN2wfdCuYavr3PLPZm487SvSRJm8e7kDJE4u1gH2cLXgKa0QWVhqtI5ejc36n1upq5U9NZWhDptkFQviAei6Mq6f5mb7a/NSg2dm0bcrGVObDHegKe+xyieX67jKblwjrCsKkL0EbBq42pQd90NT6ZBJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2zDkzil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2zDkzil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96061F000FF;
	Wed, 23 Sep 2026 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790145780;
	bh=JpJUkbdqflJFtc5l5vjcMmpvXN2qmIgs1NCpcKAB7J8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d2zDkzilhuGh2A6Aaza3bUhWyFOMIY+E70zhsmiEKRxjKSPbBbvzcesVXbpLq7Pnu
	 hdvrRAxI/00vDQQcRIZkU4fUTDKmnN7/6IiG5UcUNpnnZfG6F5BUVUUa63d5gMieEa
	 0sGly0HvjfObSnWxtLPxe3ZVZltlsxMuHfaDTC8uNIsqoWht4U529bsWvwoppFaLDD
	 bAN/hnF81Ruper5iglQ2POLmQPhrzEvnCpx2dyAVpAtszKlM0Isufzq8550SKOkAfv
	 KhzZZ7Ej4MnrYlRFy2+ukCKH9OhC4CGSreNxcWsaeqSoj4r82/W7NsnmA7M0sKEHtZ
	 Hb662nasIyWqw==
Subject: Re: [PATCH v2 1/2] net: ena: fix PHC cleanup on probe failure
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: akiyano@amazon.com, darinzon@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ioana.ciornei@nxp.com, ekffu200098@gmail.com, dawei.feng@seu.edu.cn,
 amitbern@amazon.com, netanel@annapurnalabs.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 23 Sep 2026 06:42:59 +0000
Message-ID: <179014577949.2160803.8278125695896398851@kernel.org>
In-Reply-To: <20260921154202.471662-2-lgs201920130244@gmail.com>
References: <20260921154202.471662-2-lgs201920130244@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The bug the commit message describes is not reachable: on
  every `ena_probe()` error path there is nothing for the newly added…

Pre-existing issues:
- [High] Use-after-free of `phc_info` (vfree()d vmalloc memory) that the
  PTP class driver still references, because `ena_phc_destroy()` ->…
- [Low] Pre-existing leak of the coherent DMA buffer allocated by
  `ena_com_mmio_reg_read_request_init()` on `ena_probe()` failure: at…

--

net: ena: fix PHC cleanup on probe failure

This adds a call to ena_phc_destroy() to the err_device_destroy label in
ena_probe(), so that the PHC is torn down before ena_phc_free() frees the
PHC private data on a probe failure after ena_device_init() succeeded.

> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index ea89619039d89..5f0864d16dd3c 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -4122,6 +4122,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  err_device_destroy:
>  	ena_com_delete_host_info(ena_dev);
>  	ena_com_admin_destroy(ena_dev);
> +	ena_phc_destroy(adapter);

[Severity: Medium]
Is there actually anything for this new call to destroy on the probe error
paths?

The commit message says:

  "if probe fails after ena_device_init() succeeds, the error path reaches
   ena_phc_free() without unregistering the PTP clock or destroying the
   device PHC resources."

Following the probe-time flow, ena_phc_init() appears to bail out before
either ena_com_phc_init() or ptp_clock_register() runs:

drivers/net/ethernet/amazon/ena/ena_phc.c:ena_phc_init() {
	/* Validate PHC feature is enabled by the kernel */
	if (!ena_phc_is_enabled(adapter)) {
		netdev_dbg(netdev, "PHC feature is not enabled by the kernel\n");
		goto err_ena_com_phc_init;
	}
	...
}

ena_phc_alloc() uses vzalloc(), so phc_info->enabled starts false, and
ena_devlink_configure_params() seeds the DRIVERINIT enable_phc value from
that same state:

drivers/net/ethernet/amazon/ena/ena_devlink.c:ena_devlink_configure_params() {
	value.vbool = ena_phc_is_enabled(adapter);
	devl_param_driverinit_value_set(devlink,
					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
					&value);
}

ena_device_init() reads it back through ena_devlink_params_get(), which
calls ena_phc_enable(adapter, false).  The only way to get a true value is
userspace via devlink, and devl_register() happens at the end of a
successful ena_probe(); later devlink reloads go through
ena_restore_device(), not ena_probe().

So on the error path ena_phc_is_active() is false (clock is NULL) and
ena_com_phc_destroy() returns immediately:

drivers/net/ethernet/amazon/ena/ena_com.c:ena_com_phc_destroy() {
	/* In case PHC is not supported by the device, silently exiting */
	if (!phc->virt_addr)
		return;
	...
}

If that reading is right, both halves of the added call are no-ops here.
Would it make sense to drop the Fixes: e0ea34158ee8 and
Cc: stable@vger.kernel.org tags and describe this as a consistency cleanup
instead, or to include the sequence that actually leaves a registered PTP
clock behind on a probe failure?

[Severity: High]
This isn't a bug introduced by this patch, but does ena_phc_destroy() give
the caller what the commit message assumes, namely a guaranteed unregister
before the private data is freed?

ena_phc_unregister() skips ptp_clock_unregister() whenever
ENA_FLAG_TRIGGER_RESET is set:

drivers/net/ethernet/amazon/ena/ena_phc.c:ena_phc_unregister() {
	/* During reset flow, PHC must stay registered
	 * to keep kernel's PHC index
	 */
	if (ena_phc_is_active(adapter) &&
	    !test_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags)) {
		ptp_clock_unregister(phc_info->clock);
		phc_info->clock = NULL;
	}
}

In ena_destroy_device() the flag is cleared only after ena_phc_destroy()
has already run, and ena_reset_device() (ena_netdev.h) sets that flag
lock-free from NAPI/xmit/timer contexts.

One sequence on unbind/rmmod: ena_timer_service() queues reset_task with
the flag already set, then __ena_shutoff() does

	timer_delete_sync(&adapter->timer_service);
	cancel_work_sync(&adapter->reset_task);
	...
	ena_destroy_device(adapter, true);

	ena_phc_free(adapter);

cancel_work_sync() cancels the queued work but nothing clears
ENA_FLAG_TRIGGER_RESET, so ena_phc_destroy() skips the unregister and
ena_phc_free() then vfree()s phc_info with the clock still registered.

A second sequence: a FW reset where ena_destroy_device(adapter, false)
skipped the unregister, then ena_device_init() fails in
ena_restore_device() and the err: label clears ENA_FLAG_DEVICE_RUNNING:

drivers/net/ethernet/amazon/ena/ena_netdev.c:ena_restore_device() {
err:
	clear_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
	...
}

A later unbind then hits the early return in ena_destroy_device():

	if (!test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
		return 0;

which never reaches ena_phc_destroy() at all, and ena_phc_free() frees
phc_info anyway.

In both cases /dev/ptpN stays alive with ptp_clock_info ops pointing into
freed vmalloc memory, and any clock_gettime or PTP_SYS_OFFSET on it enters

drivers/net/ethernet/amazon/ena/ena_phc.c:ena_phc_gettimex64() {
	struct ena_phc_info *phc_info =
		container_of(clock_info, struct ena_phc_info, clock_info);
	...
	spin_lock_irqsave(&phc_info->lock, flags);
	rc = ena_com_phc_get_timestamp(phc_info->adapter->ena_dev, &timestamp_nsec);
}

Can this dereference freed memory?  Should the teardown paths distinguish
reset-preserving teardown from final teardown, for example a forced
unregister variant used by ena_phc_free()/__ena_shutoff(), rather than
adding another call to the reset-conditional helper?

[Severity: Low]
This is a pre-existing issue, but does this cleanup chain leak the coherent
DMA buffer allocated by ena_com_mmio_reg_read_request_init()?

The err_device_destroy label goes ena_com_delete_host_info() ->
ena_com_admin_destroy() -> ena_phc_destroy() -> ena_devlink_free() -> ... ->
vfree(ena_dev) -> pci_disable_device() with no
ena_com_mmio_reg_read_request_destroy(), while both peer teardown sites do
call it:

drivers/net/ethernet/amazon/ena/ena_netdev.c:ena_device_init() {
err_mmio_read_less:
	ena_com_mmio_reg_read_request_destroy(ena_dev);
	...
}

drivers/net/ethernet/amazon/ena/ena_netdev.c:ena_destroy_device() {
	ena_phc_destroy(adapter);

	ena_com_mmio_reg_read_request_destroy(ena_dev);
	...
}

so mmio_read->read_resp stays allocated and the device's MMIO_RESP_LO/HI
registers still hold the freed DMA address.

Note this is addressed by the following patch in the same series,
"net: ena: fix MMIO read buffer leak on probe failure", which inserts
ena_com_mmio_reg_read_request_destroy(ena_dev) directly after the line
added here, so no separate action looks necessary for the series as a whole.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921154202.471662-1-lgs201920130244%40gmail.com
