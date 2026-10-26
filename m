Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998092;
	b=aMn5kF84Hh3/Ort82WojB4KFEEDxTEhIwJCsG8GOuhmn3PjOgqvlqja6ghCtBYvVdOpj
	 tAqSu+T3EnWJsmodLFHBp6IfHxQ66hr6tW+aBmJ8QE7VEwy2o7ohQWT9ntYtDje8Ya/Dp
	 SJOE6L3PXYgSik1F2cKkP4nWT/ZWbNgndRg6rI4cM4E6L1DFSYgK7Ks5yRC5ZA6ll0jif
	 W/dQ2GXnp2tOX6O7XDBjPM18kL+LV5eo+5l8NJhvb+eSLsxjpXDhji0iGud/kE1iaqiS4
	 vuu18OkwwyvDUOl4Trj5p6aQuqzFU2Ni1cSZ9fHR2KIA5iUsfMS8SD41BoA/Q2KK5hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998092;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=DHnsw32ZS2YSTsWFUyV1sd22CaRlWklLLSZS8OzlIlQ=;
	b=kLE2VqmoxXwEbrFg09IeBSswklnVGlkJ/5jjuB3bv9atgDwBhwHINzz1zdOF/P/uPCgx
	 1BHeRPamzoL5HtHimSe9gMNq0QD7xI2DMJqmMTQmbpK1KJ58S8D/NrCoskhlHT5uVrtAE
	 2jYhp33nUi+5QE3Rtlewj3L3nMbF+eTzyfCOGm8cNKBgm167fmPElQbEdBTzMBoiIp63t
	 casbEnumz+QwVKEVxcxT+i3/tPlbS+BhyHsAuVYTgQ/OF7bCWFRDj9WEzPYS5YQIppCm0
	 HZfL8UOIKHdwa15sv0c+MkqjytSwHleBarTXzr0QDMjYEwjFbEo00bKeZWBiAVbhL8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=net-swift.com;
	spf=pass smtp.mailfrom=net-swift.com;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9B606A31A;
	Mon, 26 Oct 2026 07:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz17t1792998012te1a2a9b7
X-QQ-Originating-IP: 9+Upj1tYLCWC+FXQDck1s2OyLNt/mfiQPTnmHRUS+k4=
Received: from smtpclient.apple ( [115.227.112.25])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Oct 2026 15:00:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9234103312813455973
EX-QQ-RecipientCnt: 13
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v6] net: libwx: fix VF PM suspend/resume flow
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <179265975476.3135.4456951664798289210@kernel.org>
Date: Mon, 26 Oct 2026 14:59:59 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 hramamurthy@google.com,
 jacob.e.keller@intel.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4ED66BF6-3475-4933-8BE3-8779745C2ABD@net-swift.com>
References: <20261019060216.38458-1-mengyuanlou@net-swift.com>
 <179265975476.3135.4456951664798289210@kernel.org>
