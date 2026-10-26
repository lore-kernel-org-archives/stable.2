Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027774;
	b=FTpt7l2iYIJ9YI0xlUfqSlsQxL4sWYDtyRpDVZUmTIP6UCmrvOQyIgxWqNB3trHAYP4+
	 UzOiVQH5cd8Wjyja4p9QjccTkD4CxXArQvVSioJqemuUDW5mMzLWqEDocY4AXZKvFUy2s
	 +A9R4PFYls+MkgUwVDs7zL5Y+Ib3HQPQYP4eWjZdSwWavvfQxBkrpAS+Om2QXVIFMfauI
	 GrmcsoCrW4omQ3QVebUSFXnlTfJWyEAHCBHEMa7htVPW3kUC/LEUiwB8o3ARzKhIulYfa
	 I2J4CnpkcCs1IFpy932UkENF9iSqw9g390QKwAorsvaXRm/JTQuJpqJFBjjYHz3vNMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027774;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WqAL8wt6wFOMrP1r3QXM2nTBuKZ1VNrrsuX87BI0mVs=;
	b=cM+GhkVVkBDsThEEs5EmRI8CWwRj5Vspmk2JfIKUPwIEhsidQxw3cVfBWWnLJ1v7gUBT
	 22F4IMWs5O73mEgAJj0BqOk6t04aQWEQbsz5RLvstmu14yDYH0SISiNllFH8y9jmCvAgy
	 TGLNkXF+8eLzomL9ufC8FKYgXq1BRl1Ov/RmlXgnzWJIVWsCKpZVnx4mW3aWvsr+1Y56p
	 /JZi+h7nIBCja1Rv9JRCnvvVGdOmkT+vxxPRtAn0X8FCFQ1g1TUGkloaT2jWtfKaCG7MI
	 OiFzeGFCAK/7y6YVV6bEy6FU77v4fEnq5MiCnYy1QNEDET8Dz9CDStwIFxvDeKaPcOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYZEJHZp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F56606A31A;
	Mon, 26 Oct 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYZEJHZp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CC71F01825;
	Mon, 26 Oct 2026 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793027773;
	bh=WqAL8wt6wFOMrP1r3QXM2nTBuKZ1VNrrsuX87BI0mVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XYZEJHZpOrp2M+vPXn0Sbd6TtEU8B3Dzxcx06rZf6jZFAe9+jXFYPxFFx3KLFT2Qd
	 gnM14VxzYy4SkapwiL9fXmOvoFq3wAymHfC0eAUylLi9JRBr7UrdMwT/GABYZKvRO6
	 GReelLxC/lJ8PwixnwaSEI2WCIQLgNftmvfO1IGnJtpvSmPLFnGOgtPLlj2L4UFbw1
	 vLbEuBRL+q1Gi3bjJFksZ/oKkbUVgRkhHAHfkFeQ6W3+eOqsNRAXHL7anLtvdZtumI
	 KoAdocwfb/fl20Znmj5OFeQtOtUN63CDq5kUogCBxGr7C2I36stiNQ12QcDLSKQzu1
	 I09FJrUOoVo3g==
Date: Mon, 26 Oct 2026 15:16:08 +0000
From: Simon Horman <horms@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, hramamurthy@google.com, jacob.e.keller@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v6] net: libwx: fix VF PM suspend/resume flow
Message-ID: <20261026151608.GA257209@horms.kernel.org>
References: <20261019060216.38458-1-mengyuanlou@net-swift.com>
 <179265975476.3135.4456951664798289210@kernel.org>
 <4ED66BF6-3475-4933-8BE3-8779745C2ABD@net-swift.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ED66BF6-3475-4933-8BE3-8779745C2ABD@net-swift.com>

On Mon, Oct 26, 2026 at 02:59:59PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2026年10月22日 17:02，netdev-bot+sashiko@kernel.org 写道：
> > 
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1 (1)
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [High] net: libwx: race between wxvf_remove() and wxvf_reopen_subtask()
> > - [Low] The v5 changelog says "Schedule the reopen subtask immediately on
> >  resume; keep the service timer to retry if the PF is not ready."…
> > 
> > Pre-existing issues:
> > - [High] This problem wasn't introduced by this patch, but the patch adds
> >  a new caller that depends on it.
> > - [Low] This problem wasn't introduced by this patch, but VF teardown
> >  never frees the coherent interrupt-status block (wx->isb_mem) that…
> > 
> > --
> > 
> > net: libwx: fix VF PM suspend/resume flow
> > 
> > This patch reworks the shared txgbevf/ngbevf PM callbacks. Suspend now
> > closes a running VF under RTNL and drains the service timer and work
> > before disabling PCI. Resume re-enables PCI and hands the PF readiness
> > check, VF reset, interrupt setup and reopen to the service task through
> > a new WX_FLAG_NEED_REOPEN flag.
> > 
> >> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> >> index 26de78e9a69ef..e2271e8bffcda 100644
> >> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> >> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> > 
> > [ ... ]
> > 
> >> @@ -34,11 +48,20 @@ int wxvf_resume(struct device *dev_d)
> >> {
> >> struct pci_dev *pdev = to_pci_dev(dev_d);
> >> struct wx *wx = pci_get_drvdata(pdev);
> >> + int err;
> >> 
> >> - pci_set_master(pdev);
> >> - wx_init_interrupt_scheme(wx);
> >> - netif_device_attach(wx->netdev);
> >> + err = pci_enable_device_mem(pdev);
> >> + if (err) {
> >> + dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
> >> + return err;
> >> + }
> >> 
> >> + clear_bit(WX_STATE_DISABLED, wx->state);
> >> + pci_set_master(pdev);
> >> + rtnl_lock();
> >> + mod_timer(&wx->service_timer, jiffies + HZ);
> >> + set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> >> + rtnl_unlock();
> >> return 0;
> >> }
> > 
> > [Severity: Low]
> > The v5 changelog says:
> > 
> >  Schedule the reopen subtask immediately on resume; keep the service
> >  timer to retry if the PF is not ready.
> > 
> 
> This is removed in v6 after test.
> And it was not mentioned in the changelog, which is a mistake.

