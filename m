Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5F2D77F7;
	Fri, 25 Sep 2026 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333180; cv=none; b=Rn4xXRlvREMPB/SBzxf6UEeFRsZToDRFlEmKd4r1VYRoXkWE/iJ0rM0TTxcKGtH19EzbI3UsAsz2YNvdfwtK83im9Q9H9F0ZRBjwBEV9mscTophj15fB4KJv8Xbv1+EsKm+N3slpFr/oHAYyYI5vjc5NSDSH6MpCW8Cbw0MlShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333180; c=relaxed/simple;
	bh=2lKt4c/vfsu9OfWC/u19AxErVtZu/qK9ZsX9vmcawdc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpyxgDj+xlGaCJcaa/qYNnLgJOMI5bjZzszVzLizof1Du2F+QZX7rw7nLwXj79AB0TeLmYn+0kpjwjSA8f8Quh/bcY1LnLbM/cityzJZu87bvv8b7TCBZbMc0K4he7D2ogq4a5xJH10ncvFXIq1jazXQymv1yLOHEpVSnslskow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRmJQfaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRmJQfaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90B61F000FF;
	Fri, 25 Sep 2026 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333178;
	bh=1VwF+hLDno752D19CuJoF+pVTP6WmDW1Gu138xTY20M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mRmJQfaW//8J82wxaVXzM5PL/6DCRm+NTvEbiSxEdtR2B+zO/VQ0H3SfwF1B5YH7T
	 nd6h46/Sg2FyNHAonhQtWjVq9D5fLVQx7GemOrcSKk9CNEXstI44tQvfgg6lGBxVNp
	 lWyLM26vhmC0ptzerLCoRj2HAMHReTzkVP+wr0qVSS9yr5uO5eaZBhvKf+KoVuH9ZL
	 bjgr3jpxvoxPfA1/f9XDp7q1EFXFyIix5DpP5rZziXn6DEgWzFQXYycmOrfXDoqCrL
	 G1TXFvGlzIDwOZsJdjwkjwkLngbKXlrpBOFglrkVzUJdsu7qYAnmVnMGN/NrpFNVy2
	 DrZYFjKr2SuAA==
Subject: Re: [PATCH net 1/3] net: fealnx: fix teardown order in remove
From: netdev-bot+sashiko@kernel.org
To: r.zhambakiev@prosoftsystems.ru
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, benato.denis96@gmail.com,
 jacob.e.keller@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 10:46:17 +0000
Message-ID: <179033317745.2160803.17677672986489038086@kernel.org>
In-Reply-To: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit says unregister_netdev() -> dev_close() ->
  netdev_close() "deletes the timers ... before the rings are freed".
- [High] The fix assumes that once unregister_netdev() returns,
  netdev_close() has stopped the Rx/Tx DMA engines, so…

Pre-existing issues:
- [Low] At this commit, fealnx_init_one() calls pci_enable_device() and
  pci_set_master() (lines 497/499).

--

net: fealnx: fix teardown order in remove

This patch reorders fealnx_remove_one() so unregister_netdev() runs before
the Tx/Rx descriptor rings are freed. The intent is for netdev_close() to
stop the hardware, delete the timers and free the IRQ first. It also
changes the unknown-device printk() to dev_err().

> diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
> index bdc38aac5850..d7cd1644a375 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c
> @@ -678,20 +678,23 @@ static int fealnx_init_one(struct pci_dev *pdev,
>  static void fealnx_remove_one(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);

[ ... ]

> -	if (dev) {
> -		struct netdev_private *np = netdev_priv(dev);
> -
> -		dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
> -				  np->tx_ring_dma);
> -		dma_free_coherent(&pdev->dev, RX_TOTAL_SIZE, np->rx_ring,
> -				  np->rx_ring_dma);
> -		unregister_netdev(dev);
> -		pci_iounmap(pdev, np->mem);
> -		free_netdev(dev);
> -		pci_release_regions(pdev);
> -	} else
> -		printk(KERN_ERR "fealnx: remove for unknown device\n");
> +	unregister_netdev(dev);

[Severity: High]
The commit message says:

  "Call unregister_netdev() first so dev_close() stops the Tx/Rx
  engines, deletes the timers, and frees the IRQ before the rings are
  freed."

Can reset_timer still be pending when free_netdev() runs below?

netdev_close() cancels the timers before it frees the IRQ, and it never
takes np->lock:

drivers/net/ethernet/fealnx.c:netdev_close() {
    ...
	iowrite32(0x0000, ioaddr + IMR);
	stop_nic_rxtx(ioaddr, 0);

	timer_delete_sync(&np->timer);
	timer_delete_sync(&np->reset_timer);

	free_irq(np->pci_dev->irq, dev);
    ...
}