To: netdev-bot+sashiko@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N9UoUGY6/dFVBxdq1eUbo/344CobG4hKsGveF+cNhFDQx+TLE7s7HeMS
	j10cwP3ra3h/62lPFbTGgOxK1JdagSW6FnluWxJsbOkYT4NngUJ44qpbXC52qgccJsSdFAu
	JMmwFrTiWJt878OxaiJ0wiPu93wR7XmCIx3H9yddIRPNt2wzlv2HGxeQWmLl0m0QW+6Sv24
	944fblUXQ+gZv8jcmBAENJWRi1YmkpMQK1QYq6M8hvEfe1DeWEwKk60G0zEOr+6xasKjx42
	Fi85o9Eo6qOO6sN1YXiZUfbGalra0oz2zl2kt5pcjCWpefXJz1s6BAdj12kGpu07WqO+dGH
	FLrMeuwQfmgImwyybuGQULGIOQkTAL7eEtGFMuLQr04PBI5Pv/OH8TesreUr02O4Sh51me4
	XVeHzwQWd3jhJwAoiXjOaAWjXUjHFSgGrrhL+cC47OVfmUsp/uNNg25njhLxxu3wuoD2Lmf
	xu6vGtYoFU6A00hKCHi51A3V+stHaB8T1bJHKYYy2t3gAIrNYHUa78EPtMIk9w8If1a7xOk
	IZxcPCyYI8NTBfPCD3EmefdUnyCoSYehJAB59qm05pQ8oHjw5w7rUbHsS7sbmJXBkMJUVWb
	Raa3J/Gpcb9vCmJwyN6Rt2rSHp3QtcDJFQSL9P3DlZQoLxbRZMh0N6w52rHXSwAaZXW+MxJ
	yss/DaheY+Cp6hXC5nLLo7O89xzKAaPYTCVh3J5O9jGy5qc34IrQCubxv6sVpHtDclpXmnS
	xtesdRJaE9AB0zOOBa7RtSK+SAWX/gHMy9l4fKX3yVZK/9zoUjzSPAg+nvYt5ZI2/0n/k7e
	0DezzFEFygp1h7iRj/v0GBmM0fqGxK4f2kn9+xu5b49IKEW/n7vSBfJGnJPSeY8cqfAROgH
	2xHTQQt2KoqjPUR3njST6RjTqRs15gQaISjt7ORVUNpc+D/NADG/7KGZ+zjzTNb2FKJ6+Sj
	znvGmzWJKcPAvaUjmKHcB6A9bB57N43HKrgcu7iLQnQC6efc8fhlTLQ0unq/ZxDKctVwCo3
	54dt64CKPqFEYHh4YqTIftFAeXfyTDl7dofE+li6JlJ6ri1oCPGRSOC8H2M0ed7BoF9hRpi
	PB0tIOgNOlejArRov15yO4FIrJV3A4InA==
X-QQ-XMRINFO: MSVp+SPm3vtSi80l3HPYHW7Hj/LIb0/BNA==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B410=E6=9C=8822=E6=97=A5 =
17:02=EF=BC=8Cnetdev-bot+sashiko@kernel.org =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 1 (1)
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let =
patchwork
> know by including "pw-bot: cr" as a separate line at the end of your =
reply
> (one such reply per series is enough).
>=20
> - [High] net: libwx: race between wxvf_remove() and =
wxvf_reopen_subtask()
> - [Low] The v5 changelog says "Schedule the reopen subtask immediately =
on
>  resume; keep the service timer to retry if the PF is not ready."=E2=80=A6=

>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch =
adds
>  a new caller that depends on it.
> - [Low] This problem wasn't introduced by this patch, but VF teardown
>  never frees the coherent interrupt-status block (wx->isb_mem) that=E2=80=
=A6
>=20
> --
>=20
> net: libwx: fix VF PM suspend/resume flow
>=20
> This patch reworks the shared txgbevf/ngbevf PM callbacks. Suspend now
> closes a running VF under RTNL and drains the service timer and work
> before disabling PCI. Resume re-enables PCI and hands the PF readiness
> check, VF reset, interrupt setup and reopen to the service task =
through
> a new WX_FLAG_NEED_REOPEN flag.
>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> index 26de78e9a69ef..e2271e8bffcda 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>=20
> [ ... ]
>=20
>> @@ -34,11 +48,20 @@ int wxvf_resume(struct device *dev_d)
>> {
>> struct pci_dev *pdev =3D to_pci_dev(dev_d);
>> struct wx *wx =3D pci_get_drvdata(pdev);
>> + int err;
>>=20
>> - pci_set_master(pdev);
>> - wx_init_interrupt_scheme(wx);
>> - netif_device_attach(wx->netdev);
>> + err =3D pci_enable_device_mem(pdev);
>> + if (err) {
>> + dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
>> + return err;
>> + }
>>=20
>> + clear_bit(WX_STATE_DISABLED, wx->state);
>> + pci_set_master(pdev);
>> + rtnl_lock();
>> + mod_timer(&wx->service_timer, jiffies + HZ);
>> + set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
>> + rtnl_unlock();
>> return 0;
>> }
>=20
> [Severity: Low]
> The v5 changelog says:
>=20
>  Schedule the reopen subtask immediately on resume; keep the service
>  timer to retry if the PF is not ready.
>=20

This is removed in v6 after test.
And it was not mentioned in the changelog, which is a mistake.

