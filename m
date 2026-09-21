Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF1342510;
	Mon, 21 Sep 2026 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982335; cv=none; b=BAf3Ww4dOZ4WXtI3pDQRGoJ+5AqCfAh02fhgPK1NJ9VYX+3yWuZZUx7bLB3cvkW4BUKlRlTHBuYWcb29uxZvmO7mM/RQUIXgMxXHjdmvvx9DfsviQGjDf5xVynY0EyCZBmCWU1GXQ4A35Nw4fH2mbtFL0ZkR5TUkvTb3W8TCtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982335; c=relaxed/simple;
	bh=N+OY8rFnMbZOtOwYcFsNJ9QamJ09+L8WO+FMPL7VEcg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7kbYR0IUIzi0OS9PcopS2d7gfUhsTByVYTU35rzkstzUjkE3RshOSJEmH+yAHK0tn9Q7xPHp3wefKCcAeXjVmLJyXjxsahP6FebTwdnjYeCnlxr1VEiZe5tibs0icvzFXCPyK+KXZ/bS5oDYe8txsz/326WWrXPyM4Ff2UPOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3gh1nrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3gh1nrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC011F000FF;
	Mon, 21 Sep 2026 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982334;
	bh=4LTxXwJunFmJBawEuCWVJyl2m7VBlJtDjZw63HpFowk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N3gh1nrCxfv1UbY6Qdvz/HPiDSDf4H5HtjG14cJNtkFmtZ5Z2rdyMP/YBxNSWSNwH
	 x80mnWnrIC5QHo0IJ5Pg2w+Dyy4GdpnQqkLXhztijOCCKYxF1W9BR1DgC9Ni6LzeOJ
	 IEbO36dCsEzvGZqtNRxZP2cVxShcdrJrmm1vX/o0r1xVJdW3rfwkBGy3jVGO2lFSaW
	 ofQyZY5p1b+8W8dmeoCg7EXVvyiztmbWnnYGxnP9nvUwRBRP8eMJisc488DSG8vEDd
	 o1LxFcYJiBxDRpJhvSmKHB6E4bouUvbsk0FG5me0vT7OT3MKjbTV946rdDWtR43HZh
	 YURT8DLMF5U9Q==
