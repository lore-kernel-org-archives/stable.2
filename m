Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659756;
	b=yBGMPIdzeGPh6mf/X84VTq/xZt2yP20NK5xdORcTIcyrg45k8hoTHj19q1eZAax4bXvj
	 ruQ6o+y3xDFn1aZra/8+wqL9+31zJ1Nr83fbC7Yt9QgAtkeAEKxszTvdvji88rq4m52xA
	 92p//V+IfczJ8ccHwQv0TslIHwvydJTirrR3AZt1utWTdY34QCjdlbrTr1atK0gRpioUd
	 ISh+Li/bmx1kJEhzClgi+HFHcRck9yHk9HjcVKJ7Ja69dMjlvN5ikZFPFhpDMTC4Kh48f
	 q5ubzGmYjWPHRGUeVz9Gb9ROE8G2196CgJM7qp70SdigY/VcKCDZqJh03LIlrhEdtDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659756;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TiU/3HHI+zKSaWPGL9CUf9cBsW6huUnx77JNbpRWtlw=;
	b=x5JY7V8lIb/KvSLpyUyEbADyrV+ayvF4wzxAWxc8o9DsEDMbJ2jYiIihe0DqIHr3RR3i
	 dz6PQtAK2d2UCg0T+Mv8UHqEtohfqQazXKcIH6e71VTY3T6p4x6Vl/aWJNuaxCXDXeJDH
	 xrHGDswmLDwHLf9UzWBS8BFXlM3HQiEt0TyTKREhrFMBoaXUp51WW9eQr2p11R78FiNUL
	 zckR+MS928ZqbULxJ8azWZ5jHl1Zr+MSh/2GHxk7pySs96w+7j9dQXPgLM0KbUAYh71FX
	 95YqZpDwlMyxWlETfULd3DXjTiSBTbYXPgG34fhskPvhoH2kYDzOfZfIHlgsLpvkmKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAkauIGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E609606A319;
	Thu, 22 Oct 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAkauIGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320301F000C1;
	Thu, 22 Oct 2026 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792659755;
	bh=TiU/3HHI+zKSaWPGL9CUf9cBsW6huUnx77JNbpRWtlw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hAkauIGDA5tjLLNpie56S7doG4pz3mjatVrHYt+a9MxBoIRjj6sUT2gRqq4u51fFN
	 1Q6A1a650t7iKtgq8oST8Kpn9QKXge/5uZctsYINlWJ9S1q/SrgtTbJg0K1HAFp5Km
	 lp0a3O6ngPRolJj8X3kQs7T79zaXRCfnXhFqDCTCSKMK7W69FiSPeoXtYM7jGddGLH
	 YYm1VFHCbNIZwSInHCztZyo0gH0evZmqc7/4RWAEvPRdHYNv2Vtwt9SBxBRGCyFrDJ
	 6u/P5v1jVUt239tiM2ByL9nL7Adj8oMIEHb/TRq2R999pAn/yWGdmDCooPea4Q88cd
	 HVc//Mf8S7CVg==
Subject: Re: [PATCH net v6] net: libwx: fix VF PM suspend/resume flow
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 jacob.e.keller@intel.com, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 09:02:34 +0000
Message-ID: <179265975476.3135.4456951664798289210@kernel.org>
In-Reply-To: <20261019060216.38458-1-mengyuanlou@net-swift.com>
References: <20261019060216.38458-1-mengyuanlou@net-swift.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: libwx: race between wxvf_remove() and wxvf_reopen_subtask()
- [Low] The v5 changelog says "Schedule the reopen subtask immediately on
  resume; keep the service timer to retry if the PF is not ready."…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  a new caller that depends on it.
- [Low] This problem wasn't introduced by this patch, but VF teardown
  never frees the coherent interrupt-status block (wx->isb_mem) that…

--

net: libwx: fix VF PM suspend/resume flow

This patch reworks the shared txgbevf/ngbevf PM callbacks. Suspend now
closes a running VF under RTNL and drains the service timer and work
before disabling PCI. Resume re-enables PCI and hands the PF readiness
check, VF reset, interrupt setup and reopen to the service task through
a new WX_FLAG_NEED_REOPEN flag.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69ef..e2271e8bffcda 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c

[ ... ]