> Does wxvf_resume() actually do that? It sets service_timer to fire at
> jiffies + HZ and sets WX_FLAG_NEED_REOPEN. It does not call
> wx_service_event_schedule() or queue_work().
>=20
> The only place that queues the service work is the timer callback:
>=20
> wx_lib.c:wx_service_timer() {
>    ...
> mod_timer(&wx->service_timer, next_event_offset + jiffies);
>=20
> wx_service_event_schedule(wx);
> }
>=20
> So the first reopen attempt looks like it runs about one second after
> resume.
>=20
> Should wxvf_resume() call wx_service_event_schedule() after setting
> WX_FLAG_NEED_REOPEN, or should the changelog be corrected?



>=20
>> @@ -52,13 +75,15 @@ void wxvf_remove(struct pci_dev *pdev)
>> unregister_netdev(netdev);
>> timer_shutdown_sync(&wx->service_timer);
>> cancel_work_sync(&wx->service_task);
>> + clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
>> kfree(wx->vfinfo);
>> kfree(wx->rss_key);
>> kfree(wx->mac_table);
>> wx_clear_interrupt_scheme(wx);
>> pci_release_selected_regions(pdev,
>>     pci_select_bars(pdev, IORESOURCE_MEM));
>> - pci_disable_device(pdev);
>> + if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
>> + pci_disable_device(pdev);
>> }
>=20
> [Severity: High]
> Can wxvf_remove() race with a reopen that is still pending after
> resume?
>=20
> After wxvf_resume(), WX_FLAG_NEED_REOPEN is set, service_timer is
> armed, and WX_STATE_RES_FREED is still set from wxvf_suspend(). The VF
> can be unbound before wxvf_reopen_subtask() has completed. That window
> includes the first second after resume, and any period where the PF
> ping or wx_reset_vf() keeps failing and the subtask keeps retrying. In
> that case wxvf_remove() calls unregister_netdev() before it shuts down
> the timer or cancels the work.
>=20
> If the interface was up, unregister_netdev() reaches wxvf_close(),
> which returns early because WX_STATE_RES_FREED is already set. If the
> interface was down, wxvf_close() is not called at all. Either way,
> nothing clears WX_FLAG_NEED_REOPEN and nothing sets
> WX_STATE_DISABLED. WX_STATE_DISABLED is only set at the very end of
> wxvf_remove().
>=20
> Once unregister_netdev() drops RTNL, the timer can still queue the
> service task. wx_service_event_schedule() now lets it through because
> WX_FLAG_NEED_REOPEN is set. An already queued work can also run while
> wxvf_remove() waits in cancel_work_sync(). The guard in
> wxvf_reopen_subtask() passes, so it proceeds against a netdev that has
> already been unregistered:
>=20
>  wxvf_reopen_subtask()
>    wx_mbx_write_and_read_reply()    /* PF mailbox traffic */
>    wx_reset_vf()                    /* VF reset */
>    wx_init_interrupt_scheme()
>      wx_set_interrupt_capability()  /* MSI-X vector allocation */
>      wx_alloc_q_vectors()           /* netif_napi_add() */
>    netif_device_attach()
>=20
> wx_clear_interrupt_scheme() later in wxvf_remove() frees those
> q_vectors again. Even so, adding NAPI instances to a netdev after
> unregister_netdevice() has torn it down does not look safe. Neither
> does resetting the VF over the mailbox and allocating IRQ vectors in
> the middle of remove.
>=20
> Should wxvf_remove() quiesce the service machinery before
> unregister_netdev()? For example, it could clear WX_FLAG_NEED_REOPEN =
or
> mark the device as being removed, then call timer_shutdown_sync() and
> cancel_work_sync() first. That is similar to how ixgbevf_remove() sets
> __IXGBEVF_REMOVING and cancels service_task before
> unregister_netdev(). Alternatively, should wxvf_reopen_subtask() =
refuse
> to run once the netdev is no longer registered?
>=20
> [Severity: Low]
> This isn't a regression from this patch, but does the VF teardown path
> leak wx->isb_mem?
>=20
> wxvf_open()->wx_setup_resources()->wx_setup_isb_resources() allocates =
it
> with dma_alloc_coherent(), which is not devm-managed:
>=20
> wx->isb_mem =3D dma_alloc_coherent(&pdev->dev,
> sizeof(u32) * 4,
> &wx->isb_dma,
> GFP_KERNEL);
>=20
> wxvf_close() frees only the IRQs and the RX/TX rings. wxvf_remove() =
never
> calls wx_free_isb_resources(). That function is called only from
> ngbe_main.c and txgbe_main.c.
>=20
> wx_setup_isb_resources() returns early when isb_mem is already set, so
> repeated open/resume cycles do not leak more. Even so, the 16-byte
> coherent buffer seems to be left behind on every VF unbind if the
> interface was opened at least once.
>=20
> [ ... ]
>=20
>> +static void wxvf_reopen_subtask(struct wx *wx)
>> +{
>=20
> [ ... ]
>=20
>> + if (wx_init_interrupt_scheme(wx)) {
>> + dev_err(&wx->pdev->dev, "Failed to initialize interrupt scheme\n");
>> + goto hard_failure;
>> + }
>> +
>> + if (netif_running(wx->netdev)) {
>> + if (wxvf_open(wx->netdev))
>> + goto open_failed;
>> + }
>=20
> [Severity: High]
> This is a pre-existing issue, but this patch adds a new caller that
> relies on it. Can the wxvf_open() error unwind free RX buffers and
> descriptor rings while the hardware queues are still enabled?
>=20
> wxvf_open() configures the rings before requesting IRQs:
>=20
> wx_vf_common.c:wxvf_open() {
>    ...
> wx_configure_vf(wx);
>=20
> err =3D wx_request_msix_irqs_vf(wx);
> if (err)
> goto err_free_resources;
>    ...
> err_free_irq:
> wx_free_irq(wx);
> err_free_resources:
> wx_free_resources(wx);
> err_reset:
> wx_reset_vf(wx);
> return err;
> }
>=20
> wx_configure_vf()->wx_configure_rx_vf()->wx_configure_rx_ring_vf()
> enables the queue and posts buffers:
>=20
> rxdctl |=3D WX_VXRXDCTL_ENABLE | WX_VXRXDCTL_VLAN;
> ...
> wx_enable_rx_queue(wx, ring);
> wx_alloc_rx_buffers(ring, wx_desc_unused(ring));
>=20
> Suppose wx_request_msix_irqs_vf() or =
netif_set_real_num_{tx,rx}_queues()
> fails. Then wx_free_resources()->wx_free_rx_resources() returns the
> pages to the page_pool, calls dma_free_coherent() on the descriptor =
ring
> and calls page_pool_destroy().
>=20
> WX_VXRXDCTL_ENABLE is cleared only after that, through
> wx_reset_vf()->wx_reset_hw_vf()->wx_stop_adapter_vf().
>=20
> On this new resume path, wxvf_resume() has already called
> pci_set_master(). A frame that arrives in that window could be DMA'd
> into a recycled page or into freed descriptor memory.
>=20
> The open_failed path here does not quiesce the device either.
> wx_clear_interrupt_scheme() only frees the queue vectors. dev_close()
> does nothing because WX_STATE_RES_FREED is still set from suspend, so
> wxvf_close() returns early. pci_disable_device() then runs after the
> frees.
>=20
> Should the wxvf_open() unwind stop the hardware queues (wx_reset_vf() =
or
> wx_stop_adapter_vf()) before wx_free_resources()? That would match the
> order wxvf_close() uses, where wxvf_down() runs before
> wx_free_resources().
>=20
>> +
>> + clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
>> + if (!netif_running(wx->netdev))
>> + timer_delete_sync(&wx->service_timer);
>> + netif_device_attach(wx->netdev);
>> + rtnl_unlock();
>> + return;
>> +open_failed:
>> +hard_failure:
>=20
> [ ... ]
>=20
>> + timer_delete_sync(&wx->service_timer);
>> + wx_clear_interrupt_scheme(wx);
>> + clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
>> + set_bit(WX_STATE_DOWN, wx->state);
>> +
>> + if (netif_running(wx->netdev))
>> + dev_close(wx->netdev);
>> +
>> + rtnl_unlock();
>> + if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
>> + pci_disable_device(wx->pdev);
>> + dev_err(&wx->pdev->dev, "Failed to fully resume device\n");
>> }
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019060216.38458-1=
-mengyuanlou%40net-swift.com
>=20
>=20

