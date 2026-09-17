Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD74C10CA;
	Thu, 17 Sep 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666271; cv=none; b=o1gcGoquJTYF7DNMWscwHWpK4MJUjbMRaNTsccAo20Dv5VFGdUjzlp9GnRL6rQEw4UpBDTx950P3Uu5sB1U3xNrffNvXJbPZ562bqRGHbkLMaUD5ziOdjtQxQT2E30OJUuHR/fyWwhDaPSY3CLeogXGZMwG5vzksu/IkoRLLC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666271; c=relaxed/simple;
	bh=TYcvdafd8HgHwSOKIsLyAciRDxl8Fs3Zzj6+2B2/nTY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hcw9/M3jwbbuakTOe6/nVN/M1BUrIhBzfPY8/VWtN2x02wqeg+3oVor54Eln3Q6MtYkalCQyW45DL73r/+ZkmyjK3eJFOb/UWN6ZEM403EC9iJjDUuWndbOpR5ef3N8jkZOaa778h7vNgbwnTpTifhvx8mMA9mNdUv9201puLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4iK4azk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4iK4azk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E5B1F000FF;
	Thu, 17 Sep 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789666269;
	bh=ITKt7qSYJh0Ams1mBnoZPY+2GMW0TGf7MafFP4Osdns=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G4iK4azkT45+GiEIl1+afwL0bCkoD/DWlI24v7uOLcQMBignq7I66Z7OMsVY/DeKx
	 ebWQVIo39HY/GS1S3lpbu7o/ywkjb/cg7PqpOXtRKrQtdcxaNR3UQ+0IdrXdOssrrk
	 T7W29cPoVFqDio/1Y85kTp7eT/SKpjG6rqs9o45GPnb6cSwcMZerZI5nafFQbhlSEO
	 bq7bFhw6yyay0IF4zxoQ1BOaeMgsYKC9TkzY8/60Iao8D9iqcPTfcZuqIPEhtucGQE
	 Y86XGNc+4l/gqlkPCH0wjz9vlPUsA/058k7E4O0SflW4Ui70OuM37ejfLO0gFCMOOC
	 jq6pE9IOMAvtQ==
Subject: Re: [PATCH] net: ena: fix PHC cleanup on probe failure
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: akiyano@amazon.com, darinzon@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ekffu200098@gmail.com, niklas.soderlund+renesas@ragnatech.se,
 dawei.feng@seu.edu.cn, amitbern@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 17:31:08 +0000
Message-ID: <178966626828.22033.11993324516511047736@kernel.org>
In-Reply-To: <20260916022954.2690322-1-lgs201920130244@gmail.com>
References: <20260916022954.2690322-1-lgs201920130244@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

- [Medium] ena_probe() error unwind still omits
  ena_com_mmio_reg_read_request_destroy(), leaking the DMA-coherent…
- [Medium] The commit message's premise is not reachable: during an
  initial ena_probe(), PHC is always disabled, so no PTP clock and no…

Pre-existing issues:
- [Low] ena_probe()'s err_worker_destroy label calls
  timer_delete(&adapter->timer_service)…

--

net: ena: fix PHC cleanup on probe failure

This adds a call to ena_phc_destroy() to the err_device_destroy label in
ena_probe(), so the probe error path mirrors the ena_destroy_device()
teardown before ena_phc_free() runs.

A couple of questions about the changelog and the error path below.

>     The normal removal path calls ena_phc_destroy() through
>     ena_destroy_device() before ena_phc_free(). However, if probe fails
>     after ena_device_init() succeeds, the error path reaches ena_phc_free()
>     without unregistering the PTP clock or destroying the device PHC
>     resources.

[Severity: Medium]
Is there actually a registered PTP clock or allocated device PHC resource
at that point during an initial probe?

Following the state that PHC has when ena_device_init() returns 0:

ena_phc_alloc() vzalloc()s phc_info, so phc_info->enabled is false, and
ena_devlink_configure_params() seeds the driverinit ENABLE_PHC value from
that state:

	value.vbool = ena_phc_is_enabled(adapter);
	devl_param_driverinit_value_set(devlink,
					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
					&value);

ena_device_init() -> ena_devlink_params_get() then reads that value back
and calls ena_phc_enable(adapter, false), so ena_phc_init() takes:

	if (!ena_phc_is_enabled(adapter)) {
		netdev_dbg(netdev, "PHC feature is not enabled by the kernel\n");
		goto err_ena_com_phc_init;
	}

which skips ena_com_phc_init() (phc->virt_addr stays NULL) and
ena_phc_register() (phc_info->clock stays NULL).