...

> > [Severity: High]
> > Can wxvf_remove() race with a reopen that is still pending after
> > resume?
> > 
> > After wxvf_resume(), WX_FLAG_NEED_REOPEN is set, service_timer is
> > armed, and WX_STATE_RES_FREED is still set from wxvf_suspend(). The VF
> > can be unbound before wxvf_reopen_subtask() has completed. That window
> > includes the first second after resume, and any period where the PF
> > ping or wx_reset_vf() keeps failing and the subtask keeps retrying. In
> > that case wxvf_remove() calls unregister_netdev() before it shuts down
> > the timer or cancels the work.
> > 
> > If the interface was up, unregister_netdev() reaches wxvf_close(),
> > which returns early because WX_STATE_RES_FREED is already set. If the
> > interface was down, wxvf_close() is not called at all. Either way,
> > nothing clears WX_FLAG_NEED_REOPEN and nothing sets
> > WX_STATE_DISABLED. WX_STATE_DISABLED is only set at the very end of
> > wxvf_remove().
> > 
> > Once unregister_netdev() drops RTNL, the timer can still queue the
> > service task. wx_service_event_schedule() now lets it through because
> > WX_FLAG_NEED_REOPEN is set. An already queued work can also run while
> > wxvf_remove() waits in cancel_work_sync(). The guard in
> > wxvf_reopen_subtask() passes, so it proceeds against a netdev that has
> > already been unregistered:
> > 
> >  wxvf_reopen_subtask()
> >    wx_mbx_write_and_read_reply()    /* PF mailbox traffic */
> >    wx_reset_vf()                    /* VF reset */
> >    wx_init_interrupt_scheme()
> >      wx_set_interrupt_capability()  /* MSI-X vector allocation */
> >      wx_alloc_q_vectors()           /* netif_napi_add() */
> >    netif_device_attach()
> > 
> > wx_clear_interrupt_scheme() later in wxvf_remove() frees those
> > q_vectors again. Even so, adding NAPI instances to a netdev after
> > unregister_netdevice() has torn it down does not look safe. Neither
> > does resetting the VF over the mailbox and allocating IRQ vectors in
> > the middle of remove.
> > 
> > Should wxvf_remove() quiesce the service machinery before
> > unregister_netdev()? For example, it could clear WX_FLAG_NEED_REOPEN or
> > mark the device as being removed, then call timer_shutdown_sync() and
> > cancel_work_sync() first. That is similar to how ixgbevf_remove() sets
> > __IXGBEVF_REMOVING and cancels service_task before
> > unregister_netdev(). Alternatively, should wxvf_reopen_subtask() refuse
> > to run once the netdev is no longer registered?
> > 
> > [Severity: Low]
> > This isn't a regression from this patch, but does the VF teardown path
> > leak wx->isb_mem?
> > 
> > wxvf_open()->wx_setup_resources()->wx_setup_isb_resources() allocates it
> > with dma_alloc_coherent(), which is not devm-managed:
> > 
> > wx->isb_mem = dma_alloc_coherent(&pdev->dev,
> > sizeof(u32) * 4,
> > &wx->isb_dma,
> > GFP_KERNEL);
> > 
> > wxvf_close() frees only the IRQs and the RX/TX rings. wxvf_remove() never
> > calls wx_free_isb_resources(). That function is called only from
> > ngbe_main.c and txgbe_main.c.
> > 
> > wx_setup_isb_resources() returns early when isb_mem is already set, so
> > repeated open/resume cycles do not leak more. Even so, the 16-byte
> > coherent buffer seems to be left behind on every VF unbind if the
> > interface was opened at least once.
> > 
> > [ ... ]
> > 
> >> +static void wxvf_reopen_subtask(struct wx *wx)
> >> +{
> > 
> > [ ... ]
> > 
> >> + if (wx_init_interrupt_scheme(wx)) {
> >> + dev_err(&wx->pdev->dev, "Failed to initialize interrupt scheme\n");
> >> + goto hard_failure;
> >> + }
> >> +
> >> + if (netif_running(wx->netdev)) {
> >> + if (wxvf_open(wx->netdev))
> >> + goto open_failed;
> >> + }

Hi Mengyuan,

I apologise if I am missing something obvious.
But could you respond to the High concern above?

...