> @@ -34,11 +48,20 @@ int wxvf_resume(struct device *dev_d)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
> +	int err;
>  
> -	pci_set_master(pdev);
> -	wx_init_interrupt_scheme(wx);
> -	netif_device_attach(wx->netdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
> +		return err;
> +	}
>  
> +	clear_bit(WX_STATE_DISABLED, wx->state);
> +	pci_set_master(pdev);
> +	rtnl_lock();
> +	mod_timer(&wx->service_timer, jiffies + HZ);
> +	set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	rtnl_unlock();
>  	return 0;
>  }

[Severity: Low]
The v5 changelog says:

  Schedule the reopen subtask immediately on resume; keep the service
  timer to retry if the PF is not ready.

Does wxvf_resume() actually do that? It sets service_timer to fire at
jiffies + HZ and sets WX_FLAG_NEED_REOPEN. It does not call
wx_service_event_schedule() or queue_work().

The only place that queues the service work is the timer callback:

wx_lib.c:wx_service_timer() {
    ...
	mod_timer(&wx->service_timer, next_event_offset + jiffies);

	wx_service_event_schedule(wx);
}

So the first reopen attempt looks like it runs about one second after
resume.

Should wxvf_resume() call wx_service_event_schedule() after setting
WX_FLAG_NEED_REOPEN, or should the changelog be corrected?

> @@ -52,13 +75,15 @@ void wxvf_remove(struct pci_dev *pdev)
>  	unregister_netdev(netdev);
>  	timer_shutdown_sync(&wx->service_timer);
>  	cancel_work_sync(&wx->service_task);
> +	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
>  	kfree(wx->vfinfo);
>  	kfree(wx->rss_key);
>  	kfree(wx->mac_table);
>  	wx_clear_interrupt_scheme(wx);
>  	pci_release_selected_regions(pdev,
>  				     pci_select_bars(pdev, IORESOURCE_MEM));
> -	pci_disable_device(pdev);
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
>  }

[Severity: High]
Can wxvf_remove() race with a reopen that is still pending after
resume?

After wxvf_resume(), WX_FLAG_NEED_REOPEN is set, service_timer is
armed, and WX_STATE_RES_FREED is still set from wxvf_suspend(). The VF
can be unbound before wxvf_reopen_subtask() has completed. That window
includes the first second after resume, and any period where the PF
ping or wx_reset_vf() keeps failing and the subtask keeps retrying. In
that case wxvf_remove() calls unregister_netdev() before it shuts down
the timer or cancels the work.

If the interface was up, unregister_netdev() reaches wxvf_close(),
which returns early because WX_STATE_RES_FREED is already set. If the
interface was down, wxvf_close() is not called at all. Either way,
nothing clears WX_FLAG_NEED_REOPEN and nothing sets
WX_STATE_DISABLED. WX_STATE_DISABLED is only set at the very end of
wxvf_remove().

Once unregister_netdev() drops RTNL, the timer can still queue the
service task. wx_service_event_schedule() now lets it through because
WX_FLAG_NEED_REOPEN is set. An already queued work can also run while
wxvf_remove() waits in cancel_work_sync(). The guard in
wxvf_reopen_subtask() passes, so it proceeds against a netdev that has
already been unregistered:

  wxvf_reopen_subtask()
    wx_mbx_write_and_read_reply()    /* PF mailbox traffic */
    wx_reset_vf()                    /* VF reset */
    wx_init_interrupt_scheme()
      wx_set_interrupt_capability()  /* MSI-X vector allocation */
      wx_alloc_q_vectors()           /* netif_napi_add() */
    netif_device_attach()

wx_clear_interrupt_scheme() later in wxvf_remove() frees those
q_vectors again. Even so, adding NAPI instances to a netdev after
unregister_netdevice() has torn it down does not look safe. Neither
does resetting the VF over the mailbox and allocating IRQ vectors in
the middle of remove.

Should wxvf_remove() quiesce the service machinery before
unregister_netdev()? For example, it could clear WX_FLAG_NEED_REOPEN or
mark the device as being removed, then call timer_shutdown_sync() and
cancel_work_sync() first. That is similar to how ixgbevf_remove() sets
__IXGBEVF_REMOVING and cancels service_task before
unregister_netdev(). Alternatively, should wxvf_reopen_subtask() refuse
to run once the netdev is no longer registered?