Subject: Re: [PATCH net 1/2] net: ngbe: propagate resume errors to the PM core
From: netdev-bot+sashiko@kernel.org
To: zhangyunfei1@kylinos.cn
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 leitao@debian.org, weirongguang@kylinos.cn, u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 09:18:53 +0000
Message-ID: <178998233302.2160803.12428550394082304742@kernel.org>
In-Reply-To: <20260917090050.1927999-2-zhangyunfei1@kylinos.cn>
References: <20260917090050.1927999-2-zhangyunfei1@kylinos.cn>
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
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ngbe_resume() still discards the return value of ngbe_reset_hw()
  (drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:971:…
- [Medium] Commit message overstates what the patch achieves: "A failed
  resume then becomes visible to the PM core and the device can be re-…

Pre-existing issues:
- [High] After a failed resume (either wx_init_interrupt_scheme() or
  ngbe_open() failing in ngbe_resume(), ngbe_main.c:973-976) the netdev…
- [Medium] The same 'swallowed resume error' defect exists in the shared
  libwx VF resume helper wxvf_resume()…
- [Medium] ngbe_open()'s error path — the path whose failure this patch
  now surfaces from ngbe_resume() — frees the Rx/Tx descriptor rings,…

--

net: ngbe: propagate resume errors to the PM core

This changes err in ngbe_resume() from u32 to int and returns err instead
of a hardcoded 0, so that failures from wx_init_interrupt_scheme() or
ngbe_open() reach the PM core. The pci_enable_device_mem() failure path at
the top of the function already propagated its error.

A few questions about the changelog and about what happens on the newly
reachable failure return.

The commit message says:

> Fix the type to int and return err, making the tail of the resume
> path consistent with the pci_enable_device_mem() failure path at
> the top, which already propagates its error. A failed resume then
> becomes visible to the PM core and the device can be re-probed.

[Severity: Medium]
Is the "the device can be re-probed" part accurate?  For the legacy PCI
.resume hook, the return value ends up in device_resume():

drivers/base/power/main.c:device_resume() {
	...
	if (error) {
		WRITE_ONCE(async_error, error);
		dpm_save_failed_dev(dev_name(dev));
		pm_dev_err(dev, state, async ? " async" : "", error);
	}
	...
}

That records and logs the failure, but there is no unbind, no re-probe and
no retry.  ngbe_resume() also does no rollback on the error return: no
pci_disable_device(), no wx_clear_interrupt_scheme(), and the netdev stays
detached while still IFF_UP.

So the user-visible state described earlier in the changelog ("the netdev
never appears in the networking stack again ... the device cannot
self-heal") looks unchanged by this patch, with one extra dmesg line as the
only difference.  Could the last sentence be reworded to claim only what
the code does?

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610c..6d8289e2532d0 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -954,7 +954,7 @@ static int ngbe_resume(struct pci_dev *pdev)
>  {
>  	struct net_device *netdev;
>  	struct wx *wx;
> -	u32 err;
> +	int err;
>  
>  	wx = pci_get_drvdata(pdev);
>  	netdev = wx->netdev;

[Severity: High]
Does the same "silently swallowed" case still exist a few lines further
down in this function?  ngbe_resume() calls ngbe_reset_hw() without
capturing the result, and the next statement overwrites err:

	ngbe_reset_hw(wx);
	rtnl_lock();
	err = wx_init_interrupt_scheme(wx);

ngbe_reset_hw() in ngbe_hw.c has two real error exits:

	ret = wx_stop_adapter(wx);
	if (ret != 0)
		return ret;
	...
		if (ret) {
			wx_err(wx, "Lan reset exceed s maximum times.\n");
			return ret;
		}

On those exits ngbe_reset_misc(), wx_clear_hw_cntrs(), wx_get_mac_addr(),
wx_init_rx_addrs() and pci_set_master() are all skipped.  Execution in
ngbe_resume() continues anyway, wx_init_interrupt_scheme() and ngbe_open()
usually succeed (or ngbe_open() is skipped when the interface is
administratively down), so err is 0, netif_device_attach() runs, and the
new return err reports success even though the MAC never acknowledged the
LAN reset and the MAC/Rx address state was not restored.

ngbe_probe() treats the same call as fatal:

	err = ngbe_reset_hw(wx);
	if (err) {
		dev_err(&pdev->dev, "HW Init failed: %d\n", err);
		goto err_free_mac_table;
	}

Should the resume path check it too, so the bug class this patch targets is
actually closed for the whole function?

> @@ -977,7 +977,7 @@ static int ngbe_resume(struct pci_dev *pdev)
>  		netif_device_attach(netdev);
>  	rtnl_unlock();
>  
> -	return 0;
> +	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch (the pre-patch code reached the
same state, just with err discarded), but what state is the device left in
after this new failure return, and can a later ndo_stop oops?

After wx_init_interrupt_scheme() or ngbe_open() fails here, ngbe_open() was
called directly rather than through dev_open(), so __LINK_STATE_START stays
set and netif_running() remains true, while the datapath resources are
already released.  WX_STATE_RES_FREED, the only guard ngbe_close() has for
"resources already released", is clear: it is set only by
ngbe_down_suspend() and cleared by ngbe_up_complete().

ngbe_close() {
	if (test_bit(WX_STATE_RES_FREED, wx->state))
		goto out;

	wx_ptp_stop(wx);
	ngbe_down(wx);
	wx_free_irq(wx);
	...
}

So the next ip link set dev X down, further suspend via
ngbe_dev_shutdown(), or ngbe_remove() -> unregister_netdev() runs the full
teardown a second time over released objects:

ngbe_close() -> ngbe_down() -> wx_clean_all_rx_rings() -> wx_clean_rx_ring()
	/* Zero out the descriptor ring */
	memset(rx_ring->desc, 0, rx_ring->size);

rx_ring->desc was set to NULL by wx_free_rx_resources() while
rx_ring->size stays non-zero, so this is a write through NULL.

When wx_init_interrupt_scheme() was the failing call, the ring loops also
dereference NULL, since wx_set_num_queues() restored num_tx_queues while
the suspend-time wx_clear_interrupt_scheme() left every ring pointer NULL:

wx_clean_all_tx_rings() {
	for (i = 0; i < wx->num_tx_queues; i++)
		wx_clean_tx_ring(wx->tx_ring[i]);
}

And wx_free_irq() would call free_irq() for an IRQ that is not registered
("Trying to free already-free IRQ" warning).  Would it make sense to unwind
the resume failure here, or to set WX_STATE_RES_FREED on this path?

[Severity: Medium]
This is a pre-existing issue, but the failure that this patch now surfaces
comes from ngbe_open(), whose error path frees the Rx/Tx descriptor rings,
the page-pool pages and the ISB coherent buffer without stopping the
hardware that wx_configure() just armed:

ngbe_open() {
	...
	wx_configure(wx);

	err = ngbe_request_irq(wx);
	if (err)
		goto err_free_resources;
	...
err_free_resources:
	wx_free_isb_resources(wx);
	wx_free_resources(wx);
	...
}

wx_configure() -> wx_configure_rx_ring() programs the ring base addresses,
enables the queue and posts buffers:

	wr32(wx, WX_PX_RR_BAL(reg_idx), rdba & DMA_BIT_MASK(32));
	wr32(wx, WX_PX_RR_BAH(reg_idx), upper_32_bits(rdba));
	...
	wr32m(wx, WX_PX_RR_CFG(reg_idx), WX_PX_RR_CFG_RR_EN, WX_PX_RR_CFG_RR_EN);
	wx_enable_rx_queue(wx, ring);
	wx_alloc_rx_buffers(ring, wx_desc_unused(ring));

and wx_configure_isb() writes WX_PX_ISB_ADDR_L/H with wx->isb_dma.  The
error labels only free memory: there is no ngbe_down(), wx_stop_adapter(),
wx_disable_rx() or wx_disable_rx_queue(), and no re-reset, so RXEN, the
per-queue enables and the stale descriptor/ISB base addresses stay
programmed with bus mastering on while the memory is released.

Can the Rx engine write into those released page-pool pages afterwards?  I
could not confirm that frames arrive in this window, since phylink_start()
is only reached from ngbe_up_complete(), so the link may still be down.
Would a stop/reset in the ngbe_open() error path be worth adding while this
path is being made reachable through a reported resume failure?

>  
>  static struct pci_driver ngbe_driver = {

[Severity: Medium]
This isn't a bug introduced by this patch, but was the sibling VF resume
helper considered?  wxvf_resume() in libwx/wx_vf_common.c has the same
pattern this patch removes from ngbe_resume():

int wxvf_resume(struct device *dev_d)
{
	...
	pci_set_master(pdev);
	wx_init_interrupt_scheme(wx);
	netif_device_attach(wx->netdev);

	return 0;
}

The wx_init_interrupt_scheme() return value is dropped, the netdev is
attached regardless, and 0 is returned.  That helper is the system-sleep
resume callback for both ngbevf and txgbevf:

	static DEFINE_SIMPLE_DEV_PM_OPS(ngbevf_pm_ops, wxvf_suspend, wxvf_resume);
	static DEFINE_SIMPLE_DEV_PM_OPS(txgbevf_pm_ops, wxvf_suspend, wxvf_resume);

The VF case looks worse than the PF one, because wxvf_suspend() calls
wx_clear_interrupt_scheme() (rings NULLed, queue counts zeroed) and
wxvf_resume() attaches the netdev even when the interrupt scheme was not
re-established.  Should the two implementations of the same resume contract
be fixed together, or is there a reason the VF path is left as is?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917090050.1927999-1-zhangyunfei1%40kylinos.cn