intr_handler() is registered with IRQF_SHARED and may still be running on
another CPU. When it uses up max_interrupt_work, it arms the timer:

drivers/net/ethernet/fealnx.c:intr_handler() {
    ...
		if (--boguscnt < 0) {
			...
			if (!np->reset_timer_armed) {
				np->reset_timer_armed = 1;
				np->reset_timer.expires = RUN_AT(HZ/2);
				add_timer(&np->reset_timer);
    ...
}

The handler can also stay busy during close. Its RBU path and netdev_rx()
write np->crvalue, which still has RXEN/TXEN set, back into TCRRCR.

One possible sequence:

CPU A                                  CPU B
netdev_close()                         intr_handler()
  timer_delete_sync(&np->reset_timer)
    (nothing pending yet)
                                         add_timer(&np->reset_timer)
  free_irq()
    (waits for CPU B to leave handler)
fealnx_remove_one()
  dma_free_coherent(tx_ring, rx_ring)
  pci_iounmap()
  free_netdev()

free_netdev() frees netdev_private, and the pending reset_timer is embedded
in it. About HZ/2 later, reset_timer() runs on the freed np. It calls
reset_and_disable_rxtx() and then enable_rxtx(). Those write the freed
np->tx_ring_dma and np->rx_ring_dma into TXLBA and RXLBA through the stale
np->mem mapping, and they turn Rx/Tx and IMR back on.

Would netdev_close() need to quiesce the IRQ first, with free_irq() or
synchronize_irq(), and then call timer_shutdown_sync() on both timers?
Alternatively, intr_handler() could be stopped from re-arming the timer
under np->lock during close.

> +	dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
> +			  np->tx_ring_dma);
> +	dma_free_coherent(&pdev->dev, RX_TOTAL_SIZE, np->rx_ring,
> +			  np->rx_ring_dma);

[Severity: High]
Are the Tx/Rx DMA engines guaranteed to be stopped when these rings are
freed?

netdev_close() calls stop_nic_rxtx(ioaddr, 0) and sets IMR to 0 before it
quiesces the contexts that can turn the engines back on. It also leaves
np->crvalue and np->imrvalue unchanged, so RXEN/TXEN and the interrupt mask
are still set there. Each of these paths can undo the stop.

netdev_timer(), on link-up with a crvalue change:

			if (np->crvalue != old_crvalue) {
				stop_nic_rxtx(ioaddr, np->crvalue);
				iowrite32(np->crvalue, ioaddr + TCRRCR);
			}

reset_timer()->enable_rxtx(), which reprograms TXLBA/RXLBA, BCR and TCRRCR
(through __set_rx_mode()) and then does:

	iowrite32(np->imrvalue, ioaddr + IMR);

intr_handler(), on RBU (and similarly from netdev_rx()):

				iowrite32(np->crvalue, ioaddr + TCRRCR);

and on every exit from the handler:

	iowrite32(np->imrvalue, ioaddr + IMR);

timer_delete_sync() and free_irq() wait for these paths to finish, but
they do not undo the register writes. After that, neither netdev_close()
nor fealnx_remove_one() resets the chip (BCR bit 0) or stops the engines
again.

That means the rings can be freed here while the device is still reading
and writing descriptors in them. The Rx buffers were already unmapped and
freed in netdev_close(). Even with the later patch in this series,
pci_disable_device(), which clears bus mastering, still runs only after
dma_free_coherent().

Should the chip be stopped or reset after the IRQ and both timers are
quiesced, and before the rings are freed?

> +	pci_iounmap(pdev, np->mem);
> +	pci_release_regions(pdev);

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. The
rewritten remove sequence still has no pci_disable_device().

fealnx_init_one() calls pci_enable_device() and pci_set_master(), and
nothing undoes them. The early error returns skip it:

drivers/net/ethernet/fealnx.c:fealnx_init_one() {
    ...
	i = pci_enable_device(pdev);
	if (i) return i;
	pci_set_master(pdev);

	len = pci_resource_len(pdev, bar);
	if (len < MIN_REGION_SIZE) {
		...
		return -ENODEV;
	}

	i = pci_request_regions(pdev, boardname);
	if (i)
		return i;
    ...
}

The goto unwind also ends at err_out_res -> pci_release_regions() without
disabling the device. So enable_cnt is left unbalanced, and bus mastering
stays on after unbind or a failed probe.

The later patch in this series, "net: fealnx: disable the PCI device on
remove and probe failure", already fixes this. It adds an err_out_disable
label to the probe unwind and calls pci_disable_device() in
fealnx_remove_one().

> +	free_netdev(dev);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924104231.110576-1-r.zhambakiev%40prosoftsystems.ru