[Severity: Low]
This isn't a regression from this patch, but does the VF teardown path
leak wx->isb_mem?

wxvf_open()->wx_setup_resources()->wx_setup_isb_resources() allocates it
with dma_alloc_coherent(), which is not devm-managed:

	wx->isb_mem = dma_alloc_coherent(&pdev->dev,
					 sizeof(u32) * 4,
					 &wx->isb_dma,
					 GFP_KERNEL);

wxvf_close() frees only the IRQs and the RX/TX rings. wxvf_remove() never
calls wx_free_isb_resources(). That function is called only from
ngbe_main.c and txgbe_main.c.

wx_setup_isb_resources() returns early when isb_mem is already set, so
repeated open/resume cycles do not leak more. Even so, the 16-byte
coherent buffer seems to be left behind on every VF unbind if the
interface was opened at least once.

[ ... ]

> +static void wxvf_reopen_subtask(struct wx *wx)
> +{

[ ... ]

> +	if (wx_init_interrupt_scheme(wx)) {
> +		dev_err(&wx->pdev->dev, "Failed to initialize interrupt scheme\n");
> +		goto hard_failure;
> +	}
> +
> +	if (netif_running(wx->netdev)) {
> +		if (wxvf_open(wx->netdev))
> +			goto open_failed;
> +	}

[Severity: High]
This is a pre-existing issue, but this patch adds a new caller that
relies on it. Can the wxvf_open() error unwind free RX buffers and
descriptor rings while the hardware queues are still enabled?

wxvf_open() configures the rings before requesting IRQs:

wx_vf_common.c:wxvf_open() {
    ...
	wx_configure_vf(wx);

	err = wx_request_msix_irqs_vf(wx);
	if (err)
		goto err_free_resources;
    ...
err_free_irq:
	wx_free_irq(wx);
err_free_resources:
	wx_free_resources(wx);
err_reset:
	wx_reset_vf(wx);
	return err;
}

wx_configure_vf()->wx_configure_rx_vf()->wx_configure_rx_ring_vf()
enables the queue and posts buffers:

	rxdctl |= WX_VXRXDCTL_ENABLE | WX_VXRXDCTL_VLAN;
	...
	wx_enable_rx_queue(wx, ring);
	wx_alloc_rx_buffers(ring, wx_desc_unused(ring));

Suppose wx_request_msix_irqs_vf() or netif_set_real_num_{tx,rx}_queues()
fails. Then wx_free_resources()->wx_free_rx_resources() returns the
pages to the page_pool, calls dma_free_coherent() on the descriptor ring
and calls page_pool_destroy().

WX_VXRXDCTL_ENABLE is cleared only after that, through
wx_reset_vf()->wx_reset_hw_vf()->wx_stop_adapter_vf().

On this new resume path, wxvf_resume() has already called
pci_set_master(). A frame that arrives in that window could be DMA'd
into a recycled page or into freed descriptor memory.

The open_failed path here does not quiesce the device either.
wx_clear_interrupt_scheme() only frees the queue vectors. dev_close()
does nothing because WX_STATE_RES_FREED is still set from suspend, so
wxvf_close() returns early. pci_disable_device() then runs after the
frees.

Should the wxvf_open() unwind stop the hardware queues (wx_reset_vf() or
wx_stop_adapter_vf()) before wx_free_resources()? That would match the
order wxvf_close() uses, where wxvf_down() runs before
wx_free_resources().

> +
> +	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	if (!netif_running(wx->netdev))
> +		timer_delete_sync(&wx->service_timer);
> +	netif_device_attach(wx->netdev);
> +	rtnl_unlock();
> +	return;
> +open_failed:
> +hard_failure:

[ ... ]

> +	timer_delete_sync(&wx->service_timer);
> +	wx_clear_interrupt_scheme(wx);
> +	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	set_bit(WX_STATE_DOWN, wx->state);
> +
> +	if (netif_running(wx->netdev))
> +		dev_close(wx->netdev);
> +
> +	rtnl_unlock();
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(wx->pdev);
> +	dev_err(&wx->pdev->dev, "Failed to fully resume device\n");
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019060216.38458-1-mengyuanlou%40net-swift.com