Userspace cannot flip the param earlier either, since devlink netlink
lookup rejects instances that are not registered yet
(devlink_get_from_attrs_lock() requires devl_is_registered()), and ENA
only calls ena_devlink_register() at the successful end of ena_probe().

So on every path that can reach the new call, ena_phc_unregister()
returns immediately via ena_phc_is_active() and ena_com_phc_destroy()
returns immediately on !phc->virt_addr. The only path where PHC can
really be active on failure is ena_restore_device(), which already calls
ena_phc_destroy().

Given that, are the Fixes: tag and Cc: stable warranted here, or would
describing this as hardening for symmetry be more accurate?

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
Does this label still leak the mmio read-less response buffer allocated
by ena_com_mmio_reg_read_request_init()?

ena_device_init() calls ena_com_mmio_reg_read_request_init()
unconditionally, which does:

	mmio_read->read_resp = dma_alloc_coherent(ena_dev->dmadev, sizeof(*mmio_read->read_resp),
						  &mmio_read->read_resp_dma_addr, GFP_KERNEL);

and programs that address into the device via
ena_com_mmio_reg_read_request_write_dev_addr(). It is only released
inside ena_device_init() itself, at its err_mmio_read_less label.

The teardown sequence this patch is modelled on does three steps:

drivers/net/ethernet/amazon/ena/ena_netdev.c:ena_destroy_device() {
	...
	ena_com_admin_destroy(ena_dev);

	ena_phc_destroy(adapter);

	ena_com_mmio_reg_read_request_destroy(ena_dev);
	...
}

and ena_restore_device()'s error path pairs them the same way:

	ena_phc_destroy(adapter);
	ena_com_mmio_reg_read_request_destroy(ena_dev);

The new code adds the middle step but not the last one, so once
ena_device_init() has returned 0, any later probe failure walks
err_device_destroy -> ena_devlink_free() ->
ena_com_delete_customer_metrics_buffer() -> ena_phc_free() ->
free_netdev() -> vfree(ena_dev) with mmio_read.read_resp still
allocated. After vfree(ena_dev) the pointer and DMA handle are gone, and
the device's ENA_REGS_MMIO_RESP_LO/HI registers keep the stale address,
since only ena_com_mmio_reg_read_request_destroy() zeroes them:

	writel(0x0, ena_dev->reg_bar + ENA_REGS_MMIO_RESP_LO_OFF);
	writel(0x0, ena_dev->reg_bar + ENA_REGS_MMIO_RESP_HI_OFF);

	dma_free_coherent(ena_dev->dmadev, sizeof(*mmio_read->read_resp), mmio_read->read_resp,
			  mmio_read->read_resp_dma_addr);

Reachable failures include max_num_io_queues == 0 (which also does no
ena_com_dev_reset()), ena_com_init_interrupt_moderation() failure,
ena_enable_msix_and_set_admin_interrupts() failure,
ena_rss_init_default() failure and register_netdev() failure.

Should ena_com_mmio_reg_read_request_destroy(ena_dev) be added right
after the new ena_phc_destroy(adapter) here?

>  ena_devlink_destroy:
>  	ena_devlink_free(devlink);
>  err_metrics_destroy:
>  	ena_com_delete_customer_metrics_buffer(ena_dev);

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
while looking at the labels just above the changed one: does
err_worker_destroy call timer_delete() on an uninitialized timer?

	err_worker_destroy:
		timer_delete(&adapter->timer_service);

timer_service is only ever set up after register_netdev() succeeds:

	timer_setup(&adapter->timer_service, ena_timer_service, 0);
	mod_timer(&adapter->timer_service, round_jiffies(jiffies + HZ));

and there is no failure goto after that point, so every path that lands
on err_worker_destroy (MSI-X setup failure, ena_rss_init_default()
failure falling through err_free_msix, register_netdev() failure falling
through err_rss) runs before timer_setup(). The memory is the zeroed
netdev private area from alloc_etherdev_mq().

With CONFIG_DEBUG_OBJECTS_TIMERS, __timer_delete() starts with
debug_assert_init(timer), and timer_is_static_object() requires
entry.next == TIMER_ENTRY_STATIC while the zeroed timer has
entry.next == NULL, so debug_print_object() issues an "assert_init"
warning before timer_fixup_assert_init() installs a stub. Without that
option, timer_pending() is false and the call is a no-op, so this only
shows up as a splat on debug kernels during an already-failing probe.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916022954.2690322-1-lgs201920130244%40gmail.com
